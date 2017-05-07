From: ayaka@soulik.info (Randy Li)
Date: Sun,  7 May 2017 22:46:31 +0800
Subject: [PATCH 0/2] the supporting for eDP panel of Firefly
Message-ID: <20170507144633.11714-1-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the IRQ deadlock issue is solved, I can finally offer the supporting
of the eDP panel sold by the T-CHIP Firefly.

I don't think it is necessary to enable two vop for a eDP panel, even
the vop lite is enough for the resolution of this panel.

I have verified those patch with the kmssink from Gstreamer.
but I still got a few warnings message, those message comes from booting time.

[   10.623207] rockchip-drm display-subsystem: fb0:  frame buffer device
[   10.633680] rockchip-dp ff970000.dp: AUX CH command reply failed!
[   10.646828] rockchip-dp ff970000.dp: AUX CH command reply failed!
[   10.647440] [drm] Initialized rockchip 1.0.0 20140818 for display-subsystem on minor 0
[   10.663870] rockchip-dp ff970000.dp: Rx Max Link Rate is abnormal :11 !
[   10.673188] rockchip-dp ff970000.dp: Link Training Clock Recovery success
[   10.682980] rockchip-dp ff970000.dp: Link Training success!
[   10.794103] rockchip-dp ff970000.dp: Timeout of video streamclk ok
[   10.801090] rockchip-dp ff970000.dp: unable to config video
[   11.330781] EXT4-fs (mmcblk0p7): re-mounted. Opts: data=ordered

You may need the following patch to make PWM backlight work, or merge it
into the bootloader.
ARM: rockchip: rk3288: Switch to use the proper PWM IP

Randy Li (2):
  ARM: dts: rockchip: add eDP panel support for Firefly
  ARM: dts: rockchip: enable eDP panel at Firefly Release

 arch/arm/boot/dts/rk3288-firefly.dts  | 28 +++++++++++
 arch/arm/boot/dts/rk3288-firefly.dtsi | 92 +++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

-- 
2.9.3
