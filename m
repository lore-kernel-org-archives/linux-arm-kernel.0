From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 17 Jul 2015 16:08:04 -0500
Subject: [PATCH 4/4] ARM: dts: AM4372: Add the wkup_m3_ipc node
In-Reply-To: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
References: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1437167284-25659-5-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suman Anna <s-anna@ti.com>

Add the Wakeup M3 IPC device node for the wkup_m3_ipc driver on
AM4372 SoC. This node uses the IPC registers, part of the Control
Module, and is therefore added as a child of the scm node.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 5bccc48..45bcd1b 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -136,6 +136,14 @@
 					};
 				};
 
+				wkup_m3_ipc: wkup_m3_ipc at 1324 {
+					compatible = "ti,am4372-wkup-m3-ipc";
+					reg = <0x1324 0x44>;
+					interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+					ti,rproc = <&wkup_m3>;
+					mboxes = <&mailbox &mbox_wkupm3>;
+				};
+
 				scm_clockdomains: clockdomains {
 				};
 			};
-- 
2.4.5
