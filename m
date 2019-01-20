Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A716CC61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:59:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD042084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ssgxqKuU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="KJUMMEdg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="KJUMMEdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD042084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=cjsP+4BwIIs6kan6cx4yg0CeIvhSNAExTfplPReWTvs=; b=ssg
	xqKuUKWe5iSKBdJoL+7uvvBvTTTMW4W2HZwo4iGj/cQYu3CL4t6yhmldj04sSInRQjG5V9uPaZ5js
	I/zhzgyeRY/wsGtTmYfmgDHq5wJtxPWy//D0PwBSyqA5H9ZhIpx/qsEbWsrH/phryGtIINmwkDbme
	A87g8aibcdb+cBFPze13XLA38pzXwCfIW/rmmP17bfIKA6ZBhWEu/D2zsa8Q8xYx2j9GbZJKLcCiY
	safBo7Q7+tyQd57VXJebf3W1W7T33eM0ZtTsBlNlkSZ46c34RRJbFp7WBSBWBSDztEXfNpHqwAjBf
	wiGopx0v2s2xLHPCVSXMwZ3SLxNUeBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl2OE-0007Xx-Hy; Sun, 20 Jan 2019 01:59:10 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl2OA-0007Wt-UF
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 01:59:08 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id DD3E84E2050;
 Sun, 20 Jan 2019 01:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547949541; bh=HJuftiU5le4edcxzQV0GJpsj/PoXHvCf7NygW9HXERg=;
 h=From:To:Cc:Subject:Date;
 b=KJUMMEdgwuIIF5hLVNvwU31Av/Y3mLcsrpm5RVNZT2/QU2/vfg6WpXxiQkz9zpYr8
 1ldVakmNsquzKB8KtMRuTlP4iCzed2BnNCAMLSyp+ROz2jlh3YTLERSpbXcZTNC2w+
 mhVzE5Y/uF0h/yHgk1C7S4LfxqPm9nxZzqtugbXM=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1n8EOdg9YL7m; Sun, 20 Jan 2019 01:59:01 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id EC43C4E204B;
 Sun, 20 Jan 2019 01:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547949541; bh=HJuftiU5le4edcxzQV0GJpsj/PoXHvCf7NygW9HXERg=;
 h=From:To:Cc:Subject:Date;
 b=KJUMMEdgwuIIF5hLVNvwU31Av/Y3mLcsrpm5RVNZT2/QU2/vfg6WpXxiQkz9zpYr8
 1ldVakmNsquzKB8KtMRuTlP4iCzed2BnNCAMLSyp+ROz2jlh3YTLERSpbXcZTNC2w+
 mhVzE5Y/uF0h/yHgk1C7S4LfxqPm9nxZzqtugbXM=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH 0/3] dma: imx-sdma: add the sdma engine to the imx8mq
Date: Sat, 19 Jan 2019 18:58:48 -0700
Message-Id: <20190120015851.11797-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_175907_027021_5AA7729F 
X-CRM114-Status: UNSURE (   6.40  )
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
Cc: linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add sdma support for the imx8mq

Angus Ainslie (Purism) (3):
  dma: imx-sdma: fix NULL pointer de-reference
  dma: imx-sdma: add clock ratio 1:1 check
  imx8mq.dtsi: add the sdma nodes

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 31 ++++++++++++++++
 drivers/dma/imx-sdma.c                        | 37 +++++++++++++------
 3 files changed, 57 insertions(+), 13 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
