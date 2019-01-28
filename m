Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C4C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:08:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D052148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H9YhSREj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="wz9K7qR+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="wz9K7qR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D052148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0NiGowRRdA9xcdx5vE0222vT4uMkpKy8dVCTBWNzgVM=; b=H9YhSREjqUZ4e42UG/IOKIzQW5
	GnmtTqV02zDAunFVJcGJU3s3xouxorti0QdJfIw2t+VAd47Xhz6of0bnW04ptctMyWQdhCpKC7Ctt
	SvcIhnlkfcL0s7NVsOxINgVXj5W69JcNAIRiGNwYFJU+eRQ15Hod+EPkk2trsJK6pPV/JpzByIJDh
	HakjsLRLlpcvO5r2bwP02imib/4amjiyBMv7YKAI4x7vqF/lqeXiBc6mQmPUs20+vgLo/gfoYzJRL
	L4o5a9D7jJwNqyMh0CIsNK7cmb8wIpWJQ9lnSiOVSrpKxIBQv1neJGMoOiDcIfYS4TTeTb9IPntGI
	53/dG0VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go06H-0002Bc-TX; Mon, 28 Jan 2019 06:08:53 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go06E-00029s-21
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 06:08:51 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id AC8324E2050;
 Mon, 28 Jan 2019 06:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548655728; bh=m/0KSjSZb3yLWcTUdFGpt7bIw5sNECnqq18GM4Q9qRM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wz9K7qR+fWUI4BqktUQSpxdvH8w5Ig1Cr0sk8cWhfx6r0PInWGQBqfxRi/8xc+qjC
 RdtEDmddCP3osmX9nL9e7+ySN3tbrjJwQv9nYPY8gYqxnbuC4KrtURYMs3kDgup4xd
 r2hjQgL3WlrbT8PXZONzB1rSIsPdm/r8SrsA165o=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZRdwEI2rSNAm; Mon, 28 Jan 2019 06:08:48 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id A549D4E204B;
 Mon, 28 Jan 2019 06:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548655728; bh=m/0KSjSZb3yLWcTUdFGpt7bIw5sNECnqq18GM4Q9qRM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wz9K7qR+fWUI4BqktUQSpxdvH8w5Ig1Cr0sk8cWhfx6r0PInWGQBqfxRi/8xc+qjC
 RdtEDmddCP3osmX9nL9e7+ySN3tbrjJwQv9nYPY8gYqxnbuC4KrtURYMs3kDgup4xd
 r2hjQgL3WlrbT8PXZONzB1rSIsPdm/r8SrsA165o=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH v5 0/5] dmaengine: imx-sdma: add the sdma engine to the imx8mq
Date: Sun, 27 Jan 2019 23:08:35 -0700
Message-Id: <20190128060840.31695-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120023150.17138-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_220850_160505_C5AF4CAF 
X-CRM114-Status: UNSURE (   7.29  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add sdma support for the imx8mq

Changes since V4

Builds against 5.0-rc4.
Dropped device tree additions, will send a separate patch.
Fixed sdma1 alignement.
Dropped phandles in favour of of_nodes.
Refactored SDMA_H_CONFIG register fix.

Changes since V3

Builds against 5.0-rc3.
Dropped sdma device index matching in favour of phandles.
Corrected subsytem name to dmaengine
Devicetree fixes.
Fixed SDMA_H_CONFIG register bug.

Changes since V2

Dropped device tree bindings and added clock ratio check.
Fixed bug where incorrect sdma device was selected.
Added new compatible string for "fsl,imx8mq-sdma"

Changes since V1

Fixed to build against v5.0-rc2

Angus Ainslie (Purism) (5):
  dmaengine: imx-sdma: add clock ratio 1:1 check
  dmaengine: imx-sdma: add imx8mq sdma compatible parts
  dt-bindings: dma: fsl-imx-sdma: add fsl,imx8mq to the accepted
    compatible node
  dmaengine: imx-sdma: add a test for imx8mq multi sdma devices
  dmaengine: imx-sdma: fix consistent dma test failures

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 drivers/dma/imx-sdma.c                        | 29 ++++++++++++++++---
 include/linux/platform_data/dma-imx.h         |  1 +
 3 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
