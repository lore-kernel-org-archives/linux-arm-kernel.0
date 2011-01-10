From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jan 2011 22:18:02 +0000
Subject: [PATCH] spi: tegra: don't treat NULL clk as an error
In-Reply-To: <AANLkTikd7AZv+-aVf4=jwF+xjvq+1k_kAwLPz-+yP6=Q@mail.gmail.com>
References: <1294657506-27510-1-git-send-email-jamie@jamieiles.com>
	<AANLkTikd7AZv+-aVf4=jwF+xjvq+1k_kAwLPz-+yP6=Q@mail.gmail.com>
Message-ID: <20110110221802.GD12552@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 01:58:12PM -0700, Grant Likely wrote:
> On Mon, Jan 10, 2011 at 4:05 AM, Jamie Iles <jamie@jamieiles.com> wrote:
> > Some platforms have been known to return NULL from clk_get() if they
> > support only a single struct clk. ?Whilst tegra doesn't do this, make
> > the drivers consistent with others.
> >
> > Cc: Erik Gilling <konkers@android.com>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> 
> Hi James,
> 
> If NULL does get returned, say due to a future change to the clock
> code, then this change causes the driver to oops.  I'm not going to
> apply this patch.

Please apply it - the clock API just defines struct clk as a cookie
where errors are IS_ERR/PTR_ERR.  Other values must be considered by
drivers as perfectly valid, including NULL.
