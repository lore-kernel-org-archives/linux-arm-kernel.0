From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 17:16:13 +0200
Subject: [PATCH, RFC 09/22] crypto: lz4: don't build on ARM
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Message-ID: <1367507786-505303-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not currently possible to build the LZ4 code on ARM, so let's
remove that option in Kconfig for now.

lib/built-in.o: In function `lz4_compress64kctx':
 lib/lz4/lz4_compress.c:339: undefined reference to `__ctzsi2'
lib/built-in.o: In function `lz4_compressctx':
 lib/lz4/lz4_compress.c:157: undefined reference to `__ctzsi2'
lib/built-in.o: In function `lz4hc_commonlength':
 lib/lz4/lz4hc_compress.c:102: undefined reference to `__ctzsi2'
 lib/lz4/lz4hc_compress.c:102: undefined reference to `__ctzsi2'
lib/built-in.o: In function `lz4hc_insertandgetwidermatch':
 lib/lz4/lz4hc_compress.c:230: undefined reference to `__ctzsi2'

Cc: Chanho Min <chanho.min@lge.com>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index aa3a349..1cd134b 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1361,6 +1361,7 @@ config CRYPTO_842
 
 config CRYPTO_LZ4
 	tristate "LZ4 compression algorithm"
+	depends on !ARM
 	select CRYPTO_ALGAPI
 	select LZ4_COMPRESS
 	select LZ4_DECOMPRESS
@@ -1369,6 +1370,7 @@ config CRYPTO_LZ4
 
 config CRYPTO_LZ4HC
 	tristate "LZ4HC compression algorithm"
+	depends on !ARM
 	select CRYPTO_ALGAPI
 	select LZ4HC_COMPRESS
 	select LZ4_DECOMPRESS
-- 
1.8.1.2
