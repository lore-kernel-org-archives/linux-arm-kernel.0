Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10959C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:37:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37B921855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EX8loVXI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vlb2OuDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37B921855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=E6EyO3wGKZiV1ZxQPTA814a39joltA3g00Ik7S/d78g=; b=EX8loVXI9C4PwZ8if7TFFW17oG
	ZdY84U85k3iCE9kCW5fDgw4avcGXj3+0ZDbcYSGT6yfPFj7HpxPNQHLnkWAT05ezwDALunJkwQAnd
	beS5z8o/iHFKUXfn+rp89cRI3FvT9O1zRqaJqC/ONeUwL6gVlxEA9ElEYFMTnxUWvptAfXGrCHBcR
	3yvqnHtW7AIDq/cy8qhZ9aGLsAK4LId9JX18KzBqSBJlwz8mRN61pEZ5nYyVZbhfjoLxdrbcGIVYk
	miLVqYfIR3MlfXcneRTUf87GS8ozR0UDjtTJH+QAYavNpU3DQZhCqYO7oNcoZ8pmBtWwAE6QpVctV
	03C0Lnhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxvL-0004RA-10; Fri, 25 Jan 2019 09:37:19 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxuf-0003tC-TW
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:36:43 +0000
Received: by mail-wm1-x342.google.com with SMTP id y139so5995376wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 01:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pNt4yaSlu3iRrUwKoyxO0+l1wAhEcdNdpfpG3aKPk1w=;
 b=Vlb2OuDoH6PSIhnEPYU5wpzCBmzgn39CVE0SxE2wGVFpBGajtqxVadPJ5C61RPY9mv
 H567NAhdUOQQhhdbki4vCXmP0yf/2oBGtTohVw6y0oV7YjUcWi6zIL/w3+fFcICEUYuz
 IrSe4WawLjXJSKP0vw5ANvTsy7KXToBN7ttAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pNt4yaSlu3iRrUwKoyxO0+l1wAhEcdNdpfpG3aKPk1w=;
 b=nIDG/HwAyz/Ldnu1/95KltlMkqkOhU0EwGUgMuFtdp/UuXS4QpkILhr5tETlfpmOsa
 ZB1yJH80UoylvDspPbPFB4x/SG+VH6JKNxI2m0NM6wgbXWT6uK3L8+iwl5d9KjIAAbuF
 3dTNcdZKMsPkaft2W3aGM9tQSG86oj7FwPgcx0sJoVcY5MWJlAfZPiQ/iVpgss33sYfI
 rMH5cWz4Db8kdZG30jlfiiW30H6/14XxwC6bpmjEuKrp6YIMQ1K02EK4ZLJBI7ashGfM
 NvmviZA3PEYwf7T2ODcyYWGhm/kWJ4uSEvD68ODBdBuUmTVyJ+lDbKNs1iKXLk8/FHAU
 PMRA==
X-Gm-Message-State: AJcUukdQPamtsNCYjRiRHd6tKFaSp2tHnYny1u4Ykscq81rIaRvji9Ak
 V1hvq4nVe9BvWsR3JXJLaVsYiA==
X-Google-Smtp-Source: ALg8bN4VYHRbJEMjF5P+wHsFCue1lzaNEm90aEAaTNTOuliXhlYGoLVjIzaxEvbl5tlgMIZzk22yyg==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr6315130wmz.8.1548408996071;
 Fri, 25 Jan 2019 01:36:36 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:bcd4:806e:230a:673e])
 by smtp.gmail.com with ESMTPSA id w80sm92323955wme.38.2019.01.25.01.36.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 01:36:35 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 2/2] crypto: arm64/ghash - register PMULL variants as separate
 algos
