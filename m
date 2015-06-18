From: scott.shu@mediatek.com (Scott Shu)
Date: Thu, 18 Jun 2015 11:35:19 +0800
Subject: [PATCH 1/6] Document: bindings: DT: Add SMP enable method for MT6580
 SoC platform
In-Reply-To: <1434598524-43846-1-git-send-email-scott.shu@mediatek.com>
References: <Scott Shu <srv_scott.shu@mediatek.com>
 <1434598524-43846-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1434598524-43846-2-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For MT6580 SoC platform, the secondary cores are in powered off state
as default, so compared with MT65xx series SoC, one new enable method
is needed. This method using the SPM (System Power Manager) inside
the SCYSYS to control the CPU power.
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index ac2903d..fb80b2e 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -194,6 +194,7 @@ nodes to be present and contain the properties described below.
 			    "marvell,armada-380-smp"
 			    "marvell,armada-390-smp"
 			    "marvell,armada-xp-smp"
+			    "mediatek,mt6580-smp"
 			    "mediatek,mt65xx-smp"
 			    "mediatek,mt81xx-tz-smp"
 			    "qcom,gcc-msm8660"
-- 
1.8.1.1.dirty
