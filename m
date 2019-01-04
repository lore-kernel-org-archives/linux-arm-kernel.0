Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6991C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC41021872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lPD8LZ/u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKAjY0PK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC41021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IhZps1CmI+cNWhDaVCD3jV0lQ/azepyfVy/x5J2r1Gg=; b=lPD8LZ/uCryZwZ
	nsNRtv63DU39nsmupYS0j2GXce+7u/TkkNLgAi6eZxdj7kp98Jrwt1cmWx9HYiwJjBLWrR1lVBCRa
	HZ3tiQ7fRhKw4pOCzXxUKZQXXrzEf7A4ePLTpOg8yBeLty20lAvXSbgwGLzrqF1sRFG7TeFCMnttO
	9x9aowEosgr7l3Lh0e1W5+9R2c2wxUFOFZBayQibdx7agMKnsumL95++QLRJ4b/y42Ry2We625Aov
	ObUmbVy1+5d8o1AXzBrrvO9SD3cLNQ6oxx31nXK1byNY7oPjnUcRgO2RCfmG1J3gAb70T6kebfH97
	k6/k2GCUkwCPeYGDoZHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTbY-0004GZ-RF; Fri, 04 Jan 2019 17:49:56 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbK-00043T-2g
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:49:43 +0000
Received: by mail-pg1-x541.google.com with SMTP id d72so17766017pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SKJa7zEhO/trHQqEjEW1IcZtpd/PYQwbclM+tRkTBpo=;
 b=oKAjY0PKvzJmTqSAvtXWedrQvqbliB4L1vI4Hhc5nAPWIqnFLyUoscPOLjJIvzMusj
 4vdIm1sPATs5dxmZryGBlgT1rclkEmznR08UXj1BblyRl3P8bNjQElqb/jyaSSBZzXok
 ipoWetngUFR/b3oT9yLNp1UQYB9Ba7qUQB8ldTW+pU2dHJ0V9DNdAJavyz464ViB0qB5
 RvTpZzPKPUoUSxwbDHNi2iH3FM6quo7QV/zd3UAJhHj4K5cF+hErydcWKT4YApELfhSD
 0KlF/1jY5WiHsQPIBEht2JkAa2F0MLDKRNUNsbPFSffS26/BAvDxYFdY9oS4UXrU5uI/
 PPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SKJa7zEhO/trHQqEjEW1IcZtpd/PYQwbclM+tRkTBpo=;
 b=SIvSi3afldb5ysUjypA/WDVZ2lfOVZJi8X25Hi/FFqyxnCWB52R3EPJsrM+nJjhbhc
 O0neW3FmpDyyk1qT1VYe0StoJT1pIhXLGuVHBKy24R0loY7ZWMqJXcrTlKB06WyZZpe1
 ngvTLBvDir89mQUwRtIdtgOC3/eUGC2UyF2Ayc0ufy3t7h//NX/XMg4JabNaW64txqDK
 3TAdE7GiXni9umyUIoQ2v1aRbVoiiZfU4pofuNH9iKAaX14oj8/RFzL/xkLVqFL4TdTm
 PdBh508/XWj0Rl3wUkdQv9W5pVYqJsl1ebJjoS+b5iJ4pYI4ySWeLVMZRBGGggwYEbur
 SURg==
X-Gm-Message-State: AJcUukd/Ao0e0Vu8EIwitRt73eVkqyk+7UT2UIW53/+5B6w+AGKcSsba
 GSVwjskOEregDfZxjKiYItO/t55kCVg=
X-Google-Smtp-Source: ALg8bN5QBpDrJLeoSdKMrCQL9CbxLzeC6h/BT2qr3lg4ES+HltYQyU/0jZrnnT77QyM+EIwTAaS3KA==
X-Received: by 2002:a63:a401:: with SMTP id c1mr2443713pgf.403.1546624181277; 
 Fri, 04 Jan 2019 09:49:41 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:49:40 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 01/20] PCI: imx6: Simplify
 imx7d_pcie_wait_for_phy_pll_lock()
Date: Fri,  4 Jan 2019 09:49:06 -0800
Message-Id: <20190104174925.17153-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_094942_163342_3B65B80F 
X-CRM114-Status: GOOD (  12.25  )
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

Make use of regmap_read_poll_timeout() to simplify
imx7d_pcie_wait_for_phy_pll_lock(). No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4380ee797c04..c73c7a6a4c55 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -86,9 +86,8 @@ struct imx6_pcie {
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
-#define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
-#define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
+#define PHY_PLL_LOCK_WAIT_TIMEOUT	(2000 * PHY_PLL_LOCK_WAIT_USLEEP_MAX)
 
 /* PCIe Root Complex registers (memory-mapped) */
 #define PCIE_RC_LCR				0x7c
@@ -459,20 +458,14 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 {
 	u32 val;
-	unsigned int retries;
 	struct device *dev = imx6_pcie->pci->dev;
 
-	for (retries = 0; retries < PHY_PLL_LOCK_WAIT_MAX_RETRIES; retries++) {
-		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR22, &val);
-
-		if (val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED)
-			return;
-
-		usleep_range(PHY_PLL_LOCK_WAIT_USLEEP_MIN,
-			     PHY_PLL_LOCK_WAIT_USLEEP_MAX);
-	}
-
-	dev_err(dev, "PCIe PLL lock timeout\n");
+	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
+				     IOMUXC_GPR22, val,
+				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
+				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
+				     PHY_PLL_LOCK_WAIT_TIMEOUT))
+		dev_err(dev, "PCIe PLL lock timeout\n");
 }
 
 static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
