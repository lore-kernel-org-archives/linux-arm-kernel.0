From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 Nov 2013 15:13:31 +0000
Subject: [PATCH] ARM: dts: imx6qdl: disable spdif "rxtx5" clock option
In-Reply-To: <1384614847-22905-1-git-send-email-shawn.guo@linaro.org>
References: <1384614847-22905-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20131116151331.GW16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 11:14:07PM +0800, Shawn Guo wrote:
> The spdif "rxtx5" clock option is being set to ipg clk (62) by mistake.
> This causes an incorrect time keeping when spdif driver is running,
> because ipg is ancestor clock for clocksource while spdif driver will
> change the rate of this clock in certain circumstance.  Before the
> correct clock for "rxtx5" option can be supplied, let's disable this
> option for now by filling a dummy clock for it.

Strangely, this looks exactly like the change I made here :)

Thanks Shawn.
