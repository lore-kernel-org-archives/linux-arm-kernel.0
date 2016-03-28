From: acourbot@nvidia.com (Alexandre Courbot)
Date: Mon, 28 Mar 2016 18:23:01 +0900
Subject: [PATCH v3 2/5] dt-bindings: gk20a: Document iommus property
In-Reply-To: <1459156984-32644-1-git-send-email-acourbot@nvidia.com>
References: <1459156984-32644-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1459156984-32644-3-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GK20A can optionally make use of an IOMMU.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
index 914f0ff4020e..1e3748337319 100644
--- a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
+++ b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
@@ -24,6 +24,9 @@ Required properties:
 - reset-names: Must include the following entries:
   - gpu
 
+Optional properties:
+- iommus: A reference to the IOMMU. See ../iommu/iommu.txt for details.
+
 Example:
 
 	gpu at 0,57000000 {
@@ -39,5 +42,6 @@ Example:
 		clock-names = "gpu", "pwr";
 		resets = <&tegra_car 184>;
 		reset-names = "gpu";
+		iommus = <&mc TEGRA_SWGROUP_GPU>;
 		status = "disabled";
 	};
-- 
2.7.3
