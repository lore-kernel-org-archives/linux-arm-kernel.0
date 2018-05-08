From: robh@kernel.org (Rob Herring)
Date: Tue,  8 May 2018 10:09:52 -0500
Subject: [PATCH] arm64: dts: sprd: fix typo in 'remote-endpoint'
In-Reply-To: <20180508150952.24562-1-robh@kernel.org>
References: <20180508150952.24562-1-robh@kernel.org>
Message-ID: <20180508150952.24562-4-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc now warns on incomplete OF graph endpoint connections:

arch/arm64/boot/dts/sprd/sp9860g-1h10.dtb: Warning (graph_endpoint): /soc/stm at 10006000/port/endpoint: graph connection to node '/soc/funnel at 10001000/ports/port at 2/endpoint' is not bidirectional

The cause is a typo in 'remote-endpoint'.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/sprd/sc9860.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index 5dbfb796d9f9..dcd03ffcda03 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -326,7 +326,7 @@
 					reg = <4>;
 					soc_funnel_in_port1: endpoint {
 						slave-mode;
-						remote-endpioint =
+						remote-endpoint =
 							<&stm_out_port>;
 					};
 				};
-- 
2.17.0
