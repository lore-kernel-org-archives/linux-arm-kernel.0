From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Tue,  6 Jan 2015 09:37:13 -0700
Subject: [PATCH 9/9] coresight: Documenting reference to generic PD bindings
In-Reply-To: <1420562233-2015-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420562233-2015-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420562233-2015-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Each coresight block can be part of a power domain.  Using the
generic power domain subsystems to manage power to individual
domains guarantes that coresight operations won't be interrupted
by other components.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index d790f49066f3..27f96f0d36ef 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -50,6 +50,10 @@ its hardware characteristcs.
 	* cpu: the cpu phandle this ETM/PTM is affined to. When omitted the
 	  source is considered to belong to CPU0.
 
+	* power-domains: a handle to the generic power domain node this
+	  coresight block is affined to.  When omitted the component is
+	  assumed to always be powered.
+
 * Optional property for TMC:
 
 	* arm,buffer-size: size of contiguous buffer space for TMC ETR
-- 
1.9.1
