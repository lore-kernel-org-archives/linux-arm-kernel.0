Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1325EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D723B2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nXSlCTxS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2NCdLTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D723B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iKgMjJpGhj3vU1a3KVN0nFhrf2XU4gHvBm3lDz5a3n4=; b=nXSlCTxSfDpMqe
	xnzDqWR910T9Ceh/0sRI07nh7f8Q13hnxLLYcN5ruQXkk0IjqWkjXCBcThn49yiqIQVtXMEhydXdf
	yFGuoDteYG9vZvjZH2bGlDIkHCALHStNr0khucNxK7jfm7FphPySzizBAFDLsnKLbubQYwokUl7CO
	Nvqca1VeD5RR/O8jMpaUtgfAECl3V3asqCAdUmYWYIsVY7KhU2DTVuwx8mJasLEpjvLu4fTffinFy
	NU03Dz4mRG6Z0iPwNnYQ8VZn1S0DVqRujhZqkPuOZhDurl6gz4ecyGwnwNaXRbh8h2dlp1fOFh+xS
	U1h/y+iRJ02nys8NskPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtNEk-00015j-NY; Tue, 12 Feb 2019 01:51:50 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtNEM-0000gO-CP
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 01:51:29 +0000
Received: by mail-pf1-x443.google.com with SMTP id f132so468425pfa.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 17:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sMMxpgSAniB8LFv+M0YvWiyKlN5hrWVQrVJB4z8L3aY=;
 b=Q2NCdLTe3L02gUvsERVySCKHaosfpploZ7PksExlTb+pRbqf4g+/w2laNGEF9s3n7D
 BvjDsXKQ1OFHZxurw1RKwZgs5DSysAgHmZweQDOXKH2/UQHJ9GqvpAB72R9krft3vAjY
 qIQazMqb4HojIG9l41zCkgr0+GDKI7/S7ZQjB8ghQOQhArPiu5KYyy3+SM8M9nJm0pbF
 UKigOQyO6c3HcN5ABEj9YlNZjAEj0ZpaMH/xL+Fh+zpkjM0OnH93929okw6KwBhOphdN
 JTEwPuV9p7X6LdPzD719lkpRmGreckTQ0huJhT2+fHfJD4TUX0fcWvXhNLDemxkLj7Qz
 /a6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sMMxpgSAniB8LFv+M0YvWiyKlN5hrWVQrVJB4z8L3aY=;
 b=bj7Ma4p1VUIUmBnnMa/nyD5PwZLy5iee2Jl8LbfaR4hhY9ROHz2l9SQf2lDIcjYeyz
 0aStOETjKkH1zYsZflbYRvzN8SadUlL0c8nzcqS+xbNzil5b91+c+UrVuiXt2CKxI4Ey
 obgMjXlWPZaVX6MaVcRKfk9QtcvuLYxZNIq30bkfAKBVBehfNXdT9iObPMUb8xMCkkXK
 Tr6h5XV/XSsVIPNUFk+UaKY+YO78fKVDSSZ7yHTYDA7qMiJ6lfaI2LEre1i8rtfVBbXw
 ivt3azzcvUV3Ama5wCbMHmPuO2FRWk/8cPSqks+8oGtJTF+Sk4ftl0ET0/94eE2tQ37w
 72+A==
X-Gm-Message-State: AHQUAubUxeyd3yyORorKy8UXOgE2hGn8RJeyfsCLpMh8Z5cRFMP4din0
 8rLN3pkTOaTEUu91rQc/5y8=
X-Google-Smtp-Source: AHgI3IZuyGNGaY3+wbNd56v+9F6Z4rVnNcBqyshgVkthaFjRMDAQfmZ2q/nKFILjhcMsn3X28rVzdg==
X-Received: by 2002:aa7:85cc:: with SMTP id z12mr1418728pfn.196.1549936285714; 
 Mon, 11 Feb 2019 17:51:25 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id h64sm17146941pfc.142.2019.02.11.17.51.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 17:51:25 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 2/2] PCI: imx6: Add code to request/control "pcie_aux" clock
 for i.MX8MQ
Date: Mon, 11 Feb 2019 17:51:08 -0800
Message-Id: <20190212015108.16952-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212015108.16952-1-andrew.smirnov@gmail.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_175126_562196_00823B79 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PCIe IP block has additional clock, "pcie_aux", that needs to be
controlled by the driver. Add code to support that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
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
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7cdf8f9ab244..1a7031782846 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -65,6 +65,7 @@ struct imx6_pcie {
 	struct clk		*pcie_phy;
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
+	struct clk		*pcie_aux;
 	struct regmap		*iomuxc_gpr;
 	u32			controller_id;
 	struct reset_control	*pciephy_reset;
@@ -421,6 +422,12 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX7D:
 		break;
 	case IMX8MQ:
+		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
+		if (ret) {
+			dev_err(dev, "unable to enable pcie_aux clock\n");
+			break;
+		}
+
 		offset = imx6_pcie_grp_offset(imx6_pcie);
 		/*
 		 * Set the over ride low and enabled
@@ -904,6 +911,9 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
+	case IMX8MQ:
+		clk_disable_unprepare(imx6_pcie->pcie_aux);
+		break;
 	default:
 		break;
 	}
@@ -1049,6 +1059,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to get PCIE APPS reset control\n");
 			return PTR_ERR(imx6_pcie->apps_reset);
 		}
+
+		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
+		if (IS_ERR(imx6_pcie->pcie_aux)) {
+			dev_err(dev, "pcie_aux clock source missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_aux);
+		}
 		break;
 	default:
 		break;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
