Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC5EC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:58:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98C521104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MrCMbiaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98C521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ArnGMcxWJ2TNNcQ9pVdv01tehRE1UzIS0PcUGiDRZ3E=; b=MrCMbiaVQ7vV88
	oL4CaaH4ZbhoDNBJe1560WJhwlZpZiJeP91mDBAEIF7i7AsuRCG4PSgHMnm1EkeGu5xQuWxpwdNLV
	onUmna1ppQTft6ioWrLEvwNOHYHUM9eL8MeU2X2eA6KXQeXGnJnhA+CbGUBOkuGE4ii1CpwgRFhd+
	hNrmPA9i/TTnvVx5mYa1nSL4J30vNEaUv/dpfbhQqlKd1I7qy4teQoQYR10cxpEP9bi+iKWY2c1NL
	bH5024d5z1Xg6X2tGPCfUsCeYRmKb1XnMwVj1YZM7Y1Kno4oxboebO+dHptqt8lKA7g8HFUc64Nbo
	oRnV2AVOAOQw/0VMvcXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSSRp-0003x9-W8; Thu, 29 Nov 2018 19:58:05 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSSRm-0003wM-Ip
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 19:58:04 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id DB49E8176;
 Thu, 29 Nov 2018 19:58:02 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL 3/4] dts changes for omaps for v4.21
Date: Thu, 29 Nov 2018 11:57:42 -0800
Message-Id: <pull-1543521343-338334@atomide.com-3>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <pull-1543521343-338334@atomide.com>
References: <pull-1543521343-338334@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_115802_655862_F200BB6A 
X-CRM114-Status: UNSURE (   9.07  )
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/dt-signed

for you to fetch changes up to 0ec47be539e323ef4919fd63ea2f4162bf74892e:

  ARM: dts: am437x-gp-evm: Add sleep state for beeper pins (2018-11-19 10:32:43 -0800)

----------------------------------------------------------------
Device tree changes for omaps for v4.21 merge window

These changes mostly configure pinctrl for am437x-gp-evm. There is
also non-critical fix for a comment for Clang, and we enable earlycon
for am3517-evm.

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: am3517-evm: Enable earlycon stdout path

Dave Gerlach (5):
      ARM: dts: am437x-gp-evm: Add state for ddr3 vtt toggle pin
      ARM: dts: am437x-gp-evm: Add pinctrl for unused_pins
      ARM: dts: am437x-gp-evm: Add pinctrl for debugss pins
      ARM: dts: am437x-gp-evm: Add uart0 pinctrl default and sleep states
      ARM: dts: am437x-gp-evm: Add pinmux for gpio0 wake

Keerthy (1):
      ARM: dts: am437x-gp-evm: Add sleep state for beeper pins

Nathan Chancellor (1):
      ARM: dts: omap3-gta04: Fix comment block

 arch/arm/boot/dts/am3517-evm.dts    |   4 ++
 arch/arm/boot/dts/am437x-gp-evm.dts | 127 +++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/omap3-gta04.dtsi  |   2 +-
 3 files changed, 122 insertions(+), 11 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
