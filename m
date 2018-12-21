Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3780C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:31:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C2B21903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k5Y4Ay/Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqnJTIu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C2B21903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MI3n7pKkq+NQ68Zo3MiiavGaaxfD6Z6fQE+wDxuFBjY=; b=k5Y4Ay/YAykwAN
	uHqFxMCvTxJ1WNB3v7geSkGzpkm2q8e+2/xuJi/pWap7Sqz2oolGyay1wFWWc6UF5Bwb24JyGO0oB
	YS/jsf8QRO/PskFQjhmkJ6HJiJkOp3UrWR+JkV7QC9kQF6uc6eGI5IWSXSnq0v300AutdQzOI22MN
	XOyD9RP1HsJfrnU+xTjsCwruvPo92Q09sdGjtKCC1wJXoON0HGtUT3AmBewIBTOKygRV5q3vXxgcW
	6Dcy+YzSUTzmutwe3f22ef3ihS6s/TCDxzpwJm+xiaCeHAc0PQF2i2Ph9bN9iF+zmGaLvrCL7RaE5
	mYjM7UEbuWh02Mwb3nqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFHV-0006UC-6J; Fri, 21 Dec 2018 07:31:37 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFEG-0001uv-2M
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:18 +0000
Received: by mail-pf1-x444.google.com with SMTP id u6so2172181pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aOG8CavLyhRq8sCBntFikyTFeErNCHKkbYlORQ4DvNg=;
 b=TqnJTIu8I0HdwEONz46eJlxXRn76Mr445orVTvClpARztJpH9rMAlTuv7nejWztxyn
 DuMPpfio0T351PMzmI+JIDxpUqJsiWPVC/QDukseBDLsA7uJY4y9LSMuF/IMeZ79aT0U
 lQXDVgEfsi3IRrmrokm3pzsC4PeiIGKamsMv4usncYvREexnQavMulx6JA1tol6q/3Fi
 jh433KJiMmH7h7fqz1mg6ep0gl2nVGYJywEucavYIlLpYn8UlM05roCmyguNr/4l1DWB
 y8ml5bt790P5FCicXFp41bFm9uhRBD1+oSpE7Tn6x938/gVurnxl77erxV+Yc4kW8Cce
 Ce+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aOG8CavLyhRq8sCBntFikyTFeErNCHKkbYlORQ4DvNg=;
 b=fI60bsVCzSHkWiGurrLXL0rzcpWcijb8qY89CdCGbKiKN0Huwiqmijb751KfkevBoA
 4L51TYWOOvbOPJw2f5oRjAZfC3irbrlhVArnhBrUzEg60Lg+3im+mUU6UGP2V4z8AsF6
 cx/8MbkIIYZttTnY8oCqgQQQ/0hkrL89Pzq91vky6cgPf6uynrs6nJGW6cpqf0UmCbnj
 d0patoIJlAekUawl7C5UJPXaIZ75lkB0xb7mVfjBKLs+1gbvdckiRGAiT9Ii5ZSrpekc
 UC+h7VL+WAzQtIVkUacproE+8qcYNHQNCCiQVLh0A7/4nKqiYI9t+ckGp0rDcT+zFisT
 q3Yg==
X-Gm-Message-State: AJcUukfahFujcbHCol9jDAouq5fJS8m82810cPgpLQ8W7oi3KkYVjkNi
 ArW6ncnqMa1PmXTKFhIQ+xo=
X-Google-Smtp-Source: ALg8bN7yhNSbFck0nnNIRDg47AJKYuZqq6R/Ffo/4KF2NT1W+iFq6lGG7eFQhBRw7NMV971VW8LGHg==
X-Received: by 2002:a63:4002:: with SMTP id n2mr1316312pga.137.1545377285389; 
 Thu, 20 Dec 2018 23:28:05 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:28:04 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 14/21] PCI: imx6: Simplify pcie_phy_poll_ack()
Date: Thu, 20 Dec 2018 23:27:09 -0800
Message-Id: <20181221072716.29017-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232816_268305_82E71242 
X-CRM114-Status: GOOD (  14.12  )
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

Simplify pcie_phy_poll_ack() by incorporating shifting into constant
definition and convert the code to use 'bool'. No functional change
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
 drivers/pci/controller/dwc/pci-imx6.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 40d348bb9a2b..ddab1859a07e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -91,7 +91,7 @@ struct imx6_pcie {
 #define PCIE_PHY_CTRL_RD		BIT(19)
 
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
-#define PCIE_PHY_STAT_ACK_LOC 16
+#define PCIE_PHY_STAT_ACK		BIT(16)
 
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
@@ -108,16 +108,16 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
-static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
+static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	u32 val;
+	bool val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
 
 	do {
-		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
-		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
+		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT) &
+			PCIE_PHY_STAT_ACK;
 		wait_counter++;
 
 		if (val == exp_val)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
