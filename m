From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 19 Oct 2017 13:26:09 +0200
Subject: [RFC resend 3/4] arm64: dts: mt8173: Fix drm subsystem
In-Reply-To: <20171019112610.13645-1-mbrugger@suse.com>
References: <20171019112610.13645-1-mbrugger@suse.com>
Message-ID: <20171019112610.13645-4-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRM subysystem and clock driver shared the same compatible mmsys.
This stopped does not work, as only the first driver for a compatible
gets probed. We change the comaptible to the new DRM identifier to fix
this.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index b99a27372965..89db0a3f5950 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -803,6 +803,11 @@
 			#clock-cells = <1>;
 		};
 
+		dispsys: display-system {
+			compatible = "mediatek,mt2701-dispsys";
+			mediatek,mmsys = <&mmsys>;
+		}
+
 		mdp_rdma0: rdma at 14001000 {
 			compatible = "mediatek,mt8173-mdp-rdma",
 				     "mediatek,mt8173-mdp";
-- 
2.14.2
