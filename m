Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1600DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:15:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F5F2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NUdWlUjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F5F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e3lDy18O1zsB63qoDV3ri+iQJ04JAM/4GGDUEgN0DMw=; b=NUdWlUjUOj6p/h
	43G8+4UHnIQWiacDNPUxumNBshl8445aNQoxkWeCiVAWHdjHi8tEEJ9x7L26ciD6VGcj9IKKCYoMb
	r4Eso84RpaaQudHen7xqMlOUgGYsBOeIPrUjudChtK2595qmLY9AfXZEryxtue3p9kONiDV7FBI5z
	rYZ2MHYskPaEhkZi0L6+DmiIf6NaU72Ho5VXjATobYQdiTysloNQTUNNOZ4njRSuOiQmCv9RmGVhE
	cG9fRTK7L+Eh0LVoa25uXla+0IBQho0Buzve2j+Dsm1DTzQzXXa8WhLQL598nUYTEhdu/8VqQGZdx
	5Jp9DyEb8sZNMnXIpB6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwq4N-0000Es-WF; Thu, 21 Feb 2019 15:15:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwq4K-0000Dq-5z
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:15:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D944CA78;
 Thu, 21 Feb 2019 07:15:20 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7BFC3F5C1;
 Thu, 21 Feb 2019 07:15:19 -0800 (PST)
Date: Thu, 21 Feb 2019 15:15:17 +0000
From: Will Deacon <will.deacon@arm.com>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] arm64: late fixes for 5.0
Message-ID: <20190221151517.GB13320@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_071524_223170_4CDECBA3 
X-CRM114-Status: GOOD (  13.52  )
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

Please pull these three small arm64 fixes for 5.0. They fix a build breakage
with clang introduced in 4.20, an oversight in our sigframe restoration
relating to the SSBS bit and a boot fix for systems with newer revisions of
our interrupt controller.

Summary in the tag.

Cheers,

Will

-->8

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 74698f6971f25d045301139413578865fc2bd8f9:

  arm64: Relax GIC version check during early boot (2019-02-20 14:05:37 +0000)

----------------------------------------------------------------
arm64 fixes for 5.0

- Fix handling of PSTATE.SSBS bit in sigreturn()

- Fix version checking of the GIC during early boot

- Fix clang builds failing due to use of NEON in the crypto code

----------------------------------------------------------------
Mark Rutland (1):
      arm64: fix SSBS sanitization

Nathan Chancellor (1):
      arm64/neon: Disable -Wincompatible-pointer-types when building with Clang

Vladimir Murzin (1):
      arm64: Relax GIC version check during early boot

 arch/arm64/include/asm/neon-intrinsics.h |  4 ++++
 arch/arm64/kernel/head.S                 |  3 +--
 arch/arm64/kernel/ptrace.c               | 15 ++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
