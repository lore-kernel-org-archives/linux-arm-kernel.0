Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27756C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:37:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C4421855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bbayGOAH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1O8FZXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C4421855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NGR+KYsr3P3V/xYjuijOQUWHXNuqh7HdfmYqANs11Mo=; b=bbayGOAH9qJl1dkc+mZz/cpGqM
	odA2e5ktHKRofdJEyBGXPmUPT1rSf1rER/DZzIi0uyp1CiM4/iRnOZVJB+2qm66XMf7wowrjvBLd+
	tUwdIggHoWke4qt0UIJWYGDpphkzdK35V5tDlLCvupDJLbyL0x4byy7T9N9437Jvw2T9JZs8YOWne
	H4cPvPrdW/AOZAtR0iDP/7S+lYpr6Gd3IKKZq28YEP3u8xj3Y7MHqGry/tYUwJmq8v7hgp1bLxgSd
	8AVlOjlmMBPAp+pyvpeQ/qBDi04uq79A7CSLtwJi83R5DmCmrKSmRv8zVAMjxKHsAWItpxG8LYk0u
	A1hGAT1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxv0-0004AP-Mq; Fri, 25 Jan 2019 09:36:58 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxue-0003sa-9p
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:36:37 +0000
Received: by mail-wm1-x343.google.com with SMTP id y139so5995305wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 01:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pHeXQyjHBGPZ2p98q1m4Ogx2QHTHJsPCH+kq0wtIQtM=;
 b=a1O8FZXPbRSdLVvC+7SFfRYY57XdY8Bns4xivd2uaq2ijEzntpWiiG0LV9zF3oXew8
 Q7p9mE8EEOaxKjBWigr8x12ITPZUa+hrdzO5mtHaFfeMae3XFZQ9VpdPwxF0QqrspM5/
 0ESVJjKZ1JAUhzV5qFFT4/HtrsEnBTXdxwchA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pHeXQyjHBGPZ2p98q1m4Ogx2QHTHJsPCH+kq0wtIQtM=;
 b=S7PtWbPBYAi5074DjjWvy1/cS8M/5h0ll53SBjb3Rt7Bk2ZXmoMCzRbVrO6sfifF5f
 fXzthYrGixi1r2V84NTuJybgG2vR9nQrAHR9OwqSFGrAu9q596zbu00oXFTQAWE7Autq
 NbPCzJmDHRN3TbzUxxHdQK/hArGtJLcWWiKYwagehk74UFniX4GCCLKOCcwHsiocbpcS
 cDk8M6SrmAIZbZN80nPyM52U6IHx/+Bqa8u3Er2pqO3mYSx7KMaXeFJNWFeGmNaO8219
 YOrp1rltMVQXF0bbb1xID8j5S+ihJ9/PXhtyAtk9t3d8y7P0mClSqw3GooqekuzAQ0PS
 IxaQ==
X-Gm-Message-State: AJcUukeB1qYWRHPp6bp5HKPJm1RbT6MdCD6wMDUU4rSHA9Kuz8b9ebZ4
 oPWZ0oL6CChJtrOvL4Whh7rejg==
X-Google-Smtp-Source: ALg8bN7W8XiSBbwCNA0YbcWWYpuG1/JArKsEjClX/FcQwW/WzhBYTiNez80ufkQM/QhL2mn3mAcwrg==
X-Received: by 2002:a1c:1383:: with SMTP id 125mr6346548wmt.71.1548408994700; 
 Fri, 25 Jan 2019 01:36:34 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:bcd4:806e:230a:673e])
 by smtp.gmail.com with ESMTPSA id w80sm92323955wme.38.2019.01.25.01.36.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 01:36:33 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 1/2] crypto: arm64/crct10dif - register PMULL variants as
 separate algos
Date: Fri, 25 Jan 2019 10:36:26 +0100
Message-Id: <20190125093627.14288-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125093627.14288-1-ard.biesheuvel@linaro.org>
References: <20190125093627.14288-1-ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_013636_339041_BCD62FC0 
X-CRM114-Status: GOOD (  14.97  )
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

The arm64 CRC-T10DIF implementation either uses 8-bit or 64-bit
polynomial multiplication instructions, since the latter are
faster but not mandatory in the architecture.

