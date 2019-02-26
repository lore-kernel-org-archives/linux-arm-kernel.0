Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9250BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:36:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B472173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IdZPHDiw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jayTq/a4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B472173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JIoJRd2MF3RcXBflLhqVX9ElBztjYO/cJvNS/6s5Tj8=; b=IdZPHDiwO8UHbV
	p0jXB93PZI0hUq4y2Ro2hbBt884wMtGsjXNeJP3wfvY4nCN/ji0HIAVVgOQ3shCn0t30u68ugYEaB
	J3tklkB44WfNKzvSIS8O7KBGYb+pAj6i0WKk1F53gTMFqNrSWSodEcrg0bnb2R4zdiUiEoc4BXWDn
	YJMbSBT+vp3qM8E67rsfk5YmwqkcTwo5MnShINOvDfwgDZuankJ0LcMzMFNbE5/q9/NAIClE9NvVS
	S/cz7jsZKmW6b48iScIYTt3YWLKKnmNvP5Lvd91wPq92MYBNHNv2HvXDOFETRY81waRmbF+JVXSuJ
	KE3A6jJcAqw94j69IESg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyb2D-0001kY-9m; Tue, 26 Feb 2019 11:36:29 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyb29-0001kB-WA
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:36:27 +0000
Received: by mail-wm1-x343.google.com with SMTP id o10so1931470wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 03:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ygwzYjxTYz+ZAFDwFYmxXh7zqKZocWCIqOP15d9vEPM=;
 b=jayTq/a4sDgWzxsfxGeXUSQ8oV9mkWUxPbHwGlYDCAriSedj7Dx88NpTkF+upKrtEv
 0lPjbEf58Oh+vAZkiLjkegFS6BmASqhVxpFRev+5m9TUn++n5qo3tXrstZxg2jpMydfu
 I9kSKqGyB7MRKPYPo1z/e6t6bN8nDH8D16DU9MUPM2YjQIMEWwuvR4VydCwai3P5hBTm
 dKUA1Gye/c78pltLmv07BJEVt103FueW50B/+Lb1x/qdDbCdWSoZ/CIbIYVzzCdbnQu1
 ec0CMCHyvZudUmYCIKIzggITFzBRv2aG1TyuChKsROSI0xxLWRURImr+RV5+vpd7DKDv
 Rufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ygwzYjxTYz+ZAFDwFYmxXh7zqKZocWCIqOP15d9vEPM=;
 b=WxkxQWaoRIlRX2DVBDUbOE8ZRqQ5wmPEAZqZA/RU6/FdwrmrRjtQ0dIufDBBCYt80l
 g6a3r3eCMWa+itLnQvD1DgBTjCfkp0Ab8i9AGb1MwpfRirSXG00ig2wLz4S9QVahLU8+
 4XFLzncTNWZJbkSmPDA99C43XU9RTsrhaOY6xvP6OGUCCmvbwtNjf3KD/twSMV1iwqnb
 9G2dpo591HjBwBRMJ5b6e6JTtiKLZqP7O+sUIrRnd4PT+PwwM2XDbFMYtekgss3noWpK
 q9/5WoCgXkWyOHztlJOrOV6rkfmq7g4tGt0uQ+fdyxrp8C1Osgf3IwG3P86F9+0FSNLE
 FcZQ==
X-Gm-Message-State: AHQUAuYJL537RPvKQ8JG/QPiB071WugLHDMzwoOpcxGjkn0KNN/ABzn8
 E15FKjEpOgOljGP0vLioknIPsRefi3M=
X-Google-Smtp-Source: AHgI3IZDejlwzrNxExlFKpSuTH0fJdyYMHOcokpzroGDFygMIdGrjcAt7cgk3HT3q8Cx4wOvvVwy3Q==
X-Received: by 2002:a1c:a941:: with SMTP id s62mr2373020wme.16.1551180982747; 
 Tue, 26 Feb 2019 03:36:22 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-1-152.w90-86.abo.wanadoo.fr. [90.86.118.152])
 by smtp.gmail.com with ESMTPSA id w10sm16133659wru.5.2019.02.26.03.36.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 03:36:21 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] lib/raid6: arm: optimize away a mask operation in NEON
 recovery routine
Date: Tue, 26 Feb 2019 12:36:18 +0100
Message-Id: <20190226113618.17891-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_033626_039150_7976B48C 
X-CRM114-Status: UNSURE (   9.60  )
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com, jeremy.linton@arm.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The NEON recovery code was modeled after the x86 SIMD code, and for
some reason, that code uses a 16 bit wide signed shift and a mask to
perform what amounts to a 8 bit unsigned shift. So fold the ops
together.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 lib/raid6/recov_neon_inner.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/raid6/recov_neon_inner.c b/lib/raid6/recov_neon_inner.c
index 8cd20c9f834a..f80e8cead9cf 100644
--- a/lib/raid6/recov_neon_inner.c
+++ b/lib/raid6/recov_neon_inner.c
@@ -60,14 +60,14 @@ void __raid6_2data_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dp,
 		px = veorq_u8(vld1q_u8(p), vld1q_u8(dp));
 		vx = veorq_u8(vld1q_u8(q), vld1q_u8(dq));
 
-		vy = (uint8x16_t)vshrq_n_s16((int16x8_t)vx, 4);
+		vy = vshrq_n_u8(vx, 4);
 		vx = vqtbl1q_u8(qm0, vandq_u8(vx, x0f));
-		vy = vqtbl1q_u8(qm1, vandq_u8(vy, x0f));
+		vy = vqtbl1q_u8(qm1, vy);
 		qx = veorq_u8(vx, vy);
 
-		vy = (uint8x16_t)vshrq_n_s16((int16x8_t)px, 4);
+		vy = vshrq_n_u8(px, 4);
 		vx = vqtbl1q_u8(pm0, vandq_u8(px, x0f));
-		vy = vqtbl1q_u8(pm1, vandq_u8(vy, x0f));
+		vy = vqtbl1q_u8(pm1, vy);
 		vx = veorq_u8(vx, vy);
 		db = veorq_u8(vx, qx);
 
@@ -100,9 +100,9 @@ void __raid6_datap_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dq,
 
 		vx = veorq_u8(vld1q_u8(q), vld1q_u8(dq));
 
-		vy = (uint8x16_t)vshrq_n_s16((int16x8_t)vx, 4);
+		vy = vshrq_n_u8(vx, 4);
 		vx = vqtbl1q_u8(qm0, vandq_u8(vx, x0f));
-		vy = vqtbl1q_u8(qm1, vandq_u8(vy, x0f));
+		vy = vqtbl1q_u8(qm1, vy);
 		vx = veorq_u8(vx, vy);
 		vy = veorq_u8(vx, vld1q_u8(p));
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
