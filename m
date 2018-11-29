Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30DAC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:59:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99DB21104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rje8jVsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99DB21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZnXJE89odLkW/Dp1Wz06YEVDf+pXtuJmdS3yBiX4XgM=; b=Rje8jVsTexea5Q
	UNq4Fp3kCJar1KpieickjSx1Qlg8MYZiSR3cPg2xGnQgEkbIciohs607TxW/qih5dDKx7tOPfw7aZ
	Rd18VWqhPfL2MpgB+AEszY6d1FfNXc24oyqQ/eKA4MXWAaZWm1cCJH1JgFVGsRG9HCj5QTSeLSfUp
	keQdDd+nWouvDjjnnXMXaPvpLSUdKnaA+27tfFvJCoLYISxAYvOKMslhOTuF7JOc3W1Q8ckfAOLcV
	hFkV+NOJ5OLYj1JvGyg7SiJNXGGImXXrT/NlKRXw8Vf/rTuqQskME+W0xTf5HW1Sraa9JX457y38Y
	aJ1Mu5NBPakG4lFdNhCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSSSl-0004hi-Sp; Thu, 29 Nov 2018 19:59:03 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSSRm-0003w8-Iq
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 19:58:05 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 04C0080EA;
 Thu, 29 Nov 2018 19:57:53 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL 1/4] soc changes for omaps for v4.21
Date: Thu, 29 Nov 2018 11:57:40 -0800
Message-Id: <pull-1543521343-338334@atomide.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_115802_660422_EFB4FD35 
X-CRM114-Status: UNSURE (   8.70  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/soc-signed

for you to fetch changes up to b76455335447fa8b73ebc0ca768e46ee74fcd329:

  ARM: OMAP2+: timer: Remove obsolete inclusion of <asm/smp_twd.h> (2018-11-19 10:06:36 -0800)

----------------------------------------------------------------
SoC changes for omaps for v4.21 merge window

Few more non-critical section annotation fixes for Clang and
remove obsolete timer header inclusion.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: OMAP2+: timer: Remove obsolete inclusion of <asm/smp_twd.h>

Nathan Chancellor (2):
      ARM: OMAP2+: hwmod: Fix some section annotations
      ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

 arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
 arch/arm/mach-omap2/prm44xx.c    | 2 +-
 arch/arm/mach-omap2/timer.c      | 1 -
 3 files changed, 4 insertions(+), 5 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
