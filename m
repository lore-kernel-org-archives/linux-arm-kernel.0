From: dhdang@apm.com (Duc Dang)
Date: Fri, 12 Feb 2016 19:39:28 -0800
Subject: [PATCH v6 3/3] arm64: dts: mailbox device tree node for APM X-Gene
 platform.
In-Reply-To: <cover.1455333720.git.dhdang@apm.com>
References: <cover.1455333720.git.dhdang@apm.com>
Message-ID: <eeac516f6daa15b22a1c448160ed40991833035a.1455333720.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mailbox device tree node for APM X-Gene platform.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Duc Dang <dhdang@apm.com>
---
Changes since v5:
	- None

Changes since v4:
        - Rebase over v4.5-rc1
        - Change node name to mailbox at 10540000

Changes since v3:
        - Rebase over v4.4

 arch/arm64/boot/dts/apm/apm-storm.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index fe30f76..d91338a 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -691,6 +691,20 @@
 			msi-parent = <&msi>;
 		};
 
+		mailbox: mailbox at 10540000 {
+			compatible = "apm,xgene-slimpro-mbox";
+			reg = <0x0 0x10540000 0x0 0xa000>;
+			#mbox-cells = <1>;
+			interrupts =    <0x0 0x0 0x4>,
+					<0x0 0x1 0x4>,
+					<0x0 0x2 0x4>,
+					<0x0 0x3 0x4>,
+					<0x0 0x4 0x4>,
+					<0x0 0x5 0x4>,
+					<0x0 0x6 0x4>,
+					<0x0 0x7 0x4>;
+		};
+
 		serial0: serial at 1c020000 {
 			status = "disabled";
 			device_type = "serial";
-- 
1.9.1
