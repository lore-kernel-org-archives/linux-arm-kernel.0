Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F57C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:50:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6C02184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mpQP2ehb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPkraV46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6C02184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=qZdSj3HnFri55M4Rjos1TEYSy6QXCLdKFBPTIFOsK7I=; b=mpQP2ehbSC40ARXcWYJk5SqPbe
	W+ojkpun0IQTFxSEgWVtDl001hoEYUPcO3PaLBnWhOKAhcxihj1m5Gq9GsEmiL6T6KgkMV6PNz1F2
	MJNQr1OFqtNWIxvWSEuoFtU3dr2Br87tdBKUW357n34xobG5o5VNHP25jjsrzp8vWsYnepeSajO3S
	YUURrwHXW8T6NIz5MhLXfdYAHGpz2WhdJa+tPxS/wOM5k8g3janHdsocLL7qnONPmeOjdh33k2/3j
	MipukzaB4DGryqlwhx9UBGqsDIl3w66GvOl2Rqf5p45t5tY1ntxN3K66ZtI7q/f4cTpidswxe6LEJ
	cihNWdHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxCA-0003kb-3j; Fri, 25 Jan 2019 08:50:38 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxB1-0001aJ-SX
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 08:49:30 +0000
Received: by mail-wr1-x444.google.com with SMTP id x10so9357237wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 00:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QFSZhvF+yrpzjeTHaCnpll1v88xs3SlfZeNFA3N5zyA=;
 b=SPkraV46WkjaW96OwSsLHJMGUz4QGmjYGjX4wvViBe4uTu0FlvEpLmiXh907DhbGxt
 K7cM8SNRpdVFV8YkWhm+E0Ugw1qjVVx0Irlc+nyFjBhcmTQY4sURfRa+4HUejlv6+RdM
 XxVs1X/+XrwY1jjHIUfVix8D5cbTYvwWYgaeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QFSZhvF+yrpzjeTHaCnpll1v88xs3SlfZeNFA3N5zyA=;
 b=kE/hPTNEOsv4e8QaX4NlXxg6v2TKJF/UxGdrCINhMRVYPEMAtaVtc9Zoh5/MFttP8l
 rXV1HLqqrUxhaQMtIRXi7ys0hpd2r7Nb2hQXE3y+0wsh3tQn0ulowBe3tLSK9pmGVDh7
 kXnRvV0N0p8Ju/u/Bu+6Ww7CtQD1grFuunqieI7FaFJrTlRnN1x0sH0WTNpCdZiTEkX3
 Cc+SpUAtF6Tycm8UgCp2Qsl3XL1PzLpf/DPu37sSazsQw7+OJTStgylNgoIgITMhhbqW
 qaF4MhavflvEX5uF8KjGepWYaUsKlCj73dQEYxSi3BDvWHN4wZYtm8qMj1Nvla7RCFug
 Nt4g==
X-Gm-Message-State: AJcUukduACPUdDLHY6pKTcurcVSeg/ZyFxwn9FkJkYUo8f9qb/0Mw7FG
 d7ATQwfJmv0WbQ+Y0lzwiyBUnQ==
X-Google-Smtp-Source: ALg8bN4E27F/EvY+d21USspOx5C4QpSR+ymFl6dX/SHKbCQiDY4T0CwMUi4CpB3PoLhC1xYzqOFIyA==
X-Received: by 2002:a05:6000:12c4:: with SMTP id
 l4mr10349471wrx.134.1548406165286; 
 Fri, 25 Jan 2019 00:49:25 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:bcd4:806e:230a:673e])
 by smtp.gmail.com with ESMTPSA id 125sm112594574wmm.26.2019.01.25.00.49.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 00:49:24 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH v2 4/4] crypto: arm64/crct10dif - remove dead code
Date: Fri, 25 Jan 2019 09:49:15 +0100
Message-Id: <20190125084915.25411-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125084915.25411-1-ard.biesheuvel@linaro.org>
References: <20190125084915.25411-1-ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_004927_997103_F6533E0B 
X-CRM114-Status: UNSURE (   9.61  )
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
to invoke the SIMD routine with less than 16 bytes of input.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/crct10dif-ce-core.S | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/crypto/crct10dif-ce-core.S b/arch/arm64/crypto/crct10dif-ce-core.S
index 9e82e8e8ed05..f7326259c40d 100644
--- a/arch/arm64/crypto/crct10dif-ce-core.S
+++ b/arch/arm64/crypto/crct10dif-ce-core.S
@@ -497,7 +497,6 @@ CPU_LE(	ext		v7.16b, v7.16b, v7.16b, #8	)
 
 	cmp		arg3, #16
 	b.eq		.L_128_done_\@		// exactly 16 left
-	b.lt		.L_less_than_16_left_\@
 
 	ldr_l		q10, rk1, x8		// rk1 and rk2 in xmm10
 	__pmull_pre_\p	v10
@@ -509,16 +508,6 @@ CPU_LE(	ext		v7.16b, v7.16b, v7.16b, #8	)
 
 	add		arg3, arg3, #16
 	b		.L_get_last_two_regs_\@
-
-.L_less_than_16_left_\@:
-	// shl r9, 4
-	adr_l		x0, tbl_shf_table + 16
-	sub		x0, x0, arg3
-	ld1		{v0.16b}, [x0]
-	movi		v9.16b, #0x80
-	eor		v0.16b, v0.16b, v9.16b
-	tbl		v7.16b, {v7.16b}, v0.16b
-	b		.L_128_done_\@
 	.endm
 
 ENTRY(crc_t10dif_pmull_p8)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
