From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 22 Jun 2015 09:23:36 +0200
Subject: [PATCH v7 00/14] crypto: add a new driver for Marvell's CESA
In-Reply-To: <20150621082717.GA29128@gondor.apana.org.au>
References: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150619142444.GA15234@gondor.apana.org.au>
 <CAP=VYLqQynCNRTpm4JnOxeO6DH_739fO2QNcDMxaXqCKCHiTtQ@mail.gmail.com>
 <CAP=VYLpSrTvXRovWo4G7AXWv1OKFQRpQR255hS5z+=h4+XOLhg@mail.gmail.com>
 <20150621102418.2ea74910@bbrezillon>
 <20150621082717.GA29128@gondor.apana.org.au>
Message-ID: <20150622092336.5949e258@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

On Sun, 21 Jun 2015 16:27:17 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Sun, Jun 21, 2015 at 10:24:18AM +0200, Boris Brezillon wrote:
> > 
> > Indeed. Here is a patch fixing that.
> 
> I think you should just kill COMPILE_TEST instead of adding ARM.

The following patch is killing the COMPILE_TEST dependency.

-- >8 --

>From 772232fe4f5e597e45701dd9c3ab68c4a065342f Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 22 Jun 2015 09:22:14 +0200
Subject: [PATCH] crypto: marvell/CESA: remove COMPILE_TEST dependency

The CESA driver calls phys_to_virt() which is not available on all
architectures.
Remove the depency on COMPILE_TEST to prevent building this driver on
non ARM architectures.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index cdca762..f965d0c 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -176,7 +176,7 @@ config CRYPTO_DEV_MV_CESA
 
 config CRYPTO_DEV_MARVELL_CESA
 	tristate "New Marvell's Cryptographic Engine driver"
-	depends on (PLAT_ORION || ARCH_MVEBU || COMPILE_TEST) && HAS_DMA && HAS_IOMEM
+	depends on PLAT_ORION || ARCH_MVEBU
 	select CRYPTO_AES
 	select CRYPTO_DES
 	select CRYPTO_BLKCIPHER
-- 
1.9.1
