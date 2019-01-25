Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A534DC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:56:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795C5217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mO4WyLF4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="qdFIlRMW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="aM4wCKqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795C5217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=g07bZbPo0inIPB1PH0horFWdYM6GXzigBt2NxwE49zc=; b=mO4WyLF40BYZL/XbXkDB6/UM2q
	11KHVEGMJ/rNxnLnS2lvYojNnkl9maS+05ap36lzKqLa0NUxYA6HwWKeXG6OYEPFg5EjLrdIvuDlt
	xV9viJtvDKh+K9nxd6xd6F/Fycp6STFOGqHgGb5ZQk/NqYn0RgpRMKAAHLUMFAhV9ojEpWWm0lqZM
	vxg0Ms4exWMWGwQgruLDnqsSUXL9ereeG/TqTZ/whpiyyM0r5kTQIreooGUd47aFBnf1pU9nucHJW
	7OtnWF6YxMyIr8hGGsqd31E7PjULojNqs2s8NOcFzepDVt50Q4XS2ovw8KSTdK+DEb4wCM89eNibQ
	vsSxQ2tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmreu-0005pW-6M; Fri, 25 Jan 2019 02:55:56 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmrec-0005a3-GQ
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 02:55:39 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id 370A74E2056;
 Fri, 25 Jan 2019 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548384938; bh=EtaCZgEa0SNQFQDgpxE1KPj6YO295TP++Zo3L+XFaTs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qdFIlRMW1W+KCgkaHSCBQ6PE6fBD4Z06/f/u/aq4SJGGkr2cP3lOynXV21trgiqBd
 cPiZC07yGvKf0ORIZWyy9ctA9qTTzwM5Ew0fklzLzzZolX4TlT2DUJDG8ONfEHtqTT
 H87BcPUsZwevAok3X5W+5Tzwbn2WdvLxgxWf0D78=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yvU4zLEy14rj; Fri, 25 Jan 2019 02:55:37 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id 4E4FD4E204B;
 Fri, 25 Jan 2019 02:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1548384937; bh=EtaCZgEa0SNQFQDgpxE1KPj6YO295TP++Zo3L+XFaTs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aM4wCKqkCR6LGo/bXqkAy3mMCmyFbiBGGQ2Y5HnFd4ZWetQdBM4sHcHRSo+0qhNmQ
 I55ROY1ZVhOFEUda/aW0fqME2WbZwSS6A6EJ7e6yVrI+PAcuaiHjO8U/5a1/LdoBE7
 bLd2ZWJKW4c5ZD1tdY+E5V+UDf5jivXxKTJ7CXUc=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: angus@akkea.ca
Subject: [PATCH v4 2/5] dmaengine: imx-sdma: add imx8mq sdma compatible parts
Date: Thu, 24 Jan 2019 19:55:25 -0700
Message-Id: <20190125025528.15645-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125025528.15645-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_185538_558679_692244D4 
X-CRM114-Status: GOOD (  10.22  )
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

This is identical to the imx7d data structures but we need to
be able to differentiate that the imx8mq has 2 sdma controllers.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 5e5ef0b5a973..ec6fb48f387a 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -556,6 +556,12 @@ static struct sdma_driver_data sdma_imx7d = {
 	.script_addrs = &sdma_script_imx7d,
 };
 
+static struct sdma_driver_data sdma_imx8mq = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx7d,
+};
+
 static const struct platform_device_id sdma_devtypes[] = {
 	{
 		.name = "imx25-sdma",
@@ -578,6 +584,9 @@ static const struct platform_device_id sdma_devtypes[] = {
 	}, {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
+	}, {
+		.name = "imx8mq-sdma",
+		.driver_data = (unsigned long)&sdma_imx8mq,
 	}, {
 		/* sentinel */
 	}
@@ -592,6 +601,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
