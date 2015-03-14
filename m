From: amstan@chromium.org (Alexandru M Stan)
Date: Fri, 13 Mar 2015 17:55:31 -0700
Subject: [PATCH 0/1] ARM: dts: rockchip: disable gmac by default in rk3288.dtsi
Message-ID: <1426294532-32078-1-git-send-email-amstan@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The way it is right now, each board using rk3288.dtsi has to disable
it or else (given CONFIG_DWMAC_RK is set) it will try loading the driver
and looking for phy's even though none are connected.

The status should be "disabled".

PS: I'm ok with "the big relicensing"
(http://www.spinics.net/lists/arm-kernel/msg403629.html) to GPLv2/X11.


Alexandru M Stan (1):
  ARM: dts: rockchip: disable gmac by default in rk3288.dtsi

 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

-- 
2.2.0.rc0.207.ga3a616c
