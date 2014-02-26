From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 16:57:34 +0900
Subject: [PATCH 7/9] ARM: shmobile: r8a7790: Correct SYS DMAC clock defines
In-Reply-To: <cover.1393401266.git.horms+renesas@verge.net.au>
References: <cover.1393401266.git.horms+renesas@verge.net.au>
Message-ID: <b998da0541e64da5bd857c09347c0fa954c03432.1393401266.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This brings the implementation into line with the documentation.

This problem was introduced when SYS DMAC clock defines were added by
ac991dce6498b5fc ("ARM: shmobile: r8a7790: Add clock index macros for DT
sources") in v3.13-rc2. I do not believe this results in any problems as
these defines do not appear to be used anywhere yet.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/clock/r8a7790-clock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 859e9be..6548a5f 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -46,8 +46,8 @@
 #define R8A7790_CLK_MSIOF1		8
 #define R8A7790_CLK_MSIOF3		15
 #define R8A7790_CLK_SCIFB2		16
-#define R8A7790_CLK_SYS_DMAC0		18
-#define R8A7790_CLK_SYS_DMAC1		19
+#define R8A7790_CLK_SYS_DMAC1		18
+#define R8A7790_CLK_SYS_DMAC0		19
 
 /* MSTP3 */
 #define R8A7790_CLK_TPU0		4
-- 
1.8.5.2
