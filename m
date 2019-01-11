Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DE9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:21:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737A3205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="imMuqNki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737A3205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8GuKm59AlUVRT91K405c2QEin4Pv993VTr7ZY0dAheQ=; b=imMuqNkixxxcC7
	cTLE7+GlQOMhb2HG9asNsmhPLMYu1r5KYShT5tQ9tkJb037v6itFh2iquOedO6SR3g19bJZBeY0lg
	3rh6hDE0/y2RTVRAxqc2rxeDd7UKNhvDpLkfh+KHeXfY/NhDyfmhomt4X2n2hd9ojAhPDf9gQIzud
	O0Cg2eSLkPmABA+JDFD8txewHu6ud0PSMo86lB8XsEyCkq8mivDwUPbOhkpNxodU51xCWD6turodr
	XS/vTan7XKSul4tbxA8JhUpVM6Y2InCy0zgL8J0ID4GK7YeRcF3nG7ZEURcyYP+Isrz2DvxaEgEpE
	lgR9vSwWA7EaS7S5yoxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi1QX-0003O6-2y; Fri, 11 Jan 2019 18:21:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi1QT-0003Nd-I8
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:21:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30FEF80D;
 Fri, 11 Jan 2019 10:21:01 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 217443F6CF;
 Fri, 11 Jan 2019 10:20:59 -0800 (PST)
Date: Fri, 11 Jan 2019 18:20:57 +0000
From: Will Deacon <will.deacon@arm.com>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] arm64: fixes for -rc2
Message-ID: <20190111182057.GB32645@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_102101_602378_C6A5B7EA 
X-CRM114-Status: GOOD (  13.68  )
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
Cc: catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

Another handful of arm64 fixes here. Most of the complication comes from
improving our kpti code to avoid lengthy pauses (30+ seconds) during boot
when we rewrite the page tables. There are also a couple of IORT fixes
that came in via Lorenzo. Usual summary in the tag.

Please pull,

Thanks,

Will

--->8

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 279667212ab2a4f36c3b0347657ddcc11f9cfa25:

  arm64: kexec_file: return successfully even if kaslr-seed doesn't exist (2019-01-11 10:10:51 +0000)

----------------------------------------------------------------
arm64 fixes for -rc2

- Don't error in kexec_file_load if kaslr-seed is missing in device-tree

- Fix incorrect argument type passed to iort_match_node_callback()

- Fix IORT build failure when CONFIG_IOMMU_API=n

- Fix kpti performance regression with new rodata default option

- Typo fix

----------------------------------------------------------------
AKASHI Takahiro (1):
      arm64: kexec_file: return successfully even if kaslr-seed doesn't exist

Jean-Philippe Brucker (1):
      ACPI/IORT: Fix rc_dma_get_range()

Qian Cai (1):
      ACPI/IORT: Fix build when CONFIG_IOMMU_API=n

Will Deacon (2):
      arm64: asm-prototypes: Fix fat-fingered typo in comment
      arm64: kpti: Avoid rewriting early page tables when KASLR is enabled

 arch/arm64/include/asm/asm-prototypes.h |  2 +-
 arch/arm64/include/asm/mmu.h            | 41 +++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-prot.h   |  4 ++--
 arch/arm64/kernel/cpu_errata.c          |  2 +-
 arch/arm64/kernel/cpufeature.c          |  9 ++++++--
 arch/arm64/kernel/head.S                |  1 +
 arch/arm64/kernel/machine_kexec_file.c  |  4 +++-
 drivers/acpi/arm64/iort.c               |  5 ++--
 8 files changed, 59 insertions(+), 9 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
