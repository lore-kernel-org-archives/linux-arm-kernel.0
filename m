Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28848C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:31:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E962820B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PNqDpQjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E962820B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=lMwgNtwL0rTPgoD7zWymO88vmkWfOxOij2g7EV2kYco=; b=PNq
	DpQjTKPpJ15wrrTn3T1ZD1NQOh+IzYB44f6Xf4C2cPL7zwkeoLsf2b4ueNX7Ayw82N1jvBjB3at7k
	mFG6/VXi5MJlvYu924d1YCsE/ZS6X5QivnxLOO4xoMxDv85MqAXx4pscLJDYhCAGeobdg+L+JsqOv
	XRAY3XyiIXAdX4LLIieYWVqpzlaB+5j//TvGLxxe8UOKer7fSWP3Ooq5+7wYeVae5LXKRTvLbOhBB
	A4ouu3vIKYAnXOONq0Q5PVLV+o6bQyxVAO46v9oJNeqymgCTloAT/1rSzrAkKPHdqHlfq9MMCEpSB
	CQ1UQMyP17c8eZP9ENWvI2AdJx/cEjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNIy-0003Ef-20; Wed, 06 Feb 2019 13:31:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNIk-000346-Kx
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 13:31:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98CF8EBD;
 Wed,  6 Feb 2019 05:31:38 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CC003F557;
 Wed,  6 Feb 2019 05:31:37 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/6] Initial support for CVADP
Date: Wed,  6 Feb 2019 13:31:02 +0000
Message-Id: <1549459868-45992-1-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_053142_695548_B34B76AF 
X-CRM114-Status: GOOD (  11.72  )
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
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ARMv8.5 introduces a DC CVADP instruction which cleans the data cache to
the point of deep persistence. This series makes the instruction
available to userspace and advertises the presence of this CPU feature.

At present when CONFIG_ARM64_PMEM is enabled and the CVAP feature is
present (ARMv8.2) the CVAP instruction is used (from memcpy_flushcache
and arch_wb_cache_pmem). No changes have been made to use CVADP in
these functions or similar.

As we have moved beyond 32 capabilities we now begin using ELF_HWCAP2
for userspace.

Tested as follows:

# dmesg | grep "Deep"
[    0.166496] CPU features: detected: Data cache clean to Point of Deep Persistence

# LD_SHOW_AUXV=1 sleep 2>&1 | grep AT_HWCAP
AT_HWCAP:        ef91ff87
AT_HWCAP2:       0x1

Andrew Murray (6):
  arm64: Handle trapped DC CVADP
  arm64: HWCAP: add support for ELF_HWCAP2
  arm64: HWCAP: encapsulate elf_hwcap
  arm64: Expose DC CVADP to userspace
  arm64: add CVADP support to the cache maintenance helper
  arm64: Advertise ARM64_HAS_DCPODP cpu feature

 Documentation/arm64/elf_hwcaps.txt       |   4 ++
 arch/arm64/crypto/aes-ce-ccm-glue.c      |   2 +-
 arch/arm64/crypto/aes-neonbs-glue.c      |   2 +-
 arch/arm64/crypto/chacha-neon-glue.c     |   2 +-
 arch/arm64/crypto/crct10dif-ce-glue.c    |   2 +-
 arch/arm64/crypto/ghash-ce-glue.c        |   6 +-
 arch/arm64/crypto/nhpoly1305-neon-glue.c |   2 +-
 arch/arm64/crypto/sha256-glue.c          |   4 +-
 arch/arm64/include/asm/assembler.h       |   4 ++
 arch/arm64/include/asm/cpucaps.h         |   3 +-
 arch/arm64/include/asm/cpufeature.h      |  13 ++--
 arch/arm64/include/asm/esr.h             |   3 +-
 arch/arm64/include/asm/hwcap.h           |  42 +++++++++++-
 arch/arm64/include/uapi/asm/hwcap.h      |   7 +-
 arch/arm64/kernel/cpufeature.c           | 106 +++++++++++++++++++++----------
 arch/arm64/kernel/cpuinfo.c              |   3 +-
 arch/arm64/kernel/fpsimd.c               |   4 +-
 arch/arm64/kernel/traps.c                |   3 +
 drivers/clocksource/arm_arch_timer.c     |   8 +++
 19 files changed, 160 insertions(+), 60 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
