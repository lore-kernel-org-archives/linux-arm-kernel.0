Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B91C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:33:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6057021903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PlpyzqrF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRg0NhYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6057021903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kHuaoVnDFzmb4moTeOImShWgh8+5EXmqyQJOKVUODW8=; b=PlpyzqrFyLxKah
	9pZyKkJZoflNtRMYwIeepki1E7f4xI3jtSTwcubooz92/MoZWeqG3qcvwVZjCISwxzixp6JNj/2vf
	j2qlu96feEWfDNPuFN+ZLZkFTxKWqmSwACeCdJgouWnPnGKjGwCwbwgXaqQYeYWp1tuAAKpyTIKhz
	zMx5VDP0KmiD44QJ4G6IUi0FyWoWgDfit8hghtUuiG7IbOUT5oSWfDvQdASvpDLcRf/1ux6Sjk/fi
	VR6l88dm+CWqa/RnfJ/Ee73tzewf7atRaaTD89eHK+TYykaPKiVPt38vd1lwvmaajpE6JhwVrf/z/
	epY+AgnmLni96FppBnuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFJf-0008SY-QZ; Fri, 21 Dec 2018 07:33:51 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFEI-0001wp-5r
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:26 +0000
Received: by mail-pf1-x441.google.com with SMTP id h3so2195459pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eae5kd40WjRlq9zOByiDPPD319NoPNuivhFx9H6fzrQ=;
 b=GRg0NhYFHUyygYkVSFXYtmsieJ+LveULDsOkgKglG8BJJVcPiWV9qMrCq31CoAFk1Z
 MHM8v/PiYCKo7w1Tb7m3EkmnXdDNh9ZvIDRY/F8Wz5C5VgeCxaCnU12kvw/jGjmhnSzO
 wtYt+YK0q45NjRE/ywjsiAayK5YQAD+xUIC1t7Mue9nhZSqSpmqYRvyEcabxZwhqfnYA
 lT6e8u/Vm11g2k9LfxAQLE55+6O0LX8AulBPIKLDJIi19qYvNZ0H2MSeAY9RAKbvifqS
 kmkX5c4t4XCA1yU4oeTdqUyPOPGEDm937Mwk7tu4XyuT/m/VMXNCoutY1/CZCtZjUHYi
 Z2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eae5kd40WjRlq9zOByiDPPD319NoPNuivhFx9H6fzrQ=;
 b=AfHODYTVpmh5zMOYA/8qRyp7cbo7CL2rg/p8MV/Yn4jp0u1klLkLMzLMHNSndETk/w
 J5HBYZgBZm342WKdmahH4kxvbs4dkzsKTpt1OQy+4wPbpXRUI4cRtT0ntJqXQvcI9e28
 SGjKU85NZlZXzeb1qHPicfYIFzpHg692oPy64CNcI43E9zM/KdVnLkquqv7VU2VS3dCX
 wfU7akmfmWG1V7FcBXMyAYj4o7xitJbFgtXgUylrFuRjC/FO34ZtktLp5rLvvEGtROng
 ItUvSOhBjnkVqUAPcarPOVbHwPHmGXjgVY406RIhoGKki+4Av2tw4jPpdrtnxStzcvjd
 3wFA==
X-Gm-Message-State: AJcUukca17DHEToA1C2rMhUV9e02BZA8P3qUwyDLtq5763IwqeBi4Exi
 hzEDyRB0If3oGeljW2g2208=
X-Google-Smtp-Source: ALg8bN4Apu6v2hERGWDIotDPk7xa48XrCB98F2x4qGIaU6XU06Q/pdE8/BPYRN79uXOW1j3j9qBvIA==
X-Received: by 2002:a63:20e:: with SMTP id 14mr1327440pgc.161.1545377287259;
 Thu, 20 Dec 2018 23:28:07 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:28:06 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 15/21] PCI: imx6: Restrict PHY register data to 16-bit
Date: Thu, 20 Dec 2018 23:27:10 -0800
Message-Id: <20181221072716.29017-16-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232819_219441_A6290404 
X-CRM114-Status: GOOD (  12.73  )
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
index ddab1859a07e..98e3730e75fa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -152,10 +152,10 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
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
@@ -170,8 +170,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	if (ret)
 		return ret;
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
-	*data = val & 0xffff;
+	*data = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
 
 	/* deassert Read signal */
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
@@ -179,7 +178,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 	return pcie_phy_poll_ack(imx6_pcie, 0);
 }
 
-static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
+static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	u32 var;
@@ -236,7 +235,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
-	u32 tmp;
+	u16 tmp;
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
@@ -547,7 +546,7 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 {
 	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
 	int mult, div;
-	u32 val;
+	u16 val;
 
 	switch (phy_rate) {
 	case 125000000:
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
