Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E6CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:24:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AABC2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u8Sz1YTI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Pb/VTSN0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Pb/VTSN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AABC2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=99p/SsYG1ouQDH8dhjrP/kY2eFPlOajmqwVZ3dEC1Vk=; b=u8Sz1YTIXo1MZ3g10Y2pHG7NeZ
	kGLYFsoPZB15urAA1Ec9VrSM8jOM/XOp85bZ7p2zbnF4L1fxVsrE4QlNKLkNWIN3Era9flz8mmDFq
	zFN6gc/ZWaG+Rb62i0CIZKsl61VqV4I7Ros5xc4B6pNAsOZJSVgPGlRlIkb4WBBk+h9Z2N8pBtdWc
	w+3D6o4J7rOQBrmBiYUUdZVH+elTCvYfo9IUnjeyn4UqEpOW/gi1Eb2Lku54gW4LV3rYaV5gCdUb+
	ZMxYQGSGTyr6DYM64fPr2i7id3XK3ykZ720B9UPSN/lG0mVq+CDFy0x5pJvON/9y3fkM+RjB8uLRl
	xGcHBPRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKOP-0000vC-1I; Wed, 23 Jan 2019 15:24:41 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKNW-00005S-GV
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:23:48 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id D43704E2050;
 Wed, 23 Jan 2019 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548257023; bh=AKnivERQKU1x5vC9EhfVn3Srj4A6L5LICNTbEtiPN3E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Pb/VTSN0XG7T+AI9uVwwUXY9xX0hE8KEkmVCIvjJjkvNjZTf3IqeRKJE7+p8TGyKN
 tNYSmm+gKrADuyRgiPLBgRdBIpU6L7f+BqPZsa7rZhR+KkYlVaCEfgbwXUwIZmfZHV
 0tVSFQkST+UbRM8uFWgmwe0tfRSHbKf8f/yNMlkQ=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L1lW991LxVdu; Wed, 23 Jan 2019 15:23:43 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id B610D4E204B;
 Wed, 23 Jan 2019 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548257023; bh=AKnivERQKU1x5vC9EhfVn3Srj4A6L5LICNTbEtiPN3E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Pb/VTSN0XG7T+AI9uVwwUXY9xX0hE8KEkmVCIvjJjkvNjZTf3IqeRKJE7+p8TGyKN
 tNYSmm+gKrADuyRgiPLBgRdBIpU6L7f+BqPZsa7rZhR+KkYlVaCEfgbwXUwIZmfZHV
 0tVSFQkST+UbRM8uFWgmwe0tfRSHbKf8f/yNMlkQ=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH v3 0/5] dma: imx-sdma: add the sdma engine to the imx8mq
Date: Wed, 23 Jan 2019 08:23:05 -0700
Message-Id: <20190123152310.11680-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120023150.17138-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_072346_610569_8AE6AB2C 
X-CRM114-Status: UNSURE (   6.57  )
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

Changes since V2

Dropped device tree bindings and added clock ratio check.
Fixed bug where incorrect sdma device was selected.
Added new compatible string for "fsl,imx8mq-sdma"

Changes since V1

Fixed to build against v5.0-rc2

Angus Ainslie (Purism) (5):
  dma: imx-sdma: add clock ratio 1:1 check
  dma: imx-sdma: add imx8mq sdma compatible parts
  dt-bindings: dma: fsl-imx-sdma: add imx8mq compatible string
  dma: imx-sdma: add an index for imx8mq multi sdma devices
  imx8mq.dtsi: add the sdma nodes

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 31 +++++++++++++
 drivers/dma/imx-sdma.c                        | 45 +++++++++++++++++--
 include/linux/platform_data/dma-imx.h         |  1 +
 4 files changed, 74 insertions(+), 4 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
