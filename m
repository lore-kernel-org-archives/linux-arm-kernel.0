Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E70FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:01:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F512089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r5g0OuoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F512089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UO2LzEcbneLeOlXI9YhxcWH+gBWxhpwFwmgH/kx8HLM=; b=r5g0OuoLkS+JZ3
	s5gvViW8I/fpMPmc8LxvD9LTPTSHkgOR4wRG9TVW9upGNjsZe2/0/bTJTmHSQeV1dsH0xLTSbb/Jc
	MeHoEXxQfj+EEltmgKi/xGW2m6+XzEYkv9lFMzuvY8ndOoloDqD+w1UhzhaDVqdpaeJrVnGPlPpw+
	nNAFLokMkkZeExDEBxp9/RBgkXi/U9sUZq5B/5SA+YmOciOzFC73VxHkmcdMFEhHcn/vBrBAQ50x6
	E/50F8x15trVdOdwTCZRchQL8jr2iYr+bTcDipLT+DrlDxvXrz5JiSQX8N55y/l5J1MM5CIOeob8C
	9IErbAQCi96X18+xxqew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLKW-0003fC-B3; Thu, 14 Feb 2019 18:01:48 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLKL-0003SK-H1
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 18:01:42 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 712C280EA;
 Thu, 14 Feb 2019 18:01:47 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL] Fix omap4 and later lost cpu1 interrupts for periodic timer
Date: Thu, 14 Feb 2019 10:01:34 -0800
Message-Id: <pull-1550167274-497763@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_100137_597448_FE0F8A77 
X-CRM114-Status: UNSURE (   7.43  )
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

The following changes since commit dc30e70391376ba3987aeb856ae6d9c0706534f1:

  ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized (2019-01-29 08:54:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.0/fixes-rc5

for you to fetch changes up to 50d6b3cf9403879911e06d69c7ef41e43f8f7b4b:

  ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug (2019-02-07 07:48:22 -0800)

----------------------------------------------------------------
Fix omap4 and later lost cpu1 interrupts for periodic timer

A fix from Russell that took a while to get applied into fixes as
I thought Russell is merging this one.

----------------------------------------------------------------
Russell King (1):
      ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug

 arch/arm/mach-omap2/cpuidle44xx.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
