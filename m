Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127D9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:10:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E672082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XoI6mOtI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGIdgDb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E672082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P13feE+kDidqkpVbFOBgk8W+niWrNdRn6ibcYbYQoaM=; b=XoI6mOtIIFgkui
	ygKrctzBpqY+guseUHBtHIe4ebNMUprBHDLiAZxQAP27m7jwdTr2wTwNPU+gHvu8f1OidWXjZYlXl
	7pY19FEjKWApL81IqyfOeFQmgB2R6/5OyqSqRgtHybEvhOEn+XdD9kAsrEVcRFSM/qCOdL+oOTxb+
	EI4PYx1cTCTHLHO4kzOzZ3WMG+5a0yCAdQq4vQs+64YsRt7X8cpv7H2/iLj+jd4C4w/paoTip2q/2
	/9MLuDIvADc3cun3ERqMrWX1PG+xSb7hI0vWvePKcWyzmApebqVt4gEDtO8/hWd437uS4K6Gy69ds
	U5KgdxbBsp9GXsp4IyOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYfYY-0002A5-Vi; Sun, 16 Dec 2018 23:10:42 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYfXm-0000Au-HR
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 23:09:56 +0000
Received: by mail-pg1-x542.google.com with SMTP id v28so5167813pgk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 15:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5Ky7pgVvvF9hLcoAABtSFG13zMfTe+6ohhmnBjH727g=;
 b=tGIdgDb675KcT+PZnOTanBgWwaRyRZ8akrzY/vSuOGVM6xzj5vyScaAVotj5bZpEkE
 FVoDtXtL3k7gKaJWHU1Wq0E21vMIcZNUIHPcWwH452UDtgxX4pkbAaFCA906Abxtu30a
 Db9Iti09HC0aKdfYRLmzFKM90w3eRdmmBx2fJqoBDNvKjWufckWbDUJJuwUsdDoLctMK
 VUz8KjXSvUV09jhFTOVucBOU8bP+6Rj/qXvMSXsKM9pPCoWVTpJsptes7aHLA8QP0EGH
 Yr03NV4WKX2YCp5CECk6Bjw0nNcJ5WnlmWHMrB3RGn8DpJDgdLCFxE9uF3xG/aomtjU8
 GDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5Ky7pgVvvF9hLcoAABtSFG13zMfTe+6ohhmnBjH727g=;
 b=FVGq9vSYSz0CCAcUoXwlxdgB5bLyzoQPKCH0qh2vmV/AzMa8nmjjYO1rno4gJ77792
 NJ17kNVrYwJIez7f+iO/f+i6Jhn4/PRomPnShr38WzL8C52fpual4u8whwruzn0kFYU6
 XTdmvy54xO22VAPwfHEYe5gbc+E+f1V2gHk3Doj4iAe3Lo2WX5ZwiqB0XeDHQ6qH6wt0
 3VCwu9gvYiUHaSIaGlSOe8cqAluDW3CrZ+yCNP1Ujl40DvUzZINoQHS9NgUXSaSzqVb9
 wMWgvwWf+fHVsk0ssWqOUQhI9eTHwtpqugCMRyb9D1YOFSv3ahEAE4MJwsyZKEqV0bnX
 4Rdw==
X-Gm-Message-State: AA+aEWZC1HlKwtH8PwB+xLiw7+2tZhkLtEx2bQMSalV1IZ/+e7cAQx6i
 9Cr6dKyS2XiJl58lE/lzkNo=
X-Google-Smtp-Source: AFSGD/XZNYx2ZnQ0ULXCggr6Tfm83Im0nuTyZ09O2JjFgAMUa2UbKSPGJU0RhePW3s4ea+HzH6fobg==
X-Received: by 2002:a63:1e56:: with SMTP id p22mr10128690pgm.126.1545001783805; 
 Sun, 16 Dec 2018 15:09:43 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id d18sm13837878pfj.47.2018.12.16.15.09.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 16 Dec 2018 15:09:42 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 3/3] PCI: imx6: Make fallthrough comments more consistent
Date: Sun, 16 Dec 2018 15:09:16 -0800
Message-Id: <20181216230916.22982-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181216230916.22982-1-andrew.smirnov@gmail.com>
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_150954_915724_56D4D1AF 
X-CRM114-Status: GOOD (  12.54  )
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

Convert all fallthrough comments to say "fall through", as well as
modify their placement to the point where the "break" would normally
be.

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
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 59658577e81d..a0510e185d44 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -362,7 +362,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->variant) {
 	case IMX7D:
-	case IMX8MQ: /* FALLTHROUGH */
+		/* fall through */
+	case IMX8MQ:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
@@ -415,7 +416,8 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
-	case IMX6QP:		/* FALLTHROUGH */
+	case IMX6QP:
+		/* fall through */
 	case IMX6Q:
 		/* power up core phy and enable ref clock */
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -607,7 +609,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
 				   IMX6SX_GPR12_PCIE_RX_EQ_2);
-		/* FALLTHROUGH */
+		/* fall through */
 	default:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -731,7 +733,8 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2);
 		break;
 	case IMX7D:
-	case IMX8MQ:		/* FALLTHROUGH */
+		/* fall through */
+	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -1076,7 +1079,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		}
 		break;
 	case IMX8MQ:
-	case IMX7D:		/* FALLTHROUGH */
+		/* fall through */
+	case IMX7D:
 		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
 									    "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
