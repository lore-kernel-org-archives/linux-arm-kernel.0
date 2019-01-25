Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A66C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912F121872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mApELt5x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOkV3jNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912F121872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HFhJxdkgTsqL3nBRVV9zXhPZL1jEPML98g61ZLunbK0=; b=mApELt5xn3Q77l9NoSyC4G56hF
	nrufIAyI53dRpRllbHWL/ENO3w61wghsYyosh2DNz/ukwLOp4JTC/e2JH8SRqWgNVAXBMR8iCqyAy
	91/RHzy0PwxMscgv85ymoN08gdislvbefspJQyQr6t1V8tArcNCnZde4bVjnY7cXtnZUIP4posnZs
	NUu6PPAJE6db2ObpanZwLqdn4fuSo7XSYV3qkVaLEU6hhIjnPFuMJecb+j9o96wJB+QNq7chIp9a8
	Rpdm/9GL+4VwE4x4lXB/AOhu5sHhrGL26vWtco3L8KG0x9wY4N8k1M+yagrZDDbh6LLp5QdngtTfE
	zls7Lwtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxBr-00031T-3y; Fri, 25 Jan 2019 08:50:19 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxAz-0001Zv-CA
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 08:49:26 +0000
Received: by mail-wm1-x343.google.com with SMTP id n190so5938296wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 00:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3i4VSVBNJKNuInAMRTH6x98wcOlfnlNxdkcXRyELG3M=;
 b=WOkV3jNPR1KFdSATKSBt83Av+J5wm3/Fl7piyMS0+79fo+majgdNlXYpBLPEBOjs3f
 vJm6vW4JmUFftUoNnMGe5FbZym5jkf2NiN6H/butQcBl/U7UElpctMFACibJpfmBJn7L
 uMMRpCu3uvFsNAr/os/SvoX0EGx/RFxdyDrjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3i4VSVBNJKNuInAMRTH6x98wcOlfnlNxdkcXRyELG3M=;
 b=O1G3Ksn0uNGq8UHCMM2NmDMZS6V+KiryOOSEWsJE7vfCgUU9N/3OUxO2JDTX3IwuIz
 ARw+0sHMyz8IiDoMqMiBG19tUvzTPnfSUnKzl2kA68DbDdfj50kRRFjF6LnyMi0pTScR
 NFVlIJIx2eNTYvysJQY7WRmXQuaeDYgtLleLLo3EuBuG2B/Qxx4ta4pCgKeWaxE6j6xP
 58m0LV/Ehfhdr5+uXF8tiXZd3GboX7YOjwSiAG+BShbGLiv2OXlTXhdSCTyPmtNqAwP5
 7vpv9SWCThOeSXf6GPFsPpjSn1lHhTKXhDPPToNlj1mbvbvrqUjysnmCDfsIMHhqJWzH
 teJQ==
X-Gm-Message-State: AJcUukf4TX1TaBibH1jGaGEt9rvAn618qMpBibBmMMm+Wb4vXWMhn+pF
 MOGCV6Q3nMEKEUx4gSgOs3AOIQ==
X-Google-Smtp-Source: ALg8bN5yG8VMjw023AkQ/AMmf2MX+4ykzzQvDE3Yd6enJgPt+TEHVaBIa3Ieb2e3vAY8244r90NbuA==
X-Received: by 2002:a1c:570d:: with SMTP id l13mr6050823wmb.139.1548406164011; 
 Fri, 25 Jan 2019 00:49:24 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:bcd4:806e:230a:673e])
 by smtp.gmail.com with ESMTPSA id 125sm112594574wmm.26.2019.01.25.00.49.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 00:49:23 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH v2 3/4] crypto: arm/crct10dif - remove dead code
Date: Fri, 25 Jan 2019 09:49:14 +0100
Message-Id: <20190125084915.25411-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125084915.25411-1-ard.biesheuvel@linaro.org>
References: <20190125084915.25411-1-ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_004925_411766_CBD20791 
X-CRM114-Status: UNSURE (   9.47  )
X-CRM114-Notice: Please train this message.
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

Remove some code that is no longer called now that we make sure never
to invoke the SIMD routine with less that 16 bytes of input.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/crct10dif-ce-core.S | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/crypto/crct10dif-ce-core.S b/arch/arm/crypto/crct10dif-ce-core.S
index 16019b5961e7..d058fad423c2 100644
--- a/arch/arm/crypto/crct10dif-ce-core.S
+++ b/arch/arm/crypto/crct10dif-ce-core.S
@@ -342,7 +342,6 @@ CPU_LE(	vrev64.8	q7, q7		)
 
 	cmp		arg3, #16
 	beq		_128_done		// exactly 16 left
-	blt		_less_than_16_left
 
 	// now if there is, load the constants
 	vldr		d20, rk1
@@ -353,18 +352,6 @@ CPU_LE(	vrev64.8	q7, q7		)
 	addlt		arg3, arg3, #16
 	blt		_get_last_two_regs
 	b		_16B_reduction_loop
-
-_less_than_16_left:
-	// shl r9, 4
-	adr		ip, tbl_shf_table + 16
-	sub		ip, ip, arg3
-	vld1.8		{q0}, [ip]
-	vmov.i8		q9, #0x80
-	veor.8		q0, q0, q9
-	vtbl.8		d18, {d14-d15}, d0
-	vtbl.8		d15, {d14-d15}, d1
-	vmov		d14, d18
-	b		_128_done
 ENDPROC(crc_t10dif_pmull)
 
 // precomputed constants
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
