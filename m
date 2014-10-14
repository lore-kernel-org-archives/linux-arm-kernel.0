From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Oct 2014 11:12:58 +0200
Subject: [PATCH 5/8] ARM: ux500: Add DT node for ux500 PM domains
In-Reply-To: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
References: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413277981-27451-6-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT node for the ux500 PM domains. Follow the DT semantics of the
generic PM domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 9d23230..d416974 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -43,6 +43,10 @@
 			interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pm_domains: pm_domains0 {
+			compatible = "stericsson,ux500-pm-domains";
+			#power-domain-cells = <1>;
+		};
 
 		clocks {
 			compatible = "stericsson,u8500-clks";
-- 
1.9.1
