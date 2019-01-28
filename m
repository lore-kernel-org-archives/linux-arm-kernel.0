Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62497C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:58:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133F520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HwT9sjP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133F520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EWXik0t7krmxlkw8BuxoFlAF3i70RlmHFuensgM58eg=; b=HwT9sjP9WdBCQW5EJZDkKXh+pd
	iJ2LCxm9Lilj0vwA0Re87twBv3JQMZhri+21hCACB1g+0dBbOm7hmR7hCae6aRzWZ5+8Xs+yriXzP
	qJK6EtzHWhtwqouwQuWhXivrfzPnAOhorZQyylMch1sjSWrESuf3QqEIS+gdwhIA6r422s2DNB0nP
	fBhAHSRuANP99FjMEVly3AFWVH41K61Lm/ge42JX2ytBpTCZGO385s/NZcRz2aM/uAiS6y6/6+HVr
	tNfBFOu12za0ekbXuOY9lAMZG2P+X2Nv225r/AJs8J4laz9L/vfNBlRAqUChRfJrwp1R64KeZGlF5
	MjU7Z++Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goDzd-0002l8-EB; Mon, 28 Jan 2019 20:58:57 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goDyt-00027D-80
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 20:58:16 +0000
Received: by mail-pf1-f195.google.com with SMTP id q1so8560773pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 12:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JBpjXJf9B20HbiFiRciPMT3D43O2piGyXo3IixwsYxE=;
 b=dVWtqIAzjhZxVKe3SRmnxx8HML0JngOJ+9BHinK3/KOtcz8rZ3VL0A9EXfTVxMJ8nS
 Hr5zOGdGEpWxHzp0opwiQmHF0uLrPCbyaCoQPvHHg3OsrRTYDMZaJTA9VeGptVSW0Z3L
 G5LI9PHq52SYWHvg88OEj4Ci0sfVYjiqolo4BFiYS4Yy//C5eOhdlMDQ9nTbIF4E4GGC
 fOas7tDuvm2Cp2xeQIJ3Xe+ETEHFjB0Cw5sXMGrowyLenxsY8lh5jKNC2JJJMYM6j3mh
 nr43B73bS+12J8VkTB8f23wZuSLGI/+GHZZiNgaAjcT0Dm0HWCHi7WQNC2+43ePmTvWt
 tyLw==
X-Gm-Message-State: AJcUukdd5IbMtfoXP3H8lXeFWCDCCpN4mxLLUI1hDfhC+ZQjvVIFKonC
 imWwBkESIWU3C02w+XsdKvqnT8DmdGo=
X-Google-Smtp-Source: ALg8bN5UpH31w1NhGvwm39h3OpiQL7iA8x8SyKRrrCCFDmBhts3tWjty8vmbtRBEBVYEeBeBpVcxfQ==
X-Received: by 2002:a62:160d:: with SMTP id 13mr23225210pfw.203.1548709090143; 
 Mon, 28 Jan 2019 12:58:10 -0800 (PST)
Received: from localhost ([122.177.107.199])
 by smtp.gmail.com with ESMTPSA id r66sm54282302pfk.157.2019.01.28.12.58.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 12:58:09 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm64: Expose PARange via ID_AA64MMFR0_EL1 and VARange
 via ID_AA64MMFR2_EL1
Date: Tue, 29 Jan 2019 02:27:56 +0530
Message-Id: <1548709076-22317-3-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
References: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_125811_613305_BB0959D7 
X-CRM114-Status: GOOD (  14.01  )
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
Cc: mark.rutland@arm.com, steve.capper@arm.com, catalin.marinas@arm.com,
 bhsharma@redhat.com, ard.biesheuvel@linaro.org, will.deacon@arm.com,
 bhupesh.linux@gmail.com, kexec@lists.infradead.org, suzuki.poulose@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ARMv8.2 architecture hardware extensions can support
upto 52-bit physical addresses (ARMv8.2-LPA) and 52-bit virtual
addresses (ARMv8.2-LVA).

User-space utilities like 'makedumpfile' can try and use the getauxval()
function to retrieve the underlying PARange and VARange values
supported.

An example implementation can be via the 'Appendix I: Example' shown
in 'Documentation/arm64/cpu-feature-registers.txt'. A reference
'makedumpfile' implementation which uses a similar approach is
available in [0].

So, we expose these properties via 'FTR_NONSTRICT' and 'FTR_VISIBLE'
settings for 'ID_AA64MMFR0_PARANGE_SHIFT' and 'ID_AA64MMFR2_LVA_SHIFT'.

[0]. https://github.com/bhupesh-sharma/makedumpfile/blob/9d7da4aad3efe79b448f48cc3454fcae46a316d6/arch/arm64.c#L499

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/kernel/cpufeature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f6d84e2c92fe..5cfc08cbf147 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -194,7 +194,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 	 * Differing PARange is fine as long as all peripherals and memory are mapped
 	 * within the minimum PARange of all CPUs
 	 */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -211,7 +211,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
 static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_FWB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_AT_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LSM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_UAO_SHIFT, 4, 0),
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
