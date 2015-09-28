From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 28 Sep 2015 19:51:21 +0300
Subject: [PATCH 4/4] doc: dt: arm,
 pl172: add description of PL175 and PL176 controllers
In-Reply-To: <1443459043-24144-1-git-send-email-vz@mleia.com>
References: <1443459043-24144-1-git-send-email-vz@mleia.com>
Message-ID: <1443459081-24199-4-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
---
 .../devicetree/bindings/memory-controllers/arm,pl172.txt          | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl172.txt b/Documentation/devicetree/bindings/memory-controllers/arm,pl172.txt
index e6df32f..22b77ee 100644
--- a/Documentation/devicetree/bindings/memory-controllers/arm,pl172.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl172.txt
@@ -1,8 +1,9 @@
-* Device tree bindings for ARM PL172 MultiPort Memory Controller
+* Device tree bindings for ARM PL172/PL175/PL176 MultiPort Memory Controller
 
 Required properties:
 
-- compatible:		"arm,pl172", "arm,primecell"
+- compatible:		Must be "arm,primecell" and exactly one from
+			"arm,pl172", "arm,pl175" or "arm,pl176".
 
 - reg:			Must contains offset/length value for controller.
 
@@ -56,7 +57,8 @@ Optional child cs node config properties:
 
 - mpmc,extended-wait:	Enable extended wait.
 
-- mpmc,buffer-enable:	Enable write buffer.
+- mpmc,buffer-enable:	Enable write buffer, option is not supported by
+			PL175 and PL176 controllers.
 
 - mpmc,write-protect:	Enable write protect.
 
-- 
2.1.4
