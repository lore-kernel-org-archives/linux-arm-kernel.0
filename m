Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2161C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:55:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D93218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pqxcq+6C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="JMPgcNKe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="JMPgcNKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D93218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=iceXp+d6+9wcr/fZve2cG8oj3hclKYSc4KLO/K5/Ptk=; b=pqxcq+6CvPNk8jFoyvTu0iDFkX
	iv2cNuYWlGKMdTqqK75ZEo5hZExRomyjSOyy4mtozRk8lh5rfXntQiOKnIJEhijZNkVRh9B+h3BK4
	iJ7hw9sUEcW/uTpFkaz79SVhU8tgTkvcqhnwF3/wQCfdmZmKa2Nx4oeHmB+kuVYflB5cLc4Rxn2gA
	+z48jjUrghy9f9KpOdkniqicb9bOTgrTGpSo9LYkWxeLts+btVWLUvmnWjIVwhvn8+ozwseWzW46G
	rWdGohjjXrEiFbmQsrxViDlTkpyBMvS+z95QkFuFjnqP1STQ//vwGjxMdYtcnEKJJg6AZlK7X3MhI
	ZlUpZevQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmref-0005bS-Bo; Fri, 25 Jan 2019 02:55:41 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmrec-0005a1-C4
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 02:55:39 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id F26334E2050;
 Fri, 25 Jan 2019 02:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548384936; bh=+N1RUEpoazm9k2QN2Ak2Wu6dbxdXYtcOhffHThz+TYM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JMPgcNKeSzdjGxdAWk3v2oq3GVXU2MJYIlAQSJQwoUYwUBkMiciPoipn4V+9qApGn
 G3KZpMT/wg1IO8VMlrfB6hTmx51ZkxNMNyZSrwA2YU520LQzUzc+dMEAmCIpTcKUHN
 /ssZ6uZPR3YA8D271KPKZHLZewZM+KgyT8OIcp1A=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ybt7tzxl2MfH; Fri, 25 Jan 2019 02:55:36 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id C9C384E204B;
 Fri, 25 Jan 2019 02:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548384936; bh=+N1RUEpoazm9k2QN2Ak2Wu6dbxdXYtcOhffHThz+TYM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JMPgcNKeSzdjGxdAWk3v2oq3GVXU2MJYIlAQSJQwoUYwUBkMiciPoipn4V+9qApGn
 G3KZpMT/wg1IO8VMlrfB6hTmx51ZkxNMNyZSrwA2YU520LQzUzc+dMEAmCIpTcKUHN
 /ssZ6uZPR3YA8D271KPKZHLZewZM+KgyT8OIcp1A=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH v4 0/5] dmaengine: imx-sdma: add the sdma engine to the imx8mq
Date: Thu, 24 Jan 2019 19:55:23 -0700
Message-Id: <20190125025528.15645-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120023150.17138-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_185538_461393_07EED0D7 
X-CRM114-Status: UNSURE (   7.05  )
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
  dma: imx-sdma: add a test for imx8mq multi sdma devices
  imx8mq.dtsi: add the sdma nodes

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 28 +++++++++++++
 drivers/dma/imx-sdma.c                        | 39 +++++++++++++++++--
 include/linux/platform_data/dma-imx.h         |  1 +
 4 files changed, 65 insertions(+), 4 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
