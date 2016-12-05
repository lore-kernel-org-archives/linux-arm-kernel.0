From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Mon,  5 Dec 2016 16:17:51 +0800
Subject: [PATCH v2] arm64: dts: zx: add pcu_domain node for zx296718
Message-ID: <1480925871-20855-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the pcu_domain node, so it can be used
by zte-soc's power domain driver.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index b44d1d1..1aa0587 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -302,6 +302,11 @@
 			reg = <0x116000 0x1000>;
 		};
 
+		pcu_domain: pcu at 117000 {
+			compatible = "zte,zx296718-pcu";
+			reg = <0x00117000 0x1000>;
+		};
+
 		uart0: uart at 11f000 {
 			compatible = "arm,pl011", "arm,primecell";
 			arm,primecell-periphid = <0x001feffe>;
-- 
2.7.4
