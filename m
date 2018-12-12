Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8985EC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:14:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562692086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dYI8HCJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562692086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=s9W9G8ZBfw2LADDTxVAyX9NpGNmY/n5VId1YWQNiQgY=; b=dYI8HCJctbKhvP
	Vvs64lY31Rf7iBcqopq1HSg+RoaLozuhYMaRToqE8e1IhtgwUBXLH/Pape7P3LjTZ/yyadkeMfqr+
	gXNUC1IC3+VL4AG3UhXJFNaAwuV4r+VDLsVDnSUDEvijqs9xKJeKFjmZsj55SCXmqLPM7ap4F7GU7
	unr7UMS2D/r5mnqeLuxWEE+lkJtSxwX+tzNtxp27zQSIaXwNoZFBkCmHPgzi8gDTN/O41L25RKs2O
	xSF7U/x2WaUEes2WxD8PtJ+Ji9ik8QuI/5wjE3pjiShLf9MH7irjKwZMB4OsQCAfzedOu/aT9G5TE
	/4kwewX6IQSJe3DhV9lQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX924-0001xQ-DK; Wed, 12 Dec 2018 18:14:52 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX921-0001wo-JT
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 18:14:50 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 066A7809F;
 Wed, 12 Dec 2018 18:14:42 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL] few omap driver fixes for v4.21
Date: Wed, 12 Dec 2018 10:14:33 -0800
Message-Id: <pull-1544638438-182658@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_101449_679324_65DDCF41 
X-CRM114-Status: UNSURE (   8.25  )
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

The following changes since commit 3be5e10daf1fc063ec5cff3cd785c4a59814af0b:

  Merge branch 'omap-for-v4.21/ti-sysc' into omap-for-v4.21/driver (2018-11-29 11:39:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/driver-part2-signed

for you to fetch changes up to c2ade654dbf7d02f09ad491f5621fc321d4af96b:

  memory: omap-gpmc: Use of_node_name_eq for node name comparisons (2018-12-11 08:30:29 -0800)

----------------------------------------------------------------
Few more omap driver fixes and improvments for v4.21 merge window

This series of changes improves the TI module flag handling to allow
booting with older dts files until the module flags have been moved
to the interconnect target module level. And there's a of_node_name_eq()
clean-up patch from Rob Herring for the GPMC driver.

----------------------------------------------------------------
Rob Herring (1):
      memory: omap-gpmc: Use of_node_name_eq for node name comparisons

Tony Lindgren (3):
      ARM: OMAP2+: Check also the first dts child for hwmod flags
      bus: ti-sysc: Check for no-reset and no-idle flags at the child level
      Merge branch 'omap-for-v4.21/ti-sysc' into omap-for-v4.21/driver

 arch/arm/mach-omap2/omap_hwmod.c | 23 +++++++++++++++++------
 drivers/bus/ti-sysc.c            | 32 +++++++++++++++++++++++++-------
 drivers/memory/omap-gpmc.c       |  8 ++++----
 3 files changed, 46 insertions(+), 17 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
