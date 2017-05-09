From: olof@lixom.net (Olof Johansson)
Date: Mon,  8 May 2017 23:52:46 -0700
Subject: [GIT PULL 0/7] ARM: SoC contents for 4.12 merge window
Message-ID: <1494312773-9790-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

It's been a relatively quiet release cycle here. Patch count is about
the usual (818 commits, which includes merges). Accumulated diffstat:

 683 files changed, 28234 insertions(+), 7251 deletions(-)

Dirstat is also more or less as we're used to it these days. Since arm's dts
structure is flat, it's all in one directory but arm64 sums up to 33.6%.

  42.5% arch/arm/boot/dts/
   5.6% arch/arm/mach-gemini/
   5.5% arch/arm/
   3.2% arch/arm64/boot/dts/amlogic/
   9.4% arch/arm64/boot/dts/freescale/
   4.2% arch/arm64/boot/dts/hisilicon/
   8.4% arch/arm64/boot/dts/rockchip/
   8.1% arch/arm64/boot/dts/
   1.1% drivers/ata/
   1.5% drivers/reset/
   2.3% drivers/soc/imx/
   2.8% drivers/soc/

So, not a tiny set of branches, but also not huge.

Besides dts, the mach-gemini cleanup by Linus Walleij is the only
platform that pops up on its own. Driver changes are some moves out
from mach-hosted drivers, some new drivers (ata are acked by Tejun), the
usual drivers/reset branch we merge, and general tweaks for SoC support.

Only a few conflicts; all are from developers sending DT changes to driver
maintainers. We're trying to avoid that since it's needless conflicts --
DT contents should flow in through us. But these ones are all easy to
resolve so it's not a big deal. See dt and dt64 emails for details.

A handful of new platforms this merge window:
 - Renesas RZ/G1H and G1N
 - Rockchip RK3399 support, including Samsung Chromebook Plus ("Kevin").
 - Rockchip RK3288 support for ASUS Tinkerboard and a couple of Phytec boards
 - A handful of wireless basestations and other appliances, several based
   on Marvell and Qualcomm SoCs.
 - i.MX28 "Duckbill" platforms
 - A couple of i.MX6Q platforms from Zodiac Inflight Innovations, which seems
   to a couple of those tablet-like inflight entertainment systems that are
   becoming popular.
 - Motorola Droid4, an old OMAP-based phone that some people might have at
   the bottom of their old hardware piles, sees a bunch of mainline support
   additions.
 - Nvidia Tegra186 ("Parker", used for Jetson TX2)
 - ST Micro STM32H743 support has been added

In addition to these 7 branches, there'll be one more with the TEE
subsystem, which we broke out in a separate branch this merge window as
it's introduced; it's likely to go into our driver aggregation branch
for the future. Arnd has a tag writeup and will send that separately.


Please merge!

Thanks,

-Olof
