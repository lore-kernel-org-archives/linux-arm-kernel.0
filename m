Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:24:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3032820B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AI1Lp1bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3032820B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=15NJ2IxkwdpXM+6Zajtz7Ya+0cVTL2z2vHzb+0SExUg=; b=AI1Lp1bn0gCbO8
	8u2UVcNrtvlCv9Hx74UlqbhEgOwX+AA55f34FqwCcbMaR0Imco7xe4asSjwrFqMlTVwoKH4TkWASH
	/Z57ZmRl4KxNcT9uhfovzKwYWU2nWNaCdlsfqhuK5yRMpfm6YkKLv61hLBzCU6FqBN6+ABkAHzrd+
	2FHYJHczBfr990L/vQYpJoaO9XfLL9swAs0k6NPQ9jyFWOA384n8Y/Reu4FkS2giZsE2h5jKitGh0
	eMnFdfyHmUqn9OuLIoywFJzqNUCTkkZvMfsMnmV06yVFHhX4eb9r+YxgTWhtzgG/gQ/kRiVfOb1rL
	oa1z4RqC7Nn0YsDiZJ0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF8w-00038k-Bf; Thu, 31 Jan 2019 16:24:46 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF8H-00030A-5R
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:24:06 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 7FF76809F;
 Thu, 31 Jan 2019 16:24:13 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL 1/3] soc changes for ti81xx for v5.1
Date: Thu, 31 Jan 2019 08:23:54 -0800
Message-Id: <pull-1548951676-587288@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_082405_239484_A30FB05F 
X-CRM114-Status: UNSURE (   7.45  )
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/soc-ti-81xx-signed

for you to fetch changes up to d27cda291b2341d39692421b4e64940879ff9dd8:

  ARM: ti81xx: Add hwmod boilerplate for all GPIO and SPI peripherals (2019-01-24 08:43:38 -0800)

----------------------------------------------------------------
SoC updates for ti81xx for v5.1 merge window

Two changes to add legacy hwmod data for gpio and spi peripherals on
ti81xx. We have not yet updated ti81xx to probe devices with ti-sysc
interconnect target module driver, so these changes are still needed
to make devices usable for the related device tree changes.

----------------------------------------------------------------
Graeme Smecher (2):
      ARM: ti81xx: Move I2C entries in omap_hwmod_81xx to maintain grouping
      ARM: ti81xx: Add hwmod boilerplate for all GPIO and SPI peripherals

 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 131 +++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 7 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
