From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 11 Aug 2015 13:32:55 +0800
Subject: [PATCH 1/3] crypto: sunxi-ss: Document optional reset control bindings
In-Reply-To: <1439271177-26523-1-git-send-email-wens@csie.org>
References: <1439271177-26523-1-git-send-email-wens@csie.org>
Message-ID: <1439271177-26523-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Later Allwinner SoCs split out the reset controls for individual modules
out of the clock gate controls. The "Security System" crypto engine is
no different.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/crypto/sun4i-ss.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/sun4i-ss.txt b/Documentation/devicetree/bindings/crypto/sun4i-ss.txt
index 1e02d177fea6..5d38e9b7033f 100644
--- a/Documentation/devicetree/bindings/crypto/sun4i-ss.txt
+++ b/Documentation/devicetree/bindings/crypto/sun4i-ss.txt
@@ -9,6 +9,10 @@ Required properties:
 	* "ahb" : AHB gating clock
 	* "mod" : SS controller clock
 
+Optional properties:
+ - resets : phandle + reset specifier pair
+ - reset-names : must contain "ahb"
+
 Example:
 	crypto: crypto-engine at 01c15000 {
 		compatible = "allwinner,sun4i-a10-crypto";
-- 
2.5.0
