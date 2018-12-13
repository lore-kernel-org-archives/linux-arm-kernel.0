Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5055FC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:20:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F2E20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S7b9bJCC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHzQj5OW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F2E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4HABmgpn8X1rHsx3tupM4B4NaR1xT77J4wXGQ5FlDfM=; b=S7b9bJCCpOR+0i
	15caOdbAfkQ23pQk9FBKWMyL7Tx7trOLE13bxQDwzYEA9ETl0imJ/b5gXtfmzHMDn7Pa7rG4lKy81
	I8qS1lL6cpZFMa8jVXRASCYmXS9tFdt1dC0WMQBYeW96hLrJ7kgK2uSGa3Kn82KPjTvPFhr+CEzJL
	jy/1Ebd6uCuJL/uAfoMhobs4lMj5Ynprbujq5e8EIoYpo4qtQQqI95Lt/9zPLF5pfD6Axjk8Hnwfy
	eDb+qwobZg6vNU/NrsH2YgPFyBRhRXUk0b+5fEaOS0ULm3knOE/g3wwhMDMV2oy9P2JXnrwCVf2dz
	DgZEbebqLzCgEjygM1Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUfQ-0007Cs-Ne; Thu, 13 Dec 2018 17:20:56 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUfM-0007B9-PH
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 17:20:54 +0000
Received: by mail-wr1-x442.google.com with SMTP id j2so2850084wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 09:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8vIR/RSSQNKgibaNawICRtlo0zHmdN7lndaHrEMthSA=;
 b=iHzQj5OWSoAwEEszRAX/TXw3mfMmHUsVmSMXhLCHgnBUrHoxDZYD695+cDJvwC/Rxy
 /VhA5HZM77oh5siBgiSd5/jJ/ry+BB5Udta21wR/aP6sPNHhWsl1GwQrqSphOP4mJ1OE
 D5utLVENB/oTeNLFYYkc9nqMW3peGCSF+TXNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8vIR/RSSQNKgibaNawICRtlo0zHmdN7lndaHrEMthSA=;
 b=MPL5tubJ+jTWHFLhYb5y46e24iepBaAv/3S9kzBeM3iCGSkwvN5QlziDnhO41IZBbR
 rrqj9JDwGHd8jc5t0nlnATmjPPGkKXxV8OFEjlHT1/k5Z0K9+K7bNslzinrGMGwuHjBS
 lDPRx3hit3ECW/dF/H0pS7/9kDgWnvA8jAkvfV2vi5EG1wxt4BfoL+2bV/AqJaPkKseO
 bwXI85z3gSVSI1YtSanILpbKnmdzj+mR85yhbkIu3PXcHCnNIjNasK3Ae/Nl+kK5pupI
 +4NHstOoi1UXCDepvSty39HaepTP7n4GjNeYVPDCUqGxvMu6qLRcDFQvr0PtB5Y9hxNe
 7HKg==
X-Gm-Message-State: AA+aEWYBBo5/6+/nuQRpwX3axF7SbsUImbBJT19QgAJE8TZdX9qZ8ENw
 buEL/2iN5rg/36dovj6Fbjm44iat3/UKNg==
X-Google-Smtp-Source: AFSGD/VC9/qJ1UBT6hjyLXukpaFIEHyREyvjZBcHsX54JnABERJce67A7b2opw6YYa4+yMHsqyHQZA==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr22567326wrs.279.1544721640779; 
 Thu, 13 Dec 2018 09:20:40 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id q12sm2902753wrx.31.2018.12.13.09.20.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 09:20:40 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/4] arm64: kpti: use nG mappings unless KPTI is force
 disabled
Date: Thu, 13 Dec 2018 18:20:31 +0100
Message-Id: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_092052_817270_CE34212F 
X-CRM114-Status: GOOD (  11.28  )
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
Cc: Robin Murphy <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>,
 Will Deacon <will.deacon@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

John reports [0] that recent changes to the way the linear region is mapped
is causing ~30 seconds stalls on boot, and this turns out to be due to the
way we remap the linear space with nG mappings when enabling KPTI, which
occurs with the MMU and caches off. Recent kernels map the linear region down
to pages by default, so that restricted permissions can be applied at page
granularity (so that module .text and .rodata are no longer writable via
the linear map), and so the number of page table entries that require
updating from G to nG is much higher, resulting in the observed delays.

This series refactors the logic that tests whether KPTI should be enabled
so that the conditions that apply regardless of CPU identification are
evaluated early, allowing us to create the mappings of the kernel and
the linear region with nG attributes from the outset.

Patches #1 to #3 implement this so that we only create these nG mappings
if KPTI is force enabled.

As a followup, #4 may be applied, which inverts the logic so that nG mappings
are always created, unless KPTI is forced off. This allows us to get rid
of the slow and complex asm routines that make this change later on, which
is where the boot delays occur.

[0] https://marc.info/?l=linux-arm-kernel&m=154463433605723

Cc: Will Deacon <will.deacon@arm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>

Ard Biesheuvel (4):
  arm64: kpti: enable KPTI only when KASLR is truly enabled.
  arm64: kpti: add helper to decide whether nG mappings should be used
    early
  arm64: kpti: use nG mappings from the outset if kpti is force enabled
  arm64: kpti: use non-global mappings unless KPTI is forced off

 arch/arm64/include/asm/cpufeature.h |   7 +
 arch/arm64/kernel/cpufeature.c      |  63 +++----
 arch/arm64/mm/mmu.c                 |  14 ++
 arch/arm64/mm/proc.S                | 189 --------------------
 4 files changed, 48 insertions(+), 225 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
