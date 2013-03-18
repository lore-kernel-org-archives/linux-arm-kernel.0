From: hutter.eric@gmail.com (Eric Hutter)
Date: Mon, 18 Mar 2013 19:48:56 +0100
Subject: [PATCH 1/1] ARM: kirkwood: Fix chip-delay for GoFlex Net
Message-ID: <51476198.2080100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This fixes "Too few good blocks within range" issues on GoFlex Net
by setting chip-delay to 40. I've been using this patch on my device
for quite a while now (accessing uboot vars is not possible without it).
The basic problem was discussed at
http://forum.doozan.com/read.php?2,7451 and I think this fix
should go mainstream.

Greetings

Eric Hutter


Signed-off-by: Eric Hutter <hutter.eric@gmail.com>
---
  arch/arm/boot/dts/kirkwood-goflexnet.dts | 1 +
  1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts 
b/arch/arm/boot/dts/kirkwood-goflexnet.dts
index bd83b8f..c3573be 100644
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
@@ -77,6 +77,7 @@
          };

          nand at 3000000 {
+            chip-delay = <40>;
              status = "okay";

              partition at 0 {
-- 
1.8.1.4
