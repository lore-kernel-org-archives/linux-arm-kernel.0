Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1E0C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:16:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D0C20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f0knP34i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgeDSQ4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D0C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dxhV04GFco3Y/ComB+V13t+mXCcFwy4GMab/Wd2alkM=; b=f0knP34iQ+F0lC
	gz3zwSfU/bC7aM8dYpUNeuDjLu7ae5rT5pWd4jTzqIeGf1wch9GfAix/qNlym9Ms0+cANjR/1552H
	WiMGpl/X8TmKaEQRtYOzmWJm2W2fo/fAKSKMj6QTLmKtPIMljCqJDkLcjIzBjZPGbUbGkA+FVFx4L
	mx4ReBz0YQyp7D+vPI09Kq9OAdv6Vz0CNZl/aqAi+Xc8f5/fKk2FMwo06eeuunh+rb/budejSL70Y
	R7GzTEJKm6rp2I8RVCbYv1MNGSDca+ht+tykaoGdDo1jsdGNYci+pYZH/3JHgZvaP8ttVIyu5iSIO
	LEZxlftdx3+eXQtACbUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpiyg-000218-5n; Sat, 02 Feb 2019 00:16:10 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpiyA-0001Te-Kt
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 00:15:40 +0000
Received: by mail-pg1-x542.google.com with SMTP id c25so3694113pgb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 16:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vv1JQ0JPb3zW29ME2GUJIKxPfKCAiMhdwxKiy7ndpT8=;
 b=dgeDSQ4rWvfeG7g3fUWqqHd6u5Yej8odwIm8hCWQ8GpG/g3pb6MJoDugAmCrpg2XKC
 dMOn6z1EGoaoxJJWYyeyHoulgjI5ws1Jx6Ol2jFn/V5m3PirBP7AGuPrvZ13NrdmTzsq
 VRS9lkF0wXJoPejN+SyR8GxNwrECdfNMLu20A19BySdmruSSViNzKM7KggpUxO33+FjA
 9+ptU2wkSmfw4kEbcYnRfRbUhhBXiQaO3wW2zZMioZlcKZ6N+F16TmUWYWroncV32Tcj
 GOSkKpkCW+G5p/+7tSdSITF0d3FoiFyFDZXPnO2vKZe6ZCO6FuG7SXjW5KcYoLqzICR2
 /Thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vv1JQ0JPb3zW29ME2GUJIKxPfKCAiMhdwxKiy7ndpT8=;
 b=aDRQnUYT5yl1tnv+1n8qWpqBcg4oVCUNbNTNwlkr2d9LGg1qdY+Kifh5wB3l6rbOD2
 vIloG1LaKxIoO8Gi/z4qoe/n5rjmz+mB0fTpJHGmtMwJg9P6Ar6vtgkj3IWeJDFItokz
 JcwAIYP2A0BRByIDm9LnhrImvPm6GKaRbPsAsTvEjo77N/7qJFPe87fqJfMKon5Cg5dN
 m36NDswxetfzCUsdq5NjyTcxAq3YQf2oAqcyhDcvz5L8W6FJDipmSZwGyNvpGqpor0Zc
 1PkXuF1Nq7OzEesA9gZMssMjZTzBN1UhJwjWnQkOKbru9tY1R6OUZ47jIzNrh5Y2JCav
 0Plg==
X-Gm-Message-State: AHQUAubN0D2UgqrlLyJORLYiyh9jDblSsryqtY2hi+QskkkoBfm5p7r2
 EPq7s6ripgAYQn0Ctg4afqw=
X-Google-Smtp-Source: AHgI3IbueUOqL5nL2fNRvAN23j3r+E7P753d0IpuIiubkVzEhycMzHGXfKU7QVaUV4v2VqrRfHm+dw==
X-Received: by 2002:a63:68c4:: with SMTP id d187mr1533670pgc.11.1549066538053; 
 Fri, 01 Feb 2019 16:15:38 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id w6sm28374545pga.72.2019.02.01.16.15.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 16:15:37 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v7 2/4] PCI: imx6: Mark PHY functions as i.MX6 specific
Date: Fri,  1 Feb 2019 16:15:21 -0800
Message-Id: <20190202001523.12517-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202001523.12517-1-andrew.smirnov@gmail.com>
References: <20190202001523.12517-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_161538_681840_E2FCFD34 
X-CRM114-Status: GOOD (  14.11  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>,
 Trent Piepho <tpiepho@impinj.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PCIe PHY IP block on i.MX7D differs from the one used on i.MX6 family,
so none of the code in current implementation of imx6_setup_phy_mpll()
or imx6_pcie_reset_phy() is applicable. Introduce
IMX6_PCIE_FLAG_IMX6_PHY and checks for it to aforementioned functions
to make sure they are only executed on apporpriate PCIe IP variants.

Tested-by: Trent Piepho <tpiepho@impinj.com>
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
 drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1e940ba7e4c4..26e1e974b0dd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -41,8 +41,11 @@ enum imx6_pcie_variants {
 	IMX7D,
 };
 
+#define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
+
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
+	u32 flags;
 };
 
 struct imx6_pcie {
@@ -255,6 +258,9 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+		return;
+
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
@@ -572,6 +578,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+		return 0;
+
 	switch (phy_rate) {
 	case 125000000:
 		/*
@@ -1090,12 +1099,15 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