Since that prevents us from testing both implementations on the
same system, let's expose both implementations to the crypto API,
with the priorities reflecting that the P64 version is the
preferred one if available.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/crct10dif-ce-glue.c | 54 +++++++++++++++-----
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/crypto/crct10dif-ce-glue.c b/arch/arm64/crypto/crct10dif-ce-glue.c
index 567c24f3d224..242757cc6da9 100644
--- a/arch/arm64/crypto/crct10dif-ce-glue.c
+++ b/arch/arm64/crypto/crct10dif-ce-glue.c
@@ -25,8 +25,6 @@
 asmlinkage u16 crc_t10dif_pmull_p64(u16 init_crc, const u8 buf[], u64 len);
 asmlinkage u16 crc_t10dif_pmull_p8(u16 init_crc, const u8 buf[], u64 len);
 
-static u16 (*crc_t10dif_pmull)(u16 init_crc, const u8 buf[], u64 len);
-
 static int crct10dif_init(struct shash_desc *desc)
 {
 	u16 *crc = shash_desc_ctx(desc);
@@ -35,14 +33,30 @@ static int crct10dif_init(struct shash_desc *desc)
 	return 0;
 }
 
-static int crct10dif_update(struct shash_desc *desc, const u8 *data,
+static int crct10dif_update_pmull_p8(struct shash_desc *desc, const u8 *data,
+			    unsigned int length)
+{
+	u16 *crc = shash_desc_ctx(desc);
+
+	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && may_use_simd()) {
+		kernel_neon_begin();
+		*crc = crc_t10dif_pmull_p8(*crc, data, length);
+		kernel_neon_end();
+	} else {
+		*crc = crc_t10dif_generic(*crc, data, length);
+	}
+
+	return 0;
+}
+
+static int crct10dif_update_pmull_p64(struct shash_desc *desc, const u8 *data,
 			    unsigned int length)
 {
 	u16 *crc = shash_desc_ctx(desc);
 
 	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && may_use_simd()) {
 		kernel_neon_begin();
-		*crc = crc_t10dif_pmull(*crc, data, length);
+		*crc = crc_t10dif_pmull_p64(*crc, data, length);
 		kernel_neon_end();
 	} else {
 		*crc = crc_t10dif_generic(*crc, data, length);
@@ -59,10 +73,22 @@ static int crct10dif_final(struct shash_desc *desc, u8 *out)
 	return 0;
 }
 
-static struct shash_alg crc_t10dif_alg = {
+static struct shash_alg crc_t10dif_alg[] = {{
 	.digestsize		= CRC_T10DIF_DIGEST_SIZE,
 	.init			= crct10dif_init,
-	.update			= crct10dif_update,
+	.update			= crct10dif_update_pmull_p8,
+	.final			= crct10dif_final,
+	.descsize		= CRC_T10DIF_DIGEST_SIZE,
+
+	.base.cra_name		= "crct10dif",
+	.base.cra_driver_name	= "crct10dif-arm64-neon",
+	.base.cra_priority	= 100,
+	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
+	.base.cra_module	= THIS_MODULE,
+}, {
+	.digestsize		= CRC_T10DIF_DIGEST_SIZE,
+	.init			= crct10dif_init,
+	.update			= crct10dif_update_pmull_p64,
 	.final			= crct10dif_final,
 	.descsize		= CRC_T10DIF_DIGEST_SIZE,
 
@@ -71,21 +97,25 @@ static struct shash_alg crc_t10dif_alg = {
 	.base.cra_priority	= 200,
 	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
 	.base.cra_module	= THIS_MODULE,
-};
+}};
 
 static int __init crc_t10dif_mod_init(void)
 {
 	if (elf_hwcap & HWCAP_PMULL)
-		crc_t10dif_pmull = crc_t10dif_pmull_p64;
+		return crypto_register_shashes(crc_t10dif_alg,
+					       ARRAY_SIZE(crc_t10dif_alg));
 	else
-		crc_t10dif_pmull = crc_t10dif_pmull_p8;
-
-	return crypto_register_shash(&crc_t10dif_alg);
+		/* only register the first array element */
+		return crypto_register_shash(crc_t10dif_alg);
 }
 
 static void __exit crc_t10dif_mod_exit(void)
 {
-	crypto_unregister_shash(&crc_t10dif_alg);
+	if (elf_hwcap & HWCAP_PMULL)
+		crypto_unregister_shashes(crc_t10dif_alg,
+					  ARRAY_SIZE(crc_t10dif_alg));
+	else
+		crypto_unregister_shash(crc_t10dif_alg);
 }
 
 module_cpu_feature_match(ASIMD, crc_t10dif_mod_init);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
