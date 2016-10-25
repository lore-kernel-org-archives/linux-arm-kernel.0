From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 25 Oct 2016 08:26:37 -0700
Subject: [PATCH 2/4] dt-bindings: add domain-idle-state compatible to arm,
 idle-state
In-Reply-To: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1477409199-52182-3-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU's idle states are defined by the arm,idle-state compatible flag. PM
domains that can contains devices and other domains also has similar
definition for its idle state. Reuse the definition of arm,idle-state
for PM domains by allowing an addition compatible string
("domain-idle-state") to denote idle states that are specific to PM
Domains.

Cc: <devicetree@vger.kernel.org>
Cc: Rob Herring <robh@kernel.org>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/devicetree/bindings/arm/idle-states.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index b8e41c1..4b0ff59 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -271,6 +271,9 @@ follows:
 		Usage: Required
 		Value type: <stringlist>
 		Definition: Must be "arm,idle-state".
+			    Additionally, nodes that are used to describe a
+			    idle-state of PM domain must also define
+			    "domain-idle-state" as compatible string.
 
 	- local-timer-stop
 		Usage: See definition
-- 
2.7.4
