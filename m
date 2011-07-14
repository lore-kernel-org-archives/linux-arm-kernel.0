From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jul 2011 08:34:53 +0100
Subject: [PATCH] ARM: move memory layout sanity checking before meminfo
	initialization
In-Reply-To: <CAMbhsRRQ9D+VXTZP3vB7egkROEtN9-FxssFa2EcxuqB3F-Uv6Q@mail.gmail.com>
References: <20110705185758.GI8286@n2100.arm.linux.org.uk>
	<CAMbhsRRQ9D+VXTZP3vB7egkROEtN9-FxssFa2EcxuqB3F-Uv6Q@mail.gmail.com>
Message-ID: <20110714073453.GK23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 11:52:21PM -0700, Colin Cross wrote:
> On Tue, Jul 5, 2011 at 11:57 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Ensure that the meminfo array is sanity checked before we pass the
> > memory to memblock. ?This helps to ensure that memblock and meminfo
> > agree on the dimensions of memory, especially when more memory is
> > passed than the kernel can deal with.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> This patch causes a regression in v3.0-rc7 when overlapping mem=
> options are passed to the kernel.  On an OMAP4 board, I was
> accidentally using "mem=512M mem=920M" on the command line, which
> works fine in v3.0-rc6.

I don't regard that as a regression.  That's something which hasn't
been supported before the move to memblock, and it's not something
that was not intended to be supported.
