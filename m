From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 15 Jan 2013 14:12:58 +0530
Subject: [RFC PATCH 7/7] ARM: dts: omap: Add omap control usb data
In-Reply-To: <1358239378-10030-1-git-send-email-kishon@ti.com>
References: <1358239378-10030-1-git-send-email-kishon@ti.com>
Message-ID: <1358239378-10030-8-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add omap control usb data in omap4 device tree file. This will have the
register address of registers to power on the PHY and to write to
mailbox.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index b7e2ba3..5d770be 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -545,5 +545,13 @@
 			ram_bits = <12>;
 			ti,has_mailbox;
 		};
+
+		omap_control_usb at 4a002300 {
+			compatible = "ti,omap-control-usb";
+			reg = <0x4a002300 0x4>,
+			      <0x4a00233c 0x4>;
+			reg-names = "control_dev_conf", "otghs_control";
+			ti,has_mailbox;
+		};
 	};
 };
-- 
1.7.9.5
