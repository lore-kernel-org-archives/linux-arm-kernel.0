From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Mar 2017 16:53:01 +0800
Subject: [PATCH 3/3] arm64: dts: zte: add tvenc device for zx296718
In-Reply-To: <1490086381-17030-1-git-send-email-shawnguo@kernel.org>
References: <1490086381-17030-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1490086381-17030-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds VOU tvenc device in zx296718.dtsi, so that boards with TV
connector can enable the support by changing 'status' in board DTS file.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 7b2bb962daf1..358b78b9437e 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -398,6 +398,13 @@
 				#sound-dai-cells = <0>;
 				status = "disabled";
 			};
+
+			tvenc: tvenc at 2000 {
+				compatible = "zte,zx296718-tvenc";
+				reg = <0x2000 0x1000>;
+				zte,tvenc-power-control = <&sysctrl 0x170 0x10>;
+				status = "disabled";
+			};
 		};
 
 		topcrm: clock-controller at 1461000 {
-- 
1.9.1
