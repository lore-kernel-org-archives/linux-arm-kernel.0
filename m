Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01724C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44E921903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZWJapWr9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWKr5iYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44E921903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Wa0/Zyamxf6XAlKRmP5dWmoJefLIpoP843Jm0UhQY4=; b=ZWJapWr9VWutHj
	PYTfODkx70IEpU+qFDqs6sh6AOF54rMlbDw7amF1aYr5wRDatrzYyMRWl+5rTxzb3caRiUJjqNxjj
	aHvm6R120Hlx0F8ZUVqCSeZrj1iAYvvHMGtNTsOcyP55Qb7a+9S0iJDQALOKhrqFIBueanG7vg1V1
	m1HWrSJWb2IVTSeyI4TXIysWO68yUB+7WooD/6czP2f6z7+WTmU4+JubAShaIg3n6tz0a+CGZaVcf
	JLbuFsX+0i7yL81xVd08vJhwL+OZTIlrvHFwrRd4Ayxj9b/kvaX79wZa/sXu/A6KvqrimENyu1qkn
	sBGqrOP9QjYIG9iELUSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFED-000209-9U; Fri, 21 Dec 2018 07:28:13 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFDr-0001e7-Pi
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:27:53 +0000
Received: by mail-pl1-x641.google.com with SMTP id y1so2097448plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hVVP0IYzly0vMq5I85m0FEXZqGuHFqhL3TgllfB/KdA=;
 b=jWKr5iYU9+2g6DtIQu8snbJTc9PNoAsCGi1RT8t3Pz7KQSHl6HNF77Qo21gyyeLUng
 AzPkU3n6zaQZyTEzdTbDl+pcsFL9TPECklIiWSpFMr1vxEfP1g3SttLUV5/cN1nRJVcp
 5v4prI5j6rTWUwhyemQ/VTQGYRRw7iap1KO/CXAt+NxDA90L6OF0f808MsGtEJe+YKMS
 UP7hbezFpqaOEvKo7zz2VaXqpnF7lKdrLD4Do6Hj3nYMIe4nMu2wi1ijsBzE2xu6fJC/
 gpTCv62SYB173S5alFQFat7CMOKIB7USTR/0E4W9olZuLCh8xffJu+hYo4YlxH8dxk3k
 UTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hVVP0IYzly0vMq5I85m0FEXZqGuHFqhL3TgllfB/KdA=;
 b=LkJCPGRhIfyVTZwqtTM5bWrRgak6D20GDVydvEWUAlUoi8upJQRQnHnbxTCacUElr7
 +UnUHwCrkyecaIs7vbK8hync/qXF/c90L/wyQS1OOBptt/LqXXK39TTrXypPxNAW54SJ
 B32k4wwpxVLLqCEOtkAoudqKf7DMrNDKlHHqf8JCiYdUKa0AZy7qu24ccbAAcTpHyp37
 MBNHbzzXgUr+cl4WPNhed6xdjB5/B0Qm7wFfF1ZjWrbyga2LEXxHXjS7sR70Mqq+dDF/
 H+in0k81PAM+nM/n/x0R/2ELyNhyayjFpIUJmB5NlkQCa+uW29T6ivRV64o+CVA+sUT0
 bKQQ==
X-Gm-Message-State: AJcUukeMZ/PbkzH+e1k2f2Ank1Sr5YAZGhIngqFcb5Xzd56U08C9WVvm
 Js953gk99EdC5p2jrQ3QjQk=
X-Google-Smtp-Source: ALg8bN6J5cKmyuuAHi7yPnlOzdegH1xGaUvuu41+zv9Bkm4p3XWirADGk2+fC1OIgNE/+wBOtr3hAQ==
X-Received: by 2002:a17:902:654a:: with SMTP id
 d10mr1401337pln.324.1545377261015; 
 Thu, 20 Dec 2018 23:27:41 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:27:40 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 01/21] PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
Date: Thu, 20 Dec 2018 23:26:56 -0800
Message-Id: <20181221072716.29017-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232751_833207_D7C0B7C0 
X-CRM114-Status: GOOD (  12.45  )
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
index 26087b3da590..c87ecc305dc7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -69,9 +69,8 @@ struct imx6_pcie {
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
-#define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
-#define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
+#define PHY_PLL_LOCK_WAIT_TIMEOUT	(2000 * PHY_PLL_LOCK_WAIT_USLEEP_MAX)
 
 /* PCIe Root Complex registers (memory-mapped) */
 #define PCIE_RC_LCR				0x7c
@@ -418,20 +417,14 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
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
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
