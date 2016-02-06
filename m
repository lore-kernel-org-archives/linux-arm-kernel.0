From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Feb 2016 23:53:43 +0800
Subject: [PATCH 0/6] ARM: defconfig: Enable recently merged drivers for sunxi
Message-ID: <1454774029-10469-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series enables drivers for devices that are likely to be used on sunxi.
This includes the IR receiver, audio codec, USB OTG, and also enabling input
device interface in userspace so the power button works.

The patches are self-explanatory.

MUSB for USB OTG is enabled only now because it used to require USB gadget
drivers as modules to work reliably. It was an issue of probe ordering. This
has since been fixed (or worked around) in 4.5-rc1.

The IR receiver driver isn't enabled for multi_v7_defconfig, as I didn't see
any others enabled. On the other hand, MUSB is enabled, because for tablets
this is likely the only option for external USB peripherals.

Regards
ChenYu


Chen-Yu Tsai (6):
  ARM: sunxi_defconfig: Enable sunxi IR driver
  ARM: sunxi_defconfig: Enable A10 audio codec driver
  ARM: sunxi_defconfig: Enable MUSB HDRC driver with Allwinner glue
  ARM: sunxi_defconfig: Enable INPUT_EVDEV so axp20x-pek can be used
  ARM: multi_v7_defconfig: Enable A10 audio codec driver as module
  ARM: multi_v7_defconfig: Enable MUSB HDRC driver with Allwinner glue

 arch/arm/configs/multi_v7_defconfig |  3 +++
 arch/arm/configs/sunxi_defconfig    | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

-- 
2.7.0
