Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8892CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509FC206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UgROPBbq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMz5/GBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509FC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WF9XxLxPya0Qk9mZRGsi4KN8G3+PzyAPYIMLqqAqWm0=; b=UgROPBbqXGgEBE
	NWjI750b3jw22/T6OrG+IP3mPpTWQh/jURdQcUMplSHzQZjfXTL/Dp8OD8NhrDukJvcRwCUdO/8HC
	hBsnohLSO8AKdmdZUGBwMVc3apR7q6h5EmePOfVejR8Z1t/xiiFg0dv5GKLKhnVxqr3R0j4nYMOa5
	wpQW8vCCsKoc1sJctZcCOLSz3w+4yA4A52Di7FLW2GrUjpb2AWDZWVNjxGGJAOQhjr9daeKiex/la
	BK+uuuLg2zlb7DJajVrloSoUScJ+bQj0HAYnzHCYYWGHoJ8lcDnN3V2BG4uMQU9edQHStBABiBYA4
	ShVaWCIqKLrZzJBxNSJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giRGl-0008Sr-Nh; Sat, 12 Jan 2019 21:56:43 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giRGL-00080e-LW
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 21:56:20 +0000
Received: by mail-pf1-x443.google.com with SMTP id i12so8575100pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 13:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4NEECKxkIUpvSN6zGsm7tNAQxLgNjozzJMg2Nudc0PU=;
 b=rMz5/GBy6/gc15U//9gI+99oGPz5hxi+sX0WwNphIwrNNKnOsuHz9s5EhyNZByFY1b
 kHBF63BOW1RytSJjhwuW0j2dfkMje2wY6qDw6yjw2s8rmV0JiyYravzCmkcGeM0zUcni
 /4qUoHgUXbGTNbxwCzF0buDJtZyak5rGQyKxrv9vi1B79oiOgUv7zYbr1jAP6rydeApJ
 SqqonS/bWnxvJUTlVTGJ7SDEAjujqO2DjEbMcQKRK75dkXtLEoffrN2ay/LGtQWQ8tWP
 ghHQCh57I6czhAB6KkJwR9pLpJblYZvVChBqkCSrhcftjir5uYvIOjMgQZlq1obknfkE
 Tdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4NEECKxkIUpvSN6zGsm7tNAQxLgNjozzJMg2Nudc0PU=;
 b=kc9569GZRhSyKTsYYj8pdkgv1Y6ygTEIg20KYUftaXLOmz6s9dHjjQwzJTNDmTERzb
 tWCoiDhjhvm668/SvXnXJ2nggSXxFf0PsPmlkJ7e7xQJWSRx5yW6Ic202cd2c7km0CZX
 yp0Qet/DydG4ANJFA8lHF5V6X2u0Nttx34gYJAj8TZ4kRlRro1omn+XZbhR0jVIcaCZj
 08ayf/M5Iken7ZiArdVi+Y/q1EddGIUile2Zpa1/XVS7K3iBzW6m5AGikUZj72brtr1a
 xQjP7Zn7cbXPpJEm2DhQSxbdlZ2PQppDGj3pII2g4mSm2Hpctd4sHcXD3Z3x3WN2Lbza
 bFBw==
X-Gm-Message-State: AJcUuke1mEkv+vuNrRlsl0NPh4ybrh1IWx2ZXAdWk7zEk8VYpiaFL00x
 owzQ8+pTfzLmKZdAM20qc2k=
X-Google-Smtp-Source: ALg8bN7K+Jjy6MZPt9Os8t8im72vZIZwSdzAQvGDXtLmReZlS+dIMrfktxopX5vgGjoUOE0PXjHV7g==
X-Received: by 2002:a63:cf02:: with SMTP id j2mr18231120pgg.113.1547330175965; 
 Sat, 12 Jan 2019 13:56:15 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i72sm122284327pfe.181.2019.01.12.13.56.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 13:56:15 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v5 2/4] PCI: imx6: Mark PHY functions as i.MX6 specific
Date: Sat, 12 Jan 2019 13:55:59 -0800
Message-Id: <20190112215601.9535-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112215601.9535-1-andrew.smirnov@gmail.com>
References: <20190112215601.9535-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_135617_708509_447C8D82 
X-CRM114-Status: GOOD (  13.51  )
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

PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
so none of the code in current implementation of imx6_setup_phy_mpll()
is applicable.

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
index efff3d5e9162..c55d93c1187d 100644
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
@@ -256,6 +259,9 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+		return;
+
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
@@ -573,6 +579,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
+	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+		return 0;
+
 	switch (phy_rate) {
 	case 125000000:
 		/*
@@ -1088,12 +1097,15 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
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
