Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013DCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:13:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C862620836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DVcRvyLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C862620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BFupSRw/ryP+NOaoYi6YdXu0GgpQ7ncytk9v1W9u5hs=; b=DVcRvyLt++bQGg
	kX2OdvQL1wlNjVKi0uikGi1tMHhP/Aoi4fdFalKhGf73TzC7v9oRLpk9LsSAt2uCtAwmwlAcFVU3P
	43NGZ4bK3CAh85QePxBMi6QTEyWA6TZgufDJ0xKQz0I+ouuk9gKTPNA/mLjzttsBRH9jvnAOIynBE
	WJeHwmVXcngGfRBTFvwHg0NTVWVImpHMoV5vbFMjshA7M+DqlPG1mgh+lJ1LpIa0tu1qum5mt8/9m
	4ZCC9nbHMURItyT8VhVy5zAalxNuqQ9b7kBbk/vGwQi6mbOrfeg5eEvggcb7apcRsIcW0LJKyBV2R
	Yy97R5mia4EpLOA2DlCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLVd-0008Ju-QS; Thu, 14 Feb 2019 18:13:17 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLVa-0008JK-Pl
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 18:13:16 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 3BC4880EA;
 Thu, 14 Feb 2019 18:13:24 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL 1/2] defconfig changes for omaps for v5.1
Date: Thu, 14 Feb 2019 10:13:05 -0800
Message-Id: <pull-1550167958-188990@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_101314_877211_F1DD2A4E 
X-CRM114-Status: UNSURE (   7.84  )
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

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/defconfig-signed

for you to fetch changes up to a8220ae7e740f8c568bd79ba38b6a3efe13100c1:

  ARM: omap2plus_defconfig: Update for moved options (2019-01-31 10:54:06 -0800)

----------------------------------------------------------------
Defconfig changes for omaps

Drop PROVE_LOCKING as it should not be enabled in the defconfig. It
causes quite a bit overhead as noted in the patch description.

Then let's update omap2plus_defconfig for dropped options and moved
options. That way makesavedefconfig can actually be used to generate
patches against omap2plus_defconfig.

----------------------------------------------------------------
Lukasz Luba (1):
      ARM: omap2plus_defconfig: remove PROVE_LOCKING from defconfig

Tony Lindgren (2):
      ARM: omap2plus_defconfig: Update for dropped options
      ARM: omap2plus_defconfig: Update for moved options

 arch/arm/configs/omap2plus_defconfig | 83 +++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 45 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
