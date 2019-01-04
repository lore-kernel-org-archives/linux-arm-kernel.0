Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D9EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:53:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA19E21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qKLRLdOj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+x2Knz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA19E21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RWMBBbkxD7bWZ7X1W/G9BxMUeityygEpTbosj7kAQSo=; b=qKLRLdOjhKkHpO
	JDCNyRUVfWwJpcE24jGEervVrIUZX7KmPyJA9vRz3EVo8O0iQoemuA6RiVKB4Q78H0Mn+H8keDUcc
	+z86HE2O2JsYW02csT8UTOyA72wMhlnTv/20L6viA2QuXg0UV5QmSydRPVbfFGqtmvbZLwTWzO2gS
	Ct4DRks1YTcS2hus7IRl5ODNP6+mYU7QT1npXPEcvtGF4D5D8pE6CWrf87GxrnAf0rNj1SGyfPwLy
	FhEyEhf0FoJhuhKk0rJuSLiP8w4yJiIiFp5kKFf4G6jkrYCOC/h9+aMbW+zfUnYc5DRm7UW9PdlKO
	rXrybq7Ujn3EE8qiVD5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTeT-0000Br-Kb; Fri, 04 Jan 2019 17:52:57 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbk-0004kJ-FX
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:44 +0000
Received: by mail-pf1-x443.google.com with SMTP id g62so18615090pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l5Ov7DgLo0x+QhZh8MrjSzuZLAXS/elFdRJcT/iufBQ=;
 b=Z+x2Knz6I5ntkAKsqCwQ9anK0XjHjRnyoafbwABQO+I7pDLITu4um2CPX2i1Bckg6v
 29Hh89TWOMYuvDjF+SUnwxxiFpptVU8xpnaxPHB/LFhUOAEHkr37M47CbH1XyoLDokRz
 uC7TfNtUpsaZh62rmf+rmbT+IF60xhv0/FjsFgkgAYaYoY0ShTPmCis2MPCFBsvQnEd8
 gr6oPY1yKgev0dck7068HdqsS2bdNFzGKpt7Jn/Ailm+wrk/JlqWSHMI3mJ/VzaJxnSt
 HwP9NmJe/nY8wP2lhdvUBwjZKKkOMfRnLTpBUdqngwJ7ZcL4OIXFncAukcyntFifsoTK
 EuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l5Ov7DgLo0x+QhZh8MrjSzuZLAXS/elFdRJcT/iufBQ=;
 b=AoBYZqMjs4ZDCg157LQi/b75XQi3xZToO2pEgkoRR3m2Uyts9Czpk0eEyyDpOjyhnv
 SijFZQTHZVYCMzsxBgMeY4BmAjUvdmtwUnxBsth4+yq1FUi7LgPMSLIv+L4Cy/kzUuXP
 2sbFaGZCyUocef3nvD9eWiR/jOKv6Maru5GE+HuAhJrrXMmlF16ZopcddA831HPeuA8w
 pm3Gh8ubyN9N+1SZLNTetgGmdgV22umJuthlVdLvpfykeqqVH5i22hrR2HYVX79Pp9Mb
 PB4XwOGeviUDUtuDunNP/9VCTeOO2W5ia8J3oNCp0jYjDf0j4qNQREMmXnF3oPdGRHqo
 RmPA==
X-Gm-Message-State: AJcUukdh8Ic8ME6znai94neAZ2YTuPdyTHdCA/e1zOZP+tnVLk8IMJ9d
 PxRgJ7grgJTOKQkqHaB5TdE=
X-Google-Smtp-Source: ALg8bN7BnbCyiCZzhA0J1wCL/o1gaSR4ShCULsxdY5pRgwbfRrYr+yjjrTRBrpw6u9ccj+3j9K7Vwg==
X-Received: by 2002:a63:2c82:: with SMTP id s124mr2385458pgs.73.1546624207694; 
 Fri, 04 Jan 2019 09:50:07 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:50:06 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 14/20] PCI: imx6: Restrict PHY register data to 16-bit
Date: Fri,  4 Jan 2019 09:49:19 -0800
Message-Id: <20190104174925.17153-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_095009_253591_6D7A3BB2 
X-CRM114-Status: GOOD (  12.84  )
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PHY registers on i.MX6 are 16-bit wide, so we can get rid of explicit
masking if we restrict pcie_phy_read/pcie_phy_write to use 'u16'
instead of 'int'. No functional change intended.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2a7075a9cba6..02342b1762fa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -169,10 +169,10 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 }
 
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
-static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
+static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	u32 val, phy_ctl;
+	u32 phy_ctl;
 	int ret;
 
 	ret = pcie_phy_wait_ack(imx6_pcie, addr);
@@ -187,8 +187,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	if (ret)
 		return ret;
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
-	*data = val & 0xffff;
+	*data = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
 
 	/* deassert Read signal */
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
@@ -196,7 +195,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
 
-static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
+static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	u32 var;
@@ -253,7 +252,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
-	u32 tmp;
+	u16 tmp;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return;
@@ -620,7 +619,7 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 {
 	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
 	int mult, div;
-	u32 val;
+	u16 val;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return 0;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
