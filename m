From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 16:31:24 +0100
Subject: [PATCH 2/2] ARM: Switch to using CLKDEV_INIT macro for
	creating clk_lookup instance
In-Reply-To: <20110930112633.GB9046@local>
References: <1317381097-2691-1-git-send-email-padma.v@samsung.com>
	<1317381097-2691-3-git-send-email-padma.v@samsung.com>
	<20110930112633.GB9046@local>
Message-ID: <20111001153123.GE11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 01:26:33PM +0200, Hans J. Koch wrote:
> On Fri, Sep 30, 2011 at 04:41:37PM +0530, Padmavathi Venna wrote:
> > Replace platform specific macros that creates struct clk_lookup
> > instance with the new common CLKDEV_INIT macro
> 
> Well, for mach-tcc8k, it only saves 7 lines, but it's surely a good idea to
> have one common macro for all arm subarchs.

The savings are of course likely to be small, but it had two advantages:

1. We're not having one initializer per platform or SoC
2. We have something common which can be grepped for, or sed'd (or whatever
   your favourite in-place editing program) should it need to be changed.
