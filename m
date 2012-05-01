From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Tue,  1 May 2012 12:47:40 -0500
Subject: [PATCH 2/2] arm/dts: OMAP2+: Add mailbox nodes
In-Reply-To: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
References: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
Message-ID: <1335894460-19941-3-git-send-email-omar.luna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for mailbox DT, to interface with hwmods.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/boot/dts/omap2.dtsi |    5 +++++
 arch/arm/boot/dts/omap3.dtsi |    5 +++++
 arch/arm/boot/dts/omap4.dtsi |    5 +++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index f2ab4ea..2175cc3 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -46,6 +46,11 @@
 			#interrupt-cells = <1>;
 		};
 
+		mailbox: mailbox at 48094000 {
+			compatible = "ti,omap2-mailbox";
+			ti,hwmods = "mailbox";
+		};
+
 		uart1: serial at 4806a000 {
 			compatible = "ti,omap2-uart";
 			ti,hwmods = "uart1";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index c612135..540f6d6 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -69,6 +69,11 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		mailbox: mailbox at 48094000 {
+			compatible = "ti,omap3-mailbox";
+			ti,hwmods = "mailbox";
+		};
+
 		uart1: serial at 4806a000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart1";
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 3d35559..84f27dd 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -104,6 +104,11 @@
 			      <0x48240100 0x0100>;
 		};
 
+		mailbox: mailbox at 4a0f4000 {
+			compatible = "ti,omap4-mailbox";
+			ti,hwmods = "mailbox";
+		};
+
 		uart1: serial at 4806a000 {
 			compatible = "ti,omap4-uart";
 			ti,hwmods = "uart1";
-- 
1.7.4.1
