From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jan 2011 23:30:33 +0000
Subject: [PATCH] spi: tegra: don't treat NULL clk as an error
In-Reply-To: <AANLkTinOWvu5TNMtsrw19-ERc1JpopvQkyp0QH3sQpkL@mail.gmail.com>
References: <1294657506-27510-1-git-send-email-jamie@jamieiles.com>
	<AANLkTikd7AZv+-aVf4=jwF+xjvq+1k_kAwLPz-+yP6=Q@mail.gmail.com>
	<20110110221802.GD12552@n2100.arm.linux.org.uk>
	<20110110222524.GE12552@n2100.arm.linux.org.uk>
	<AANLkTinOWvu5TNMtsrw19-ERc1JpopvQkyp0QH3sQpkL@mail.gmail.com>
Message-ID: <20110110233033.GG12552@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 04:24:17PM -0700, Grant Likely wrote:
> I was actually looking at the implementation of clk_enable() which is
> called by the driver and doesn't do any NULL checking.  But I suppose
> that it then becomes the clock-code's own fault if it returns NULL and
> then oopses on a NULL being passed to it.  Okay, I'll apply it.

Yes absolutely.  The clk API must eat whatever cookies it produces,
even if they contain dead flies rather than currants. ;)