Date: Fri, 25 Jan 2019 10:36:27 +0100
Message-Id: <20190125093627.14288-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125093627.14288-1-ard.biesheuvel@linaro.org>
References: <20190125093627.14288-1-ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_013638_141757_53EFD6FB 
X-CRM114-Status: GOOD (  17.36  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: ebiggers@kernel.org, herbert@gondor.apana.org.au,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The arm64 GHASH implementation either uses 8-bit or 64-bit
polynomial multiplication instructions, since the latter are
faster but not mandatory in the architecture.

Since that prevents us from testing both implementations on the
same system, let's expose both implementations to the crypto API,
with the priorities reflecting that the P64 version is the
preferred one if available.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/ghash-ce-glue.c | 118 +++++++++++++++-----
 1 file changed, 90 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/crypto/ghash-ce-glue.c b/arch/arm64/crypto/ghash-ce-glue.c
index 067d8937d5af..791ad422c427 100644
--- a/arch/arm64/crypto/ghash-ce-glue.c
+++ b/arch/arm64/crypto/ghash-ce-glue.c
@@ -60,10 +60,6 @@ asmlinkage void pmull_ghash_update_p8(int blocks, u64 dg[], const char *src,
 				      struct ghash_key const *k,
 				      const char *head);
 
-static void (*pmull_ghash_update)(int blocks, u64 dg[], const char *src,
-				  struct ghash_key const *k,
-				  const char *head);
-
 asmlinkage void pmull_gcm_encrypt(int blocks, u64 dg[], u8 dst[],
 				  const u8 src[], struct ghash_key const *k,
 				  u8 ctr[], u32 const rk[], int rounds,
@@ -87,11 +83,15 @@ static int ghash_init(struct shash_desc *desc)
 }
 
 static void ghash_do_update(int blocks, u64 dg[], const char *src,
-			    struct ghash_key *key, const char *head)
+			    struct ghash_key *key, const char *head,
+			    void (*simd_update)(int blocks, u64 dg[],
+						const char *src,
+						struct ghash_key const *k,
+						const char *head))
 {
 	if (likely(may_use_simd())) {
 		kernel_neon_begin();
-		pmull_ghash_update(blocks, dg, src, key, head);
+		simd_update(blocks, dg, src, key, head);
 		kernel_neon_end();
 	} else {
 		be128 dst = { cpu_to_be64(dg[1]), cpu_to_be64(dg[0]) };
@@ -119,8 +119,12 @@ static void ghash_do_update(int blocks, u64 dg[], const char *src,
 /* avoid hogging the CPU for too long */
 #define MAX_BLOCKS	(SZ_64K / GHASH_BLOCK_SIZE)
 
-static int ghash_update(struct shash_desc *desc, const u8 *src,
-			unsigned int len)
+static int __ghash_update(struct shash_desc *desc, const u8 *src,
+			  unsigned int len,
+			  void (*simd_update)(int blocks, u64 dg[],
+					      const char *src,
+					      struct ghash_key const *k,
+					      const char *head))
 {
 	struct ghash_desc_ctx *ctx = shash_desc_ctx(desc);
 	unsigned int partial = ctx->count % GHASH_BLOCK_SIZE;
@@ -146,7 +150,8 @@ static int ghash_update(struct shash_desc *desc, const u8 *src,
 			int chunk = min(blocks, MAX_BLOCKS);
 
 			ghash_do_update(chunk, ctx->digest, src, key,
-					partial ? ctx->buf : NULL);
+					partial ? ctx->buf : NULL,
+					simd_update);
 
 			blocks -= chunk;
 			src += chunk * GHASH_BLOCK_SIZE;
@@ -158,7 +163,19 @@ static int ghash_update(struct shash_desc *desc, const u8 *src,
 	return 0;
 }
 
-static int ghash_final(struct shash_desc *desc, u8 *dst)
+static int ghash_update_p8(struct shash_desc *desc, const u8 *src,
+			   unsigned int len)
+{
+	return __ghash_update(desc, src, len, pmull_ghash_update_p8);
+}
+
+static int ghash_update_p64(struct shash_desc *desc, const u8 *src,
+			    unsigned int len)
+{
+	return __ghash_update(desc, src, len, pmull_ghash_update_p64);
+}
+
+static int ghash_final_p8(struct shash_desc *desc, u8 *dst)
 {
 	struct ghash_desc_ctx *ctx = shash_desc_ctx(desc);
 	unsigned int partial = ctx->count % GHASH_BLOCK_SIZE;
@@ -168,7 +185,28 @@ static int ghash_final(struct shash_desc *desc, u8 *dst)
 
 		memset(ctx->buf + partial, 0, GHASH_BLOCK_SIZE - partial);
 
-		ghash_do_update(1, ctx->digest, ctx->buf, key, NULL);
+		ghash_do_update(1, ctx->digest, ctx->buf, key, NULL,
+				pmull_ghash_update_p8);
+	}
+	put_unaligned_be64(ctx->digest[1], dst);
+	put_unaligned_be64(ctx->digest[0], dst + 8);
+
+	*ctx = (struct ghash_desc_ctx){};
+	return 0;
+}
+
+static int ghash_final_p64(struct shash_desc *desc, u8 *dst)
+{
+	struct ghash_desc_ctx *ctx = shash_desc_ctx(desc);
+	unsigned int partial = ctx->count % GHASH_BLOCK_SIZE;
+
+	if (partial) {
+		struct ghash_key *key = crypto_shash_ctx(desc->tfm);
+
+		memset(ctx->buf + partial, 0, GHASH_BLOCK_SIZE - partial);
+
+		ghash_do_update(1, ctx->digest, ctx->buf, key, NULL,
+				pmull_ghash_update_p64);
 	}
 	put_unaligned_be64(ctx->digest[1], dst);
 	put_unaligned_be64(ctx->digest[0], dst + 8);
@@ -224,7 +262,21 @@ static int ghash_setkey(struct crypto_shash *tfm,
 	return __ghash_setkey(key, inkey, keylen);
 }
 
-static struct shash_alg ghash_alg = {
+static struct shash_alg ghash_alg[] = {{
+	.base.cra_name		= "ghash",
+	.base.cra_driver_name	= "ghash-neon",
+	.base.cra_priority	= 100,
+	.base.cra_blocksize	= GHASH_BLOCK_SIZE,
+	.base.cra_ctxsize	= sizeof(struct ghash_key),
+	.base.cra_module	= THIS_MODULE,
+
+	.digestsize		= GHASH_DIGEST_SIZE,
+	.init			= ghash_init,
+	.update			= ghash_update_p8,
+	.final			= ghash_final_p8,
+	.setkey			= ghash_setkey,
+	.descsize		= sizeof(struct ghash_desc_ctx),
+}, {
 	.base.cra_name		= "ghash",
 	.base.cra_driver_name	= "ghash-ce",
 	.base.cra_priority	= 200,
@@ -234,11 +286,11 @@ static struct shash_alg ghash_alg = {
 
 	.digestsize		= GHASH_DIGEST_SIZE,
 	.init			= ghash_init,
-	.update			= ghash_update,
-	.final			= ghash_final,
+	.update			= ghash_update_p64,
+	.final			= ghash_final_p64,
 	.setkey			= ghash_setkey,
 	.descsize		= sizeof(struct ghash_desc_ctx),
-};
+}};
 
 static int num_rounds(struct crypto_aes_ctx *ctx)
 {
@@ -301,7 +353,8 @@ static void gcm_update_mac(u64 dg[], const u8 *src, int count, u8 buf[],
 		int blocks = count / GHASH_BLOCK_SIZE;
 
 		ghash_do_update(blocks, dg, src, &ctx->ghash_key,
-				*buf_count ? buf : NULL);
+				*buf_count ? buf : NULL,
+				pmull_ghash_update_p64);
 
 		src += blocks * GHASH_BLOCK_SIZE;
 		count %= GHASH_BLOCK_SIZE;
@@ -345,7 +398,8 @@ static void gcm_calculate_auth_mac(struct aead_request *req, u64 dg[])
 
 	if (buf_count) {
 		memset(&buf[buf_count], 0, GHASH_BLOCK_SIZE - buf_count);
-		ghash_do_update(1, dg, buf, &ctx->ghash_key, NULL);
+		ghash_do_update(1, dg, buf, &ctx->ghash_key, NULL,
+				pmull_ghash_update_p64);
 	}
 }
 
@@ -358,7 +412,8 @@ static void gcm_final(struct aead_request *req, struct gcm_aes_ctx *ctx,
 	lengths.a = cpu_to_be64(req->assoclen * 8);
 	lengths.b = cpu_to_be64(cryptlen * 8);
 
-	ghash_do_update(1, dg, (void *)&lengths, &ctx->ghash_key, NULL);
+	ghash_do_update(1, dg, (void *)&lengths, &ctx->ghash_key, NULL,
+			pmull_ghash_update_p64);
 
 	put_unaligned_be64(dg[1], mac);
 	put_unaligned_be64(dg[0], mac + 8);
@@ -434,7 +489,7 @@ static int gcm_encrypt(struct aead_request *req)
 
 			ghash_do_update(walk.nbytes / AES_BLOCK_SIZE, dg,
 					walk.dst.virt.addr, &ctx->ghash_key,
-					NULL);
+					NULL, pmull_ghash_update_p64);
 
 			err = skcipher_walk_done(&walk,
 						 walk.nbytes % (2 * AES_BLOCK_SIZE));
@@ -469,7 +524,8 @@ static int gcm_encrypt(struct aead_request *req)
 
 		memcpy(buf, dst, nbytes);
 		memset(buf + nbytes, 0, GHASH_BLOCK_SIZE - nbytes);
-		ghash_do_update(!!nbytes, dg, buf, &ctx->ghash_key, head);
+		ghash_do_update(!!nbytes, dg, buf, &ctx->ghash_key, head,
+				pmull_ghash_update_p64);
 
 		err = skcipher_walk_done(&walk, 0);
 	}
@@ -558,7 +614,8 @@ static int gcm_decrypt(struct aead_request *req)
 			u8 *src = walk.src.virt.addr;
 
 			ghash_do_update(blocks, dg, walk.src.virt.addr,
-					&ctx->ghash_key, NULL);
+					&ctx->ghash_key, NULL,
+					pmull_ghash_update_p64);
 
 			do {
 				__aes_arm64_encrypt(ctx->aes_key.key_enc,
@@ -602,7 +659,8 @@ static int gcm_decrypt(struct aead_request *req)
 
 		memcpy(buf, src, nbytes);
 		memset(buf + nbytes, 0, GHASH_BLOCK_SIZE - nbytes);
-		ghash_do_update(!!nbytes, dg, buf, &ctx->ghash_key, head);
+		ghash_do_update(!!nbytes, dg, buf, &ctx->ghash_key, head,
+				pmull_ghash_update_p64);
 
 		crypto_xor_cpy(walk.dst.virt.addr, walk.src.virt.addr, iv,
 			       walk.nbytes);
@@ -650,26 +708,30 @@ static int __init ghash_ce_mod_init(void)
 		return -ENODEV;
 
 	if (elf_hwcap & HWCAP_PMULL)
-		pmull_ghash_update = pmull_ghash_update_p64;
-
+		ret = crypto_register_shashes(ghash_alg,
+					      ARRAY_SIZE(ghash_alg));
 	else
-		pmull_ghash_update = pmull_ghash_update_p8;
+		/* only register the first array element */
+		ret = crypto_register_shash(ghash_alg);
 
-	ret = crypto_register_shash(&ghash_alg);
 	if (ret)
 		return ret;
 
 	if (elf_hwcap & HWCAP_PMULL) {
 		ret = crypto_register_aead(&gcm_aes_alg);
 		if (ret)
-			crypto_unregister_shash(&ghash_alg);
+			crypto_unregister_shashes(ghash_alg,
+						  ARRAY_SIZE(ghash_alg));
 	}
 	return ret;
 }
 
 static void __exit ghash_ce_mod_exit(void)
 {
-	crypto_unregister_shash(&ghash_alg);
+	if (elf_hwcap & HWCAP_PMULL)
+		crypto_unregister_shashes(ghash_alg, ARRAY_SIZE(ghash_alg));
+	else
+		crypto_unregister_shash(ghash_alg);
 	crypto_unregister_aead(&gcm_aes_alg);
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
