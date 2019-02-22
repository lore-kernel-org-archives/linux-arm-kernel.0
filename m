Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A0AC10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642582086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cRN8vBK+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMURGGIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642582086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=V2IrqrJFBMGKmvfxybTPGhdD/3FrUcPaROtejQN9FAI=; b=cRN
	8vBK+h+7qGyPoR8YAWGMrG/TCMmuMRwleTa3+mzAzdPdb7rc7P0GepuY+DFJKmwCdElFiTfTQo3z8
	85N4kk98BgAvwZBASgG1aR/pFNG+XW+vtFJX3vdk/fFZj/86FfRqns1S7/HW1Mc+AkvcmVtj77g6S
	FcKh+W5nnrjudZiO5elnBWOneh/o+Nc4E8aEun9P0dUgzuoQVQt/e9l9Vn38OQBgi1E6tAiYKF5/0
	ej4S4Mghp0BlYl5M+Yk6RhMBkc5+5IHE9JHcE9QiATJyGALA03rsEu483GOub2APGN8ALpyQMgEPC
	FF6Zu73M9ixE8lNW+Cu0GFBlhHD/dag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx67V-0001lQ-31; Fri, 22 Feb 2019 08:23:45 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx67S-0001kz-3d
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:23:43 +0000
Received: by mail-pg1-x544.google.com with SMTP id u9so787651pgo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 00:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=Rk8dPBdJ2C0H5pzuoEG59eKAB6fJapgFAjXCmyEI8XQ=;
 b=tMURGGIuTedkoj7NevuZpdaLPYCGuOMhgNgH1eBKJyEu82rRI5LZOJTyzyJDteFCat
 J3wjIlWtGA88j8X+VwjgMCQ/9UmnMPJZCYWccuHSW+rxj4Ah1f9DcDlinfrlEvU3fLRz
 WvjcqpDaXq7tNbD6tyUBIswM6YXBFmqNfRGqm9GVim32IOCNRXZ42ZlbBadB8ZLv+RvB
 gMjakxXOrPSnEjpRLHXw3IbfSKhnOvPr+YwDsfn9GkJg8Ewh3F+zGgHgmF2sCuLmg0UF
 i12tyxgDa1EGLGOtxlsV+FQ6jNUxwFWe8v1RiL9Sji/HTqC86qwKCkFB4XUQgtKe5tYE
 5guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Rk8dPBdJ2C0H5pzuoEG59eKAB6fJapgFAjXCmyEI8XQ=;
 b=t1dtIrHDPLJF84vK2hcq8bILo/2JSRt7TDXLDCCfUgxwbt9Qi3OMeTR07z1Ra700d7
 wXb3h3X9bMHWXJFYgqf4arMhlNPwFLLCywdSnV7wotJVfydQouAlhjw2tUfp3XyLanjD
 dlN+QQrVTiyntdqMZGbQLqSzhdpmkvBbp9UJ1LJkD9xs3PsVwEFqcsN5moFd9ckqM/kS
 mlN9VPVQJrH90QWbeFulD/KpVyThs8GJ4tsuWGbMVnVCP9oumqaHvYsOT698m/v7QOFv
 O0l2KENTm9ATxJfHFF27A59XkW5ZKeF7Xp91+btRYw2Pgb1G8mYoU49XfoNfD4t0FuIt
 8bWw==
X-Gm-Message-State: AHQUAuYfFKu8WDEKuJ4YwHSnP/r4o1dFkmlnm//sxBd7iHp0+94m8QVg
 H9CNUVYfnZ9xWiB1Qw3CH8Y4Dw==
X-Google-Smtp-Source: AHgI3IYXCPZwppu9S4z1lHFWmqopoN/SXnz6Ozl9hQF+Nh77shHtJUsFNsLoQQdoG+gjnVCaYCoHYQ==
X-Received: by 2002:a63:2ccd:: with SMTP id s196mr2848444pgs.194.1550823820858; 
 Fri, 22 Feb 2019 00:23:40 -0800 (PST)
Received: from localhost.localdomain (li1195-158.members.linode.com.
 [45.79.96.158])
 by smtp.gmail.com with ESMTPSA id y22sm133821pfn.136.2019.02.22.00.23.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 00:23:39 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 James Morse <james.morse@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Jun Yao <yaojun8558363@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] ARM64/KVM: Minor cleanup and refactoring
Date: Fri, 22 Feb 2019 16:23:22 +0800
Message-Id: <20190222082327.3312-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_002342_150294_348EC051 
X-CRM114-Status: UNSURE (   9.58  )
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
Cc: Leo Yan <leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When I read KVM/ARM64 related code I cannot find any issue or something
could be improved for performance; so this patch series is only for
minor cleaning up and refactoring code.

Hope this is helpful and can be picked up into mainline kernel,
otherwise it's also fine for me if the maintainer or main developers
could note these points and fix them in appropriate time.


Leo Yan (4):
  KVM: arm64: Use macro to replace hard number
  KVM: arm/arm64: vgic: Improve comment on kvm_vgic_inject_irq
  KVM: arm/arm64: Define TCR_EL2_T0SZ_MASK as TCR_T0SZ_MASK
  KVM: arm/arm64: Fix comment on create_hyp_mappings()

 arch/arm64/include/asm/kvm_arm.h | 2 +-
 arch/arm64/kernel/head.S         | 2 +-
 virt/kvm/arm/mmu.c               | 2 +-
 virt/kvm/arm/vgic/vgic.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
