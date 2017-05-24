From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 24 May 2017 14:10:10 +0900
Subject: [PATCH] ARM: dts: versatile: use #include "..." to include local DT
Message-ID: <1495602610-18667-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of DT files in ARM use #include "..." to make pre-processor
include DT in the same directory, but this is one of the exceptional
files that use #include <...> for that.

Fix it to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts path from
dtc_cpp_flags.

ARM: dts: versatile: use #include "..." to include DT in the same directory

Most of DT files in ARM use #include "..." to make pre-processor
include DT in the same directory, but we have 3 exceptional files
that use #include <...> for that.

They must be fixed to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts
path from dtc_cpp_flags.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Arnd, Olof,
I could not find a sub-arch maintainer for versatile.
If nobody picks up this, could you take care of this?



 arch/arm/boot/dts/versatile-pb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index 33a8eb28374e..06e2331f666d 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -1,4 +1,4 @@
-#include <versatile-ab.dts>
+#include "versatile-ab.dts"
 
 / {
 	model = "ARM Versatile PB";
-- 
2.7.4
