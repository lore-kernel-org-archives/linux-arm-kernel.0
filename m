From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed, 28 Oct 2015 16:10:48 +0100
Subject: [PATCH] ARM: fix bug in vdsomunge swab32 macro
Message-ID: <130abb060734507d4affcf9d81b87ce6af5d2cc8.1446045045.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit Commit 8a603f91cc48 ("ARM: 8445/1: fix vdsomunge not to depend on glibc specific byteswap.h")

unfortunately introduced a bug created but not found during
discussion and patch simplification.

Reported-by: Efraim Yawitz <efraim.yawitz@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/vdso/vdsomunge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vdso/vdsomunge.c b/arch/arm/vdso/vdsomunge.c
index 0cebd98..f645527 100644
--- a/arch/arm/vdso/vdsomunge.c
+++ b/arch/arm/vdso/vdsomunge.c
@@ -66,7 +66,7 @@
 	((((x) & 0x000000ff) << 24) | \
 	 (((x) & 0x0000ff00) <<  8) | \
 	 (((x) & 0x00ff0000) >>  8) | \
-	 (((x) & 0xff000000) << 24))
+	 (((x) & 0xff000000) >> 24))
 
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define HOST_ORDER ELFDATA2LSB
-- 
2.5.1
