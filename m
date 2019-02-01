Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B9CC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:51:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6339218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OgfVP0Jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6339218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vEtPxJ4oLepIsyPocEVIdpMqEmL+Beg0tqgYBk9cwUs=; b=OgfVP0JcAunnY+
	V9EgAOuG5EWWEtqAbp4Heq+SUf9VWD2GHZ9Kzcjcdsi+j2X8AVtvLDP80dmoiTLJi7NpZvlYIUlVN
	xA7zKsjc13S1yQI4BA9ei2kIdxyKkaiC4T5S4rh9yiE4CmOKElQu27ST/9EhmnCQ90CiupVMc/T2J
	ZAjZ0xJ1nyGeM/yeOLpEym/bdxt+o5EC9Lrql+aaUGhPxQYclUXl8qskbaQzNEjpCNrhlXxOTWOKz
	Uwt6mNhWKzJTqJKiOpxie6cA3hUwwk23/LPv0TF5jdrnBpCE/MKnPl5/TEkC8RcSFGcVG+LSuVxtw
	kAyztuSiUhUkhAqJvzyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpcyk-0006YP-AT; Fri, 01 Feb 2019 17:51:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpcyg-0006Xf-E8
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 17:51:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45FEB15BE;
 Fri,  1 Feb 2019 09:51:45 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58EED3F589;
 Fri,  1 Feb 2019 09:51:44 -0800 (PST)
Date: Fri, 1 Feb 2019 17:51:41 +0000
From: Will Deacon <will.deacon@arm.com>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] arm64: fixes for -rc5
Message-ID: <20190201175141.GB14567@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_095146_477516_57F3579A 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

Although we're still debugging a few minor arm64-specific issues in
mainline, I didn't want to hold this lot up in the meantime. We've got
an additional KASLR fix after the previous one wasn't quite complete, a
fix for a performance regression when mapping executable pages into
userspace and some fixes for kprobe blacklisting. All candidates for
stable and summarised in the tag.

Please pull. Thanks,

Will

--->8

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to f7daa9c8fd191724b9ab9580a7be55cd1a67d799:

  arm64: hibernate: Clean the __hyp_text to PoC after resume (2019-02-01 14:10:02 +0000)

----------------------------------------------------------------
arm64 fixes for -rc5

- Fix module loading when KASLR is configured but disabled at runtime

- Fix accidental IPI when mapping user executable pages

- Ensure hyp-stub and KVM world switch code cannot be kprobed

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: kaslr: ensure randomized quantities are clean also when kaslr is off

Catalin Marinas (1):
      arm64: Do not issue IPIs for user executable ptes

James Morse (3):
      arm64: kprobe: Always blacklist the KVM world-switch code
      arm64: hyp-stub: Forbid kprobing of the hyp-stub
      arm64: hibernate: Clean the __hyp_text to PoC after resume

 arch/arm64/kernel/hibernate.c      | 4 +++-
 arch/arm64/kernel/hyp-stub.S       | 2 ++
 arch/arm64/kernel/kaslr.c          | 1 +
 arch/arm64/kernel/probes/kprobes.c | 6 +++---
 arch/arm64/mm/flush.c              | 6 +++++-
 5 files changed, 14 insertions(+), 5 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
