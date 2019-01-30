Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19391C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:19:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D551520989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k5KbznEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D551520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HAXULBCmQB4Wl5oWfRdT8KdxF1Ju/PzhDE0jXNUba00=; b=k5KbznELQkdW0b
	Uiy5+lFT8wr7LWf+H2vQpMGirUOmPoe/BbkPjCt6cRr+TO0w9v3kQWTGtrT6VSmtAGfD0Dqt8w9qh
	QUgc0apTB934t8VNZzy+dOUt7b+aYbvOmo2Ucp1AgbZR0B5jJSYYdPz2KfX3jTBaTurtf3/jSefcA
	6a0N9VywWKoIxDU4c6KLVTGxkG4MeQbP0B/bmKFR5qtvsxh/1BVf6IX9HqLKQAmsJCAQZ4pjwyOtX
	MhEwIvxawd0gk5YkJRBDbIJoxYPVnN7Zah5gLg5RgRMO6mKm+QpRiqklL8Bl8KaKtX3lxxrogM/1Y
	66G4k5eZmpkDLvUEK1Dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosaY-00023l-IF; Wed, 30 Jan 2019 16:19:46 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gosZe-0001IB-HN
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:18:54 +0000
Received: from sapphire.lan (unknown [10.0.4.3])
 by mx.tkos.co.il (Postfix) with ESMTP id 8DCBB4403CA;
 Wed, 30 Jan 2019 18:18:43 +0200 (IST)
From: Baruch Siach <baruch@tkos.co.il>
To: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 0/4] ARM: dts: hummingboard2: fixes and improvements
Date: Wed, 30 Jan 2019 18:18:37 +0200
Message-Id: <cover.1548861664.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_081850_794346_8384652E 
X-CRM114-Status: UNSURE (   6.74  )
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
Cc: Baruch Siach <baruch@tkos.co.il>, Jon Nettleton <jon@solid-run.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The first two patches fix UART on the optional mikroBUS header.

The last two patches add optional CAN and RS485 peripherals. I sent these 
patches before, but they were not applied at the time:

  https://patchwork.kernel.org/patch/10528011/
  https://patchwork.kernel.org/patch/10528013/

Both patches are rebased here on top of the UART fixes.

Baruch Siach (4):
  ARM: dts: hummingboard2: fix uart3 Rx pin conf
  ARM: dts: hummingboard2: add uart3 pinmux for board rev 1.4
  ARM: dts: hummingboard2: describe optional rs485
  ARM: dts: hummingboard2: describe optional can bus

 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 42 +++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
