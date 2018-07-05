From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 14:39:59 +0200
Subject: [PATCH v4 02/14] dt-bindings/interrupt-controller: fix Marvell ICU
 length in the example
In-Reply-To: <20180705124011.7661-1-miquel.raynal@bootlin.com>
References: <20180705124011.7661-1-miquel.raynal@bootlin.com>
Message-ID: <20180705124011.7661-3-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ICU size in CP110 is not 0x10 but at least 0x440 bytes long (from the
specification).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
index aa8bf2ec8905..649b7ec9d9b1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
@@ -39,7 +39,7 @@ Example:
 
 icu: interrupt-controller at 1e0000 {
 	compatible = "marvell,cp110-icu";
-	reg = <0x1e0000 0x10>;
+	reg = <0x1e0000 0x440>;
 	#interrupt-cells = <3>;
 	interrupt-controller;
 	msi-parent = <&gicp>;
-- 
2.14.1
