From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  9 Mar 2015 17:40:33 +0100
Subject: [PATCH 0/3] Disable PWMs in imx6ql.dtsi
Message-ID: <1425919236-6664-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

PWMs are only useful if they have an output pin connected. Since
most boards don't have all of the PWM output pins assigned, let's
disable the PWMs by default in imx6qdl.dtsi and have each board
device tree explicitly enable just the PWMs they need.
Most device trees do this already - add the missing ones and
change the default status to "disabled" in the dtsi.

regards
Philipp

Philipp Zabel (3):
  ARM: dts: imx6dl-aristainetos: enable backlight PWM explicitly
  ARM: dts: hummingboard/cubox-i: enable front LED PWM explicitly
  ARM: dts: imx6qdl: disable PWMs by default

 arch/arm/boot/dts/imx6dl-aristainetos_4.dts | 4 ++++
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts | 4 ++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi      | 4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi              | 4 ++++
 4 files changed, 16 insertions(+)

-- 
2.1.4
