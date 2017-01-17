From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Jan 2017 15:22:33 +0000
Subject: [PATCH 06/10] crypto: arm64/chacha20 - remove cra_alignmask
In-Reply-To: <1484666557-31458-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484666557-31458-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1484666557-31458-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the unnecessary alignmask: it is much more efficient to deal with
the misalignment in the core algorithm than relying on the crypto API to
copy the data to a suitably aligned buffer.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/chacha20-neon-glue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/crypto/chacha20-neon-glue.c b/arch/arm64/crypto/chacha20-neon-glue.c
index a7f2337d46cf..a7cd575ea223 100644
--- a/arch/arm64/crypto/chacha20-neon-glue.c
+++ b/arch/arm64/crypto/chacha20-neon-glue.c
@@ -93,7 +93,6 @@ static struct skcipher_alg alg = {
 	.base.cra_priority	= 300,
 	.base.cra_blocksize	= 1,
 	.base.cra_ctxsize	= sizeof(struct chacha20_ctx),
-	.base.cra_alignmask	= 1,
 	.base.cra_module	= THIS_MODULE,
 
 	.min_keysize		= CHACHA20_KEY_SIZE,
-- 
2.7.4
