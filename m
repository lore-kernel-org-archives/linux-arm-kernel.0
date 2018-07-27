From: manu@freebsd.org (Emmanuel Vadot)
Date: Fri, 27 Jul 2018 13:52:04 +0200
Subject: [PATCH v3 3/4] nvmem: sunxi-sid: add support for H5's SID controller
In-Reply-To: <20180727115205.20955-1-manu@freebsd.org>
References: <20180727115205.20955-1-manu@freebsd.org>
Message-ID: <20180727115205.20955-3-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H5 SoC have a SID controller that looks like the one in A64, the
cells are in the same offset but doesn't contain the same data (thermal
sensor calibration for example).
Add a binding for it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index e319fe5e205a..99c4ba6a3f61 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -7,6 +7,7 @@ Required properties:
   "allwinner,sun8i-a83t-sid"
   "allwinner,sun8i-h3-sid"
   "allwinner,sun50i-a64-sid"
+  "allwinner,sun50i-h5-sid"
 
 - reg: Should contain registers location and length
 
-- 
2.18.0
