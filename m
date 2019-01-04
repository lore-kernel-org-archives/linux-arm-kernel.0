Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA85C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFE521872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qrRdCOcI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub8qeaY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFE521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dmPZOKE1vFdSvPPGeaLj/SaX+Qdn/V4kZwGIgI/avyI=; b=qrRdCOcIKL+kl9
	o/AMa9Z0lLBIKGl3xdtHdVFE1u1rIDi3iMq3tCUbjET2T3y9dGvDLtx2k8MWFKchh0HqmgtB2a2V4
	EdjHDaZmrH9Ks91bquEJYIa1bC4wmnr12N0q3fDiDmsU+ZFkjZJvYKUMixbjiQIr3QWLgi2s1NPB1
	rDX6WHJxsmLtbbTGj7PCNdEqTWQgiyv+yKbm8mQYSnhtHKeJ2rj7JfxcX/t1kpkp6fFC2bJ3aKzCT
	u3z9PkjuaE5sYp+1BKjAmGIY8ULwe81LMewUHp0Q9LmTUqCJ9MNTZbczzuGqf7dXw5qy4BZUX4VeX
	Zj3n46iTWsCPYN18Mhnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTe1-00084C-ES; Fri, 04 Jan 2019 17:52:29 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbh-0004Y0-51
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:31 +0000
Received: by mail-pl1-x641.google.com with SMTP id e11so17728338plt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w9KU/W4CQap2RK2hsRI+gNohsIozdtadfTJIN88KMTs=;
 b=Ub8qeaY7l5BX2LdG1ZfhbYVBmhPQMPROSTMWAoNKmswTP6VRDypf41vEOf9/56STcq
 Anh+omXnyVcUeLEIrOfIWiQOpWL3u2qSB6G99UYvPn8trxp217l6WKeCVGV0pxlsF8tj
 QSoBShRy22VYH5FAkjasJKoeqz4BM/GTA8uc6af0eYf9da0FswdPOz2tXikRe7CQ4eJR
 CUiWdp9rKeB9ZIrE+6Xb+o3OH5LTNkvI9k5S2mXTHcNHgHsxQUtz/DOYhK+uvWPzkZmD
 gsVhWgB3stIYSY7EDMWD6ilSne+FzxTdywtd3xV/fhXmnI/+1jcAgA8eys/0t4NhdWzI
 1i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w9KU/W4CQap2RK2hsRI+gNohsIozdtadfTJIN88KMTs=;
 b=qOPsOZSDXIe8LSs3pG4iRGMImnE5mgagTBVaaKQnwCjDKKlJv5RgsIXe9Jt2vE0geI
 xIJA/YKGmtCprkp8SflcuK3PKqcaE2JuUncM3IwgeZ1Ru4pUHc41n6pEWPVbLT8yQWA3
 qVlw+tsHVehQGq5EXU5Xq0YTOnBD/YkYH693j4wJ0XX50rSJZD8zy48q2gBRQURRe6KW
 47VAZzr2EFg9raG90C4GpDo2QN3ea/9GpbxVzv41z0mv9xov6BZOVHadokVoVNXndn8+
 9/7QR6lB+uCvdC2HRwMtUWANeTvLEAn9+2HwM1GfTjGVBNhYpXzeWYiXWP/GyPXeafr2
 XJ1A==
X-Gm-Message-State: AJcUukfqG0FbaCqhYSzOhwcyM2c0vpvn1k1uIKXEyDaWfqc7KXE3l59G
 JWo1ixcGUAVWNNG3OQS8uZH/wvmmBPU=
X-Google-Smtp-Source: ALg8bN6gxG1OAvAuFAEIXqh5twg6wRoU+lumMTfjKcijYxQpWYiI8n+XqMJIwBM8BgFO/2q8sdi8JQ==
X-Received: by 2002:a17:902:14b:: with SMTP id
 69mr52373171plb.52.1546624204331; 
 Fri, 04 Jan 2019 09:50:04 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:50:03 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 12/20] PCI: imx6: Simplify bit operations in PHY functions
Date: Fri,  4 Jan 2019 09:49:17 -0800
Message-Id: <20190104174925.17153-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_095005_805188_100C4E38 
X-CRM114-Status: GOOD (  11.85  )
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

Simplify the code by incorporating left shifts into constant
defnitions as well as using FIELD_PREP/GENMASK. No functional change
intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 28 +++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 180ba57da4e8..672332483324 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -101,11 +101,11 @@ struct imx6_pcie {
 #define PL_OFFSET 0x700
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
-#define PCIE_PHY_CTRL_DATA_LOC 0
-#define PCIE_PHY_CTRL_CAP_ADR_LOC 16
-#define PCIE_PHY_CTRL_CAP_DAT_LOC 17
-#define PCIE_PHY_CTRL_WR_LOC 18
-#define PCIE_PHY_CTRL_RD_LOC 19
+#define PCIE_PHY_CTRL_DATA(x)		FIELD_PREP(GENMASK(15, 0), (x))
+#define PCIE_PHY_CTRL_CAP_ADR		BIT(16)
+#define PCIE_PHY_CTRL_CAP_DAT		BIT(17)
+#define PCIE_PHY_CTRL_WR		BIT(18)
+#define PCIE_PHY_CTRL_RD		BIT(19)
 
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
 #define PCIE_PHY_STAT_ACK_LOC 16
@@ -152,17 +152,17 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 	u32 val;
 	int ret;
 
-	val = addr << PCIE_PHY_CTRL_DATA_LOC;
+	val = PCIE_PHY_CTRL_DATA(addr);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
-	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
+	val |= PCIE_PHY_CTRL_CAP_ADR;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
 		return ret;
 
-	val = addr << PCIE_PHY_CTRL_DATA_LOC;
+	val = PCIE_PHY_CTRL_DATA(addr);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
 	return pcie_phy_poll_ack(imx6_pcie, 0);
@@ -180,7 +180,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 		return ret;
 
 	/* assert Read signal */
-	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
+	phy_ctl = PCIE_PHY_CTRL_RD;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -208,11 +208,11 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 	if (ret)
 		return ret;
 
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* capture data */
-	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
+	var |= PCIE_PHY_CTRL_CAP_DAT;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -220,7 +220,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* deassert cap data */
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
@@ -229,7 +229,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* assert wr signal */
-	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
+	var = PCIE_PHY_CTRL_WR;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack */
@@ -238,7 +238,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* deassert wr signal */
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
