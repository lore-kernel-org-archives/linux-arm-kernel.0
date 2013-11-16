From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 16 Nov 2013 23:28:35 +0800
Subject: [PATCH] ARM: dts: imx6qdl: disable spdif "rxtx5" clock option
In-Reply-To: <20131116151331.GW16735@n2100.arm.linux.org.uk>
References: <1384614847-22905-1-git-send-email-shawn.guo@linaro.org>
 <20131116151331.GW16735@n2100.arm.linux.org.uk>
Message-ID: <20131116152834.GK11014@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 03:13:31PM +0000, Russell King - ARM Linux wrote:
> On Sat, Nov 16, 2013 at 11:14:07PM +0800, Shawn Guo wrote:
> > The spdif "rxtx5" clock option is being set to ipg clk (62) by mistake.
> > This causes an incorrect time keeping when spdif driver is running,
> > because ipg is ancestor clock for clocksource while spdif driver will
> > change the rate of this clock in certain circumstance.  Before the
> > correct clock for "rxtx5" option can be supplied, let's disable this
> > option for now by filling a dummy clock for it.
> 
> Strangely, this looks exactly like the change I made here :)

Yeah, I tried very hard to find a different quick fix from the one in
your bug report, but failed :)  I should mention it's your change.

Shawn
