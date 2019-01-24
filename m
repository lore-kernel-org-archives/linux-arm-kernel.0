Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81309C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:18:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361E5217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ORWBo2Mk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7NB915u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361E5217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oLIHPwGpVV5GNkc15uteMThStRTKNZpjurA7Enmt8UU=; b=ORWBo2MkfvZjd8
	pTKzZybrNd1Zp5ZWF9Lio8l0JwMrwCt+HHuXMFSQkrxpDN19YAV3OwNH+8GbZCHVxvstflaVdhYpx
	bsWvI8KoV09uP+DR76BR4+DO4Qo5ERBLTdMyPyGhBsMcRVL21tfw0laUxSK0/Y/O1oqVRODYyxJO9
	Y5w9XsmdW4BcHgGYjRwQSFE/6b6kx9I3ELZOCA3ygV9BYqPd6CbtWVpbQhqaeIpzLYyeQhpx04oqo
	eGUPRlCBBIyQU3uFu44p0HtVzfWWZ8MUmHegXXYi7cJ/zFJcehTVPi5gNAgMK7Uvg0Fanq31KC+BW
	IlAA2CGvll5NPQ3T+7gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlRu-0003NZ-AI; Thu, 24 Jan 2019 20:18:06 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlPe-0001Ff-Mh
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:15:57 +0000
Received: by mail-pl1-x641.google.com with SMTP id b5so3396468plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AHjS+evz3QVh0MBkELR/jdoUFNfkoRz6aszyBU+n3Ec=;
 b=a7NB915uX5EMB2WZFfUNQlqGBBzd52MUuqoxtUdJ4psueraTW/VTAOXeNDTSzjTTS7
 i4vQM/tYEnWhpoQAQFzpP+vsETX9CiS8ofTFeIjJqhHqP/j9LQ+6Tse1M1IDozc4Ki2O
 IUwZysbxauLPMQgaqZHiVtu4o68O0oH9A2JaaC5fzF6/7Sy1iFGq8NIMsijsZxqrN8cp
 f3nLHdQME3v/oYYo7Z4Se1j0QdDwmoP7h8UOO7KGDU8KzXt6ckxRid0jO4dbtiKP1K74
 6CXpO3tlsWjH2xKiTIgS8E6N8v7qmc3U8//fHjANP4hfSpwC20btW47/eiWsBB+vqimH
 3dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AHjS+evz3QVh0MBkELR/jdoUFNfkoRz6aszyBU+n3Ec=;
 b=WOtgYLYVs47ULxVoAtVWheUDZfEwVALAc8W/FtFT2F6SJMMemm9mL9c5MhhwVXJs77
 JTMKBE6m2uvfanKUnskoaHD7D6BikIrunxm+LLpDNyabYN6Rrz3WBH9q68Le3qQU6VXA
 ibV17MVOY2g7jucFXOavCJHH7d2a38OTSXxSrvTJunjLVbohkUCXCbSn0KkxgDrzOxzy
 ce44y6blzD9+FvXxzrrNp9IEPpNVfQ8Oi4Wyk31dKJCZZAiz8fEMnT8ppsL4BnIilhem
 jdGZHu+RyAtUEuOKfk46Y91IlIyo8IrwNrA6e9kr9TuRLfy6KfrFGdHNyaM1ff/581Kh
 8YlA==
X-Gm-Message-State: AJcUukchsgHBlkSlIN4G7H4d+FSQnUWSQJPr0rg3vz43GNwP68YZRVqx
 AcAiND+kflYKZz9z0WCvwo4=
X-Google-Smtp-Source: ALg8bN4z8wkfPm1/MV8LPDhriPtnOPHgVUtD2pkb5FEbosg2yEnFk+nMqeCUK8uwLUB9owhgfqQO/A==
X-Received: by 2002:a17:902:830a:: with SMTP id
 bd10mr7971769plb.321.1548360945884; 
 Thu, 24 Jan 2019 12:15:45 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id m65sm53062646pfg.180.2019.01.24.12.15.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 24 Jan 2019 12:15:45 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v6 3/4] PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to
 use a flag
Date: Thu, 24 Jan 2019 12:15:21 -0800
Message-Id: <20190124201522.8973-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124201522.8973-1-andrew.smirnov@gmail.com>
References: <20190124201522.8973-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_121547_220234_361F1C7F 
X-CRM114-Status: GOOD (  13.82  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Both i.MX7D and i.MX8MQ have the same behaviour when it comes to
clearing DIRECT_SPEED_CHANGE bit when no speed change occur. To
account for that change the code handling that to use a generic flag
instead of checking IP block variant.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c55d93c1187d..75ee0cd7af3b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -42,6 +42,7 @@ enum imx6_pcie_variants {
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
+#define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
@@ -711,7 +712,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		tmp |= PORT_LOGIC_SPEED_CHANGE;
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
-		if (imx6_pcie->drvdata->variant != IMX7D) {
+		if (imx6_pcie->drvdata->flags &
+		    IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE) {
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -1097,15 +1099,18 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
