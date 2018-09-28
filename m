From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:49 +0200
Subject: [PATCH 3/4] dt-bindings: arm: Document Renesas R-Car M3-N-based ULCB
 board
In-Reply-To: <cover.1538129305.git.horms+renesas@verge.net.au>
References: <cover.1538129305.git.horms+renesas@verge.net.au>
Message-ID: <43bcac2396f7874338016d3c6d86d0bdad8e63e8.1538129305.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eugeniu Rosca <roscaeugeniu@gmail.com>

In harmony with ATF and U-Boot outputs [1] and [2], the new board is
based on M3-N revision ES1.1 and the amount of memory present on SiP
is 2GiB, contiguously addressed.

The amount of RAM is mentioned based on the assumption that it is
encoded in the board id/string. There is some evidence supporting this
in form of last-digit-mismatch between two R-Car H3 ES2.0 ULCB board
ids, one with 4GiB and one with 8GiB of RAM (see [3]).

[1] BL2: R-Car Gen3 Initial Program Loader(CA57) Rev.1.0.21
    BL2: PRR is R-Car M3N Ver.1.1

[2] U-Boot 2015.04-00295-*
    CPU: Renesas Electronics R8A77965 rev 1.1
    ---8<----
    DRAM:  1.9 GiB
    Bank #0: 0x048000000 - 0x0bfffffff, 1.9 GiB
    ---8<----

[3] https://patchwork.kernel.org/patch/10555957/#22169325

Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index c0f0a344dfe0..4a03a6b3397e 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -111,6 +111,8 @@ Boards:
     compatible = "renesas,lager", "renesas,r8a7790"
   - M3ULCB (R-Car Starter Kit Pro, RTP0RC7796SKBX0010SA09 (M3 ES1.0))
     compatible = "renesas,m3ulcb", "renesas,r8a7796"
+  - M3NULCB (R-Car Starter Kit Pro, RTP0RC77965SKBX010SA00 (M3-N ES1.1))
+    compatible = "renesas,m3nulcb", "renesas,r8a77965"
   - Marzen (R0P7779A00010S)
     compatible = "renesas,marzen", "renesas,r8a7779"
   - Porter (M2-LCDP)
-- 
2.11.0
