From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Jan 2017 15:22:31 +0000
Subject: [PATCH 04/10] crypto: arm64/aes-ce-ccm - remove cra_alignmask
In-Reply-To: <1484666557-31458-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484666557-31458-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1484666557-31458-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the unnecessary alignmask: it is much more efficient to deal with
the misalignment in the core algorithm than relying on the crypto API to
copy the data to a suitably aligned buffer.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/aes-ce-ccm-glue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/crypto/aes-ce-ccm-glue.c b/arch/arm64/crypto/aes-ce-ccm-glue.c
index cc5515dac74a..6a7dbc7c83a6 100644
--- a/arch/arm64/crypto/aes-ce-ccm-glue.c
+++ b/arch/arm64/crypto/aes-ce-ccm-glue.c
@@ -258,7 +258,6 @@ static struct aead_alg ccm_aes_alg = {
 		.cra_priority		= 300,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct crypto_aes_ctx),
-		.cra_alignmask		= 7,
 		.cra_module		= THIS_MODULE,
 	},
 	.ivsize		= AES_BLOCK_SIZE,
-- 
2.7.4
