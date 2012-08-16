From: anilkumar@ti.com (AnilKumar Ch)
Date: Thu, 16 Aug 2012 17:50:07 +0530
Subject: [PATCH v4 1/4] arm/dts: AM33XX: Add basic pinctrl device tree data
In-Reply-To: <1345119610-5247-1-git-send-email-anilkumar@ti.com>
References: <1345119610-5247-1-git-send-email-anilkumar@ti.com>
Message-ID: <1345119610-5247-2-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds basic pinctrl device tree data for AM33XX family of devices.
This patch is based on the pinctrl-single driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
Changes from v3:
	- Updated the reg length based on latest AM335x TRM.

Changes from v2:
	- user led pinmux comments updated according to Tony's
	  comment.

Changes from v1:
	- Rebased the patches based on latest pinctrl-single driver

 arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index dde76f7..dfe9c559 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -40,6 +40,15 @@
 		};
 	};
 
+	am3358_pinmux: pinmux at 44E10800 {
+		compatible = "pinctrl-single";
+		reg = <0x44E10800 0x0238>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x7F>;
+	};
+
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex.Since
-- 
1.7.9.5
