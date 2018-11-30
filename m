Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0FCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:55:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AC120834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gIanVddO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AC120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nodInZ1GR1ic/3QLZ0qj9UBjpXFTrGyIVOJ6fwyyWMY=; b=gIanVddOnr1//i
	Dr7Xm39TFak82tdqGmPsx7xQ5i1bMHqHxW3ylI+KYo6n20erNt5lAAcyL8K4v4BFYNZdscS08kmZE
	Gk+5RNZY89a5d8IXQrr0e8GnUFH2E03M1o9L/3LnoLErHHpcytFfNC2gUUDR634mD5s4qInjCxkzi
	8ASs7wmFP6nNiF3qNFIOSXexsyHgCxM1ybVnPZKZy1mEBqublUEIbN54iBhDUVRexZo6TkpjeSEiV
	SqTsrf0hpCUGZ6FDbYzuG+p/OsOI/ElsbOM0+gIEhCAc0+POnVxVA+OQ2HdlrJE8QuDoZ7yvb7cf+
	JfScj0InXp5bNF0r917w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnwa-0006Lg-3Z; Fri, 30 Nov 2018 18:55:16 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnwW-00051f-OG
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:55:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E271C165C;
 Fri, 30 Nov 2018 10:55:00 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 D326D3F575; Fri, 30 Nov 2018 10:54:59 -0800 (PST)
Date: Fri, 30 Nov 2018 18:54:57 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] arm64 fixes for 4.20-rc5
Message-ID: <20181130185455.GA24239@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_105512_813695_373AF8F1 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to ea2412dc21cc790335d319181dddc43682aef164:

  ACPI/IORT: Fix iort_get_platform_device_domain() uninitialized pointer value (2018-11-30 17:28:39 +0000)

----------------------------------------------------------------
- Cortex-A76 erratum workaround

- ftrace fix to enable syscall events on arm64

- Fix uninitialised pointer in iort_get_platform_device_domain()

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Add workaround for Cortex-A76 erratum 1286807

Lorenzo Pieralisi (1):
      ACPI/IORT: Fix iort_get_platform_device_domain() uninitialized pointer value

Masami Hiramatsu (1):
      arm64: ftrace: Fix to enable syscall events on arm64

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 25 +++++++++++++++++++++++++
 arch/arm64/include/asm/ftrace.h        | 13 +++++++++++++
 arch/arm64/include/asm/tlbflush.h      |  4 ++--
 arch/arm64/kernel/cpu_errata.c         | 20 +++++++++++++++++---
 drivers/acpi/arm64/iort.c              |  2 +-
 6 files changed, 59 insertions(+), 6 deletions(-)

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
