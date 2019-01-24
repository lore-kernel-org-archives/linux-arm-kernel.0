Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A35C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:28:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED48218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M1OMZ0It";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIpSZUY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED48218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=weayzAmtUAQv1wMCXh3Ga5Y6C/URxyMyoHKI7phLF5k=; b=M1OMZ0ItoLPMTeKpPXKN96whBb
	Ynv7az9zYDjRR6DSQOVZxVmW2DN91WGbU7Ee9hCZ0anKhfzs5a/Z54UN//hzoIQMfhW2ma6jUZKCj
	3ze0BUo7x+wJGZTx+eqTy0ubX01ilI18SLrbnoX4R9jSfFNPtujwzQUjEOLP6hjV6uuNl3DF51gfd
	9j9LmKHbxksjTX+mqrtw0SzBkcnp0aMYR1OwQQE3j87oWPF/QDG+67Da4TbSexTEjXwbfBPUfCx7W
	mSggriL0zdLgzXXbM/UWIsblg+2g2m3luW24Tyf4ygOT0kdhzE3uZiLfx7p0KP+taa2bVIQUOuqOZ
	ZgVFNIDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjjF-0002Ma-L2; Thu, 24 Jan 2019 18:27:53 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjik-0001vy-VG
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 18:27:24 +0000
Received: by mail-wr1-x444.google.com with SMTP id u4so7598766wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 10:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3/1JsJbOO9AapMWTRThG5LlPeoGHhP1SPxErwHi+5nY=;
 b=aIpSZUY3HDECVs6ewDdoEN9Hdyis2ferKU36Vhx9iyGGId0acU/LfAtbxIhx6gcIuE
 7XMpikyGfot/vqiMvqbqgqh7pC9Qnp7EPME7IXlJRVzkUbJFdwNoHJfXc82NiVyZWluV
 7PGeqVprHgmqPoVodW4vgj54HJ0cZh7Y33O5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3/1JsJbOO9AapMWTRThG5LlPeoGHhP1SPxErwHi+5nY=;
 b=ZG9jhhgA8rMvFIcnqVixwfmUQ/mHBK4dq/HM0kiw7YK7TK12I7yVr/1Rcl6Vg/yK5s
 JT8Rx7hclJh+CsmIZiU11knDGF4Yiey0TgA/1UZM6j22Xh0otMnCitxqbAhNkeg65pMc
 oMwSBqxJJSWG/PjkqzjHUB9eXn53R6zQpX1b4WxxQAT38a8ie0+DBMKVseOdzNgb6Paq
 vW+NiPjbehaojDIkdrBUZkKJZwpXR3Xnd7t9pqrUSeIGPMGV7QNO+PYEaU2worwbsEtP
 Q7s98Bb+GwX9yTebNyJ8eWRpzODRuUi7toGyLKS83WyqVq+GC2R6NZh7fHhKde5iv+fh
 m/uw==
X-Gm-Message-State: AJcUukcVj74EdAO5yQ1Vb79LL3hE56Tw6PUszs9h1So3giDEDOF6aozL
 cmWHiAlhmzWZJV/s2LFXj8ADFGnQVRdIwQ==
X-Google-Smtp-Source: ALg8bN5yh+PmaunQIPmSunyPL7mY0/f+bAONZd8HEZ9jOTYMa5GuN6haDGb2R1JUvqukAQ09htcm7g==
X-Received: by 2002:adf:f550:: with SMTP id j16mr8145818wrp.258.1548354441226; 
 Thu, 24 Jan 2019 10:27:21 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:bcd4:806e:230a:673e])
 by smtp.gmail.com with ESMTPSA id 202sm73247138wmt.8.2019.01.24.10.27.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 10:27:20 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 2/2] crypto: arm64/crct10dif - revert to C code for short
 inputs
Date: Thu, 24 Jan 2019 19:27:12 +0100
Message-Id: <20190124182712.7142-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124182712.7142-1-ard.biesheuvel@linaro.org>
References: <20190124182712.7142-1-ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_102723_000812_9AF71F70 
X-CRM114-Status: GOOD (  15.70  )
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

The SIMD routine ported from x86 used to have a special code path
for inputs < 16 bytes, which got lost somewhere along the way.
Instead, the current glue code aligns the input pointer to permit
the NEON routine to use special versions of the vld1 instructions
that assume 16 byte alignment, but this could result in inputs of
less than 16 bytes to be passed in. This not only fails the new
extended tests that Eric has implemented, it also results in the
code reading before the input pointer, which could potentially
result in crashes when dealing with less than 16 bytes of input
at the start of a page which is preceded by an unmapped page.

So update the glue code to only invoke the NEON routine if the
input is more than 16 bytes.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/crct10dif-ce-glue.c | 25 +++++---------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/crypto/crct10dif-ce-glue.c b/arch/arm64/crypto/crct10dif-ce-glue.c
index b461d62023f2..567c24f3d224 100644
--- a/arch/arm64/crypto/crct10dif-ce-glue.c
+++ b/arch/arm64/crypto/crct10dif-ce-glue.c
@@ -39,26 +39,13 @@ static int crct10dif_update(struct shash_desc *desc, const u8 *data,
 			    unsigned int length)
 {
 	u16 *crc = shash_desc_ctx(desc);
-	unsigned int l;
 
-	if (unlikely((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
-		l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
-			  ((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
-
-		*crc = crc_t10dif_generic(*crc, data, l);
-
-		length -= l;
-		data += l;
-	}
-
-	if (length > 0) {
-		if (may_use_simd()) {
-			kernel_neon_begin();
-			*crc = crc_t10dif_pmull(*crc, data, length);
-			kernel_neon_end();
-		} else {
-			*crc = crc_t10dif_generic(*crc, data, length);
-		}
+	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && may_use_simd()) {
+		kernel_neon_begin();
+		*crc = crc_t10dif_pmull(*crc, data, length);
+		kernel_neon_end();
+	} else {
+		*crc = crc_t10dif_generic(*crc, data, length);
 	}
 
 	return 0;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
