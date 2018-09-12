From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 12 Sep 2018 14:53:42 +0100
Subject: [PATCH v2 01/11] coresight: dts: binding: Fix example for TPIU
 component
In-Reply-To: <20180912135352.19722-1-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
Message-ID: <20180912135352.19722-2-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TPIU component has an input port. The example uses out-ports
which is wrong. Let us fix it.

Reported-by: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index f39d2c6eb49c..13b6198ce01c 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -132,7 +132,7 @@ Example:
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		out-ports {
+		in-ports {
 			port {
 				tpiu_in_port: endpoint at 0 {
 					remote-endpoint = <&replicator_out_port1>;
-- 
2.19.0
