Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8096C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6BF214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CO1wuGCk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4ObU8n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6BF214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xrsQ6/gaHyWY4jyiRqtZ3zBLHFaxIyIdAoR/0Na/j0M=; b=CO1wuGCk8K3IoO
	dBpK8sQWwHPJOtUU5FGXXAYur5a6e0rZZLspczxwvhwgCPCiTibh2SWqf3qEc45n6E/H1N1mChV2w
	9PN/BTk3P4e/LYskd1IciVVtFx3NnX1wUPibvOqFzuyra8QC3rf+2HcnXH7l62yfbwitulDVZodpv
	8pqacPIWKRXRx3McRGJGQPyXbgu8K9UEHTdaD0+ebLf6jvwL1h0GP7uwuMcmj9Raq8WOmPl6lTYXg
	PgwfvywNI2V5COu8Ol7KvN1i+4I6XOtzDlXxQB9QWkQDbjCTw3MPFz4evKKNlSkkO0kWun+iRKpl8
	B0PyG5pPuBhYv3lpY8VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUw4C-0003EU-OE; Thu, 06 Dec 2018 15:59:56 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw49-00038s-0M
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:59:54 +0000
Received: by mail-wm1-x342.google.com with SMTP id s14so1514848wmh.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 07:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HsOLDUWwS8wWEQ+PD9JmGHJK/WLq/vNZaVg+lNHLzj4=;
 b=O4ObU8n11TBr2ObnmJrGLcsQN3HvgIP5sU1+BuOrpY7vMygSWU3d6W9+76PAeBS/fY
 ENBpFShrhNiSOWQ1xsLuuDgFMAB982FPJ+EIWj3+eZvWrkC/CbKKQG3f1JKtreMG4UWH
 Wn9aP5/upm/BeA++LtzUvDtozSI7nFkzXZPnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HsOLDUWwS8wWEQ+PD9JmGHJK/WLq/vNZaVg+lNHLzj4=;
 b=ahrMXso0FVEJWFfqYgn8vhX0Q3p76ziWByO2AEF3e3tW+Egl4gBf90scgGFPu+Jm+t
 30oa4ssHIiYnJYPFJr6WEhS27gijafS/FKpAEBjLHc5tkiLDATNdMkFB2yf1g9ihwOkr
 p6L+JtX2Q+dHArVYjCHrUW9G6QMBHAMOre6hGT4fRQOvmjFdrS2zdu2DBxIinCa0Rl/A
 53pdf6FhpnconAgCTDMEB7k2/t3b/uRjFvcLooBAJXR9Gd8gQOFgWA7QD89OYNPAlvBK
 kscJeIogzEzklv3RzI4gGq5twp/rPxHHK5p5OQsoflcOvSmLpJxp8gKULZhVnMANfyrm
 3OEA==
X-Gm-Message-State: AA+aEWZbtUdAnpOUBW+br3av31RHjGUAAOJTpU3h61T2LTluokOKa5gN
 w7poKqFSPFqM1fVAM+cnppUv7w==
X-Google-Smtp-Source: AFSGD/UslGuIVtLy5O4X2xEgkigRmH0XwoOq8dX9DZs4zGkT8FRe3OjgscFlOotup9DUk/krCQFIow==
X-Received: by 2002:a1c:128b:: with SMTP id 133mr21076331wms.22.1544111981435; 
 Thu, 06 Dec 2018 07:59:41 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id y34sm1525233wrd.68.2018.12.06.07.59.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 07:59:40 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] arm64: assorted fixes for dcache_by_line_op
Date: Thu,  6 Dec 2018 16:57:34 +0100
Message-Id: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075953_042322_11B02E45 
X-CRM114-Status: UNSURE (   9.83  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This fixes two issues in dcache_by_line_op: patch #4 fixes the logic
that is applied when patching DC CVAP instructions, and patch #5 gets
rid of some unintended undefined symbols resulting from incorrect use
of conditional GAS directives.

Patches #1 to #3 are groundwork for #4.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>

Ard Biesheuvel (5):
  arm64/alternative_cb: move callback reference into replacements
    section
  arm64/alternative_cb: add nr_alts parameter to callback handlers
  arm64/alternative_cb: add support for alternative sequences
  arm64/assembler: use callback to 3-way alt-patch DC CVAP instructions
  arm64/mm: use string comparisons in dcache_by_line_op

 arch/arm64/include/asm/alternative.h | 54 +++++++++++---------
 arch/arm64/include/asm/assembler.h   | 17 +++---
 arch/arm64/include/asm/kvm_mmu.h     |  4 +-
 arch/arm64/kernel/alternative.c      | 22 +++++---
 arch/arm64/kernel/cpu_errata.c       | 24 ++++++---
 arch/arm64/kvm/va_layout.c           |  8 +--
 6 files changed, 79 insertions(+), 50 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
