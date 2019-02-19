Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB37FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:10:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CEC2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BKtA2UES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CEC2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=NbLxeFXQXdcceVcW9sK8snYtcIxUdmURaGabxnNQcFM=; b=BKt
	A2UESFu/a7BWvTqHx6Qr6gddNyVgROHLk5+eJXnEyxQ9+sGS96tA9XVZC56HaVa7AYFyBjepOvuqn
	1NeX6+imqcxPWr/Z5qqDWf0/FGBleeluG2QzGfHw3ElKSz+AklhOxGdnEG6bvTlzLeF1JDieZ77Q3
	CGRLPRtQki4GJL14/2evelaju2JJSchY2VxEzoax1ylWA6j3wvPMbCON/xVtMbFrKPJXF1vQQsv41
	11tqGqfEXiJkzcP6g6Br7Xsv0HSBK1+MbaJWIqmYd0F/a2IEbwdzQMXMftWPLdzJGIDwpSS1COV4h
	sLDeGHRzS5MxPVEFmCXphEQJWC0XT3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwCeN-0001Yd-F4; Tue, 19 Feb 2019 21:09:59 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwCeK-0001YF-Ol
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 21:09:58 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C46C1A0064;
 Tue, 19 Feb 2019 22:09:55 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C28ED1A011E;
 Tue, 19 Feb 2019 22:09:54 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net
 [10.81.33.49])
 by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id EB90340CAF;
 Tue, 19 Feb 2019 14:09:53 -0700 (MST)
From: Li Yang <leoyang.li@nxp.com>
To: arm@kernel.org
Subject: [GIT PULL] updates to soc/fsl drivers for v5.1 take3
Date: Tue, 19 Feb 2019 15:09:53 -0600
Message-Id: <20190219210953.1840-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_130956_940832_4DC7D60D 
X-CRM114-Status: UNSURE (   8.85  )
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
Cc: shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi arm-soc maintainers,

Please help to look into the following changes on top of previous
pull request and merge them if they look good.


The following changes since commit 3c0d64e867ed78a782a8a00d3b519396d9c5a2db:

  soc: fsl: guts: reuse machine name from device tree (2019-01-11 16:08:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.1-3

for you to fetch changes up to bd3bd3b36df725645036748e58a8c35c8d2cbf91:

  soc: fsl: dpio: fix memory leak of a struct qbman on error exit path (2019-02-19 14:59:39 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.1 take3

DPIO driver
- fixed a use after free problem
- fixed a memory leak on error path

----------------------------------------------------------------
Colin Ian King (1):
      soc: fsl: dpio: fix memory leak of a struct qbman on error exit path

Dan Carpenter (1):
      soc: fsl: dpio: Use after free in dpaa2_dpio_remove()

 drivers/soc/fsl/dpio/dpio-driver.c  | 2 +-
 drivers/soc/fsl/dpio/qbman-portal.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
