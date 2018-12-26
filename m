Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFFEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:46:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18977218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MSuBEk+S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GNmZUn9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18977218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9JOAGGozSO6jlcZ0xJO4Kpoyhzo7clsTno6KZnRelAs=; b=MSuBEk+SovNjU3
	z2btuASPno8QNf0UNaA8mSqS0p6AU/r3e7sayzOan+HJDLjYdiCx7sgPZXBylUp4Ug1Gi00IpmCue
	z88iPY4UgJow8XAQc21WDjjgKrHIrqyeGDAfvrJbSCshyA+QfEZhSsNTM5lT0zlJCXtdyrY6yCTtj
	9oPWwQzc/m5xaxFw4td0ZUbNejif38I98eQPBr/YZwojoHS6y/9WrfP4ni1lHClFh4jx5mLV4jMgV
	3TzEMHQ5l+50DTwVGFgTt8VXIfToBQD7QC8DIorKkTM1dmk77sTJBv6m2tLw2Fo1aG12pMjycf89M
	tIxupRhHh28H2z7AtPCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcCJj-0004Yb-Uz; Wed, 26 Dec 2018 16:45:59 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcCJA-00043O-G3
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 16:45:27 +0000
Received: by mail-qk1-x743.google.com with SMTP id q8so9595130qke.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 08:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=a/LUwAP4xu+zNakjYJJ48vD4f9YrE1P+QIINyrItNIo=;
 b=GNmZUn9K6Tn2ODocJgkuyy3A7xgsDN0hL4FWSQLm3kh8j6g4isGWpG8o93hWu4pigN
 u0Gg8w5h3DBG2DLFiiKh8KGIGUzjNI0EmCf4h/43KOF0FXXNBMMP9gQpZNglJ+let7P7
 8h22Skam697IhbSbUnwIUNGVP3GW/Q6xe4zJZQpLVKhRL8rwn+m+vGU1sbDx7SON17ro
 Y3tMCC/6zNvLK3OJvStI4DSD/4wJr2R9nSP7eLVlUAw6nbbzrlW4QrMOMxfk79RFF1rU
 YPTwgAplTcLDg/WN065zarbvVwKKjiM7/iwde0SzAU3EONCFmWlU2CpDTl2K25Ue52Uq
 VqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a/LUwAP4xu+zNakjYJJ48vD4f9YrE1P+QIINyrItNIo=;
 b=aXBTmIIWMRCY/Yq4MVLzlnZMXP1guxD03J5SlqTSkDFnyrD4eSiydQMqhfvNm/3r72
 W4Ut08KUqgDLgN2H4vPbuG/rX19PmdDPwwv3LIQTEaxuLY9JIm29beIoyEXweENLcMDy
 N495MDAqYsrCfcXlvDVZmIwOOE76kD7sm4sysyFG8gWnOBMQHFva10x2pYtiuOLu5Jzu
 DPAJoq1+jXfHB5ExNSVA3kyKkgTOPTv5P0CJgD+RMeabN9rfrq2RiUxvBg8cI3fWk5FA
 KUoTks2z0eU0xNVpyFWIte1Ne9CRLVTT4Zp6tQxM12GA1/zWWqRzZE2E/pTQQ0bEFG8x
 itww==
X-Gm-Message-State: AJcUukcSuyNzQFTZBIQI0omOlw4zOOIF0regVYgPoahmMhtWm0QEv3j4
 xUdY5tcb66Bf44vAveE5C4X1fA==
X-Google-Smtp-Source: ALg8bN4qDJrXi30Gm/7gnRxTo2mkmliB5xWpXzK1jd9T94cUilZmTTKyrqwSwz39ZYtoAFTRG4GcUA==
X-Received: by 2002:a37:7b01:: with SMTP id w1mr18816380qkc.122.1545842714264; 
 Wed, 26 Dec 2018 08:45:14 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id m41sm17874920qtc.58.2018.12.26.08.45.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Dec 2018 08:45:13 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
To: catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org,
 rppt@linux.vnet.ibm.com, mhocko@suse.com, ard.biesheuvel@linaro.org,
 andrew.murray@arm.com, james.morse@arm.com, marc.zyngier@arm.com,
 sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com
Subject: [PATCH v3 2/3] arm64: vdso: Use ARCH_TIMER_NBITS to calculate mask
Date: Wed, 26 Dec 2018 11:45:08 -0500
Message-Id: <20181226164509.22916-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181226164509.22916-1-pasha.tatashin@soleen.com>
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_084524_576047_4BA1A10C 
X-CRM114-Status: GOOD (  11.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

get_clock_shifted_nsec macro in vdso/gettimeofday.S has another place
where the size of clocksource precision is hardcoded. Use
ARCH_TIMER_NBITS to generate mask value.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/asm-offsets.c       | 1 +
 arch/arm64/kernel/vdso/gettimeofday.S | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 65b8afc84466..32e1b935dd6c 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -107,6 +107,7 @@ int main(void)
   DEFINE(CLOCK_MONOTONIC_COARSE,CLOCK_MONOTONIC_COARSE);
   DEFINE(CLOCK_COARSE_RES,	LOW_RES_NSEC);
   DEFINE(NSEC_PER_SEC,		NSEC_PER_SEC);
+  DEFINE(CLOCKSOURCE_MASK,	CLOCKSOURCE_MASK(ARCH_TIMER_NBITS));
   BLANK();
   DEFINE(VDSO_CS_CYCLE_LAST,	offsetof(struct vdso_data, cs_cycle_last));
   DEFINE(VDSO_RAW_TIME_SEC,	offsetof(struct vdso_data, raw_time_sec));
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index c39872a7b03c..5a7580d0118e 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -69,8 +69,7 @@ x_tmp		.req	x8
 	mrs	x_tmp, cntvct_el0
 	/* Calculate cycle delta and convert to ns. */
 	sub	\res, x_tmp, \cycle_last
-	/* We can only guarantee 56 bits of precision. */
-	movn	x_tmp, #0xff00, lsl #48
+	mov     x_tmp, #CLOCKSOURCE_MASK
 	and	\res, x_tmp, \res
 	mul	\res, \res, \mult
 	.endm
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
