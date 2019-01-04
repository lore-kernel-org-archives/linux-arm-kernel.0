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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BC7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:53:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6363721872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bSsNk26z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxm6kEFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6363721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jT67gFD+njNX2UhqJ3p7sbdG8rKNV2QFBAesWHz/HwU=; b=bSsNk26zUBvjXp
	XT3mmcjWJI9fexD6CV8bejdofXSwrHcLss1pFuvQsdKsL0r17fh7Ug4PdzT3D5ZH6PSZSmwM1H3vr
	nLMqKPeWprERg5QZ/PDaR1Rfl1GXEZdc7j4j45ZpRR5YwcQ7TUy5aIi+An8PImMe0msp33QE/tO8l
	uFfYytdOL/dw5dODbbFXVD+JAwVNgyH9XyBnoAO1Z2guFEzkNE5rAzwOuqvvhh4R8oy63vIzpjlF9
	F3i0P9kLt9RZj2RhJ5U5HNLRp1dPTmnkOEF1Rz76JW/QO5aKlPzU4WqfeqNN3qii6R3vpRDxNyA4c
	MFyKF6qnIo6B4IVXQJ7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTeg-0000Qc-4Y; Fri, 04 Jan 2019 17:53:10 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbm-0004sf-Jx
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:46 +0000
Received: by mail-pl1-x642.google.com with SMTP id z23so17737849plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ynqU9RdFevJBXRMN2+g/v2PRS5HmTSTnfcgRpzk4u8=;
 b=Yxm6kEFjm2RkQF9s49Wl9lpLEKQaWCgrgGzJK5R9UHJS1UVgwCfVpbBNj348R2XrVH
 vCKcWseU0/+SDTW0SZCIQnfpwsLSPhFicU+1miWDTDv2N66o0oUW66Exns97ffW+qrfw
 RMf4fsveTwbB6IsQfIdhNAXuG6oduKU6iSd+XRY7PHg7obcSUgVAuy0yZbDag9KtjSWI
 +St4d34B1pyzcoTEqfExqV6SL8H4dXFEe+Yv66NljD3ZMlSUIpGTv0/l0B8NjVXA6vmB
 O+trOHSZ+k+E8Bzm7hX8+fd+d5A4GoWUzwwnWqL4aIxl0VMuts8wPyWmv55CRMoWYIan
 yM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ynqU9RdFevJBXRMN2+g/v2PRS5HmTSTnfcgRpzk4u8=;
 b=XMJzo0+E5Ca3y/wzSfvEjF27Rp8yrE9OJ/GPG9yAlGbOQtoBgo0H5dq68tNBkgkk4F
 sjnYGg7jdo3A4I3sXdXNEIi+nbTO8aybpvGcciQKYqnTP0n3hnQl6iRlkzkCtHSXao6O
 sc41ReVVsDFjgx/hyQBwLS54hP2bppw2AQgAlz1QbZWU7aUNQCJsZAfgI6lxHpfMKkfA
 8AvEOUQnlRSUKoGDSsSpiNv4A2U/0UIqFGT1qE4rq3rVdn2o6uX3gC6CxNCV3mh1c9xN
 ipbCBJmaXrIRDavU/MWIbBhOqv9A4L2O1Ag0hrJ+lTQ/UOyPB3QXw/GCgpDXNIZdQfyW
 Kwzw==
X-Gm-Message-State: AJcUukft+W5W0+X0w1hX4lYmxZsropvlXtH35SRQl75CIz8wQ41vcPBn
 08kIKk6NYAJen3ZInKnCb/Q=
X-Google-Smtp-Source: ALg8bN74f+KdjZLhDwczdKTH2whSmV69SzJxJ0xGAw4m/5SP+7k3rouC0lpqbaMiEbcPeqt+HnovEA==
X-Received: by 2002:a17:902:20b:: with SMTP id
 11mr51889493plc.57.1546624209871; 
 Fri, 04 Jan 2019 09:50:09 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:50:09 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 15/20] PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
Date: Fri,  4 Jan 2019 09:49:20 -0800
Message-Id: <20190104174925.17153-16-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_095011_194251_51DC87EF 
X-CRM114-Status: GOOD (  12.35  )
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

Save a couple of lines of code by dropping assignement to 'var' and
passing constants as via function arguments directly. No functional
change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 02342b1762fa..befbc09c9c41 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -172,7 +172,6 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	u32 phy_ctl;
 	int ret;
 
 	ret = pcie_phy_wait_ack(imx6_pcie, addr);
@@ -180,8 +179,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 		return ret;
 
 	/* assert Read signal */
-	phy_ctl = PCIE_PHY_CTRL_RD;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_RD);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
@@ -219,8 +217,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* deassert cap data */
-	var = PCIE_PHY_CTRL_DATA(data);
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_DATA(data));
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
@@ -228,8 +225,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* assert wr signal */
-	var = PCIE_PHY_CTRL_WR;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_WR);
 
 	/* wait for ack */
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -237,8 +233,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* deassert wr signal */
-	var = PCIE_PHY_CTRL_DATA(data);
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_DATA(data));
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
