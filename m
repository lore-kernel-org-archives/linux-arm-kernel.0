Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CF6C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:16:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527EE20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ccsG9lbL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpRe5Kqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527EE20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QiFJAXUIgp1JaRkR47k/VQmAPvKxdt0yF9Zs9mo2JzU=; b=ccsG9lbLCVipn9
	s4jeGv5tMyDKvBE1ck0msK2CcHSAh4Oe8xhvP+KXtQs0jfQOZFFz2qYbr9PMcqI5FY5JMuvsecJNw
	K1lXE0Xf/DXrfCmJbEzt6rL4tvuSq9hYL0imanoPEznNII7DOyFBoU+mdTaNifkqfuhfI9VII/aMF
	vKHRWZATHhXXJWfG5NM9qLZu+VeYspM75EhF4v14haFKnvbnPRYzw3ndk+C0mA7ShyeCJOo0ej7zj
	m80a89iDgZrVLLmSMFmj6kjKRLfmVOliXqZi3XvlGatMsHwEZvWdZ/LhSnzqogNZDapcswX2a6Q4f
	R1yMtOEwyRfqFDkrkv4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpiyt-0002Fj-L8; Sat, 02 Feb 2019 00:16:23 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpiyC-0001UI-GW
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 00:15:42 +0000
Received: by mail-pg1-x543.google.com with SMTP id d72so3679200pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 16:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yd2+XR0UA7pRXNwABMnDIgYdZjl0Ef+YMaD3CGi30fw=;
 b=QpRe5KqqiD85JDv27e4U53jb/4XchwvvgEezZfwQAoKV2ZeatiFmCrOEgBmIAu9XnY
 2TYEHB9KGZQEhV72QR4C5/UnSovwFwEHa18raZUuO0/L+jPHEOLNj2OOCYdISv+rGJYh
 xhWYfg5trel7TlWLKMovEU69hPZvGUAJJIxZqaL/SjFe2nTPilg3o7WJ82Lcx7rYjpFt
 v1sOk7c4GFCFajLMssrYLgv/+UCk1R16xQItZT5YyCXhEDzh5CQc7v9PZD1vEUQzbHyt
 3F7vW103YP97IQ8G8DLbPeSadMqNtq46wRdYTogXExdzM5QK1h1JZLEeWeVay7W89CkB
 Ox2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yd2+XR0UA7pRXNwABMnDIgYdZjl0Ef+YMaD3CGi30fw=;
 b=YbQ8FCHOYOI+Cu7pC640+l8AMvQSwKz/+Ol7OGPVfYD/qNRDTwMcfiuDRd0ZIdWuZQ
 kQRT+1rCeQk5MfCdJg01IxvCf7912FpH5QO18xvtOUZEc+gJTxikH0skakVBuIusvuJe
 dDjzWtW1vpBtyS7lWIb4nOxeCGF6mNim04DUCBgKdg2lSKqetTAL55aBF4Zrek2/MLAR
 1w+L+a0ObQ1DwOZ+ZmVJfFcIozck/rWVeOzbdwKDT3c7PQrsc4mbngTsi3y0YD54BIDz
 7oJ78HAGhRjBGYLdUf4XKgiKHTMZ3/TG8U1M8vnxEk7g+3l3wv6vuVFvqpTc0jtPC4cH
 JHiA==
X-Gm-Message-State: AHQUAuYYpiOLc0deQFT5cDlQOuV8fvZbTP+aNWMrszivtWv9iS1FSAi2
 l3cnS2Cm7s9y2i7X2iURC+I=
X-Google-Smtp-Source: AHgI3Ialmns9vf81P5vAzECyruePRiN7VmO1ORw9BhKVifPxgaRTc7BbAtwe5QHFhHliNwHdy6KwGA==
X-Received: by 2002:a63:5455:: with SMTP id e21mr4439654pgm.316.1549066539641; 
 Fri, 01 Feb 2019 16:15:39 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id w6sm28374545pga.72.2019.02.01.16.15.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 16:15:38 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v7 3/4] PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to
 use a flag
Date: Fri,  1 Feb 2019 16:15:22 -0800
Message-Id: <20190202001523.12517-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202001523.12517-1-andrew.smirnov@gmail.com>
References: <20190202001523.12517-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_161540_795204_7E33977F 
X-CRM114-Status: GOOD (  14.44  )
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

Both i.MX7D and i.MX8MQ have the same behaviour when it comes to
clearing DIRECT_SPEED_CHANGE bit when no speed change occur. To
account for that change the code handling that to use a generic flag
instead of checking IP block variant.

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
 drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 26e1e974b0dd..11b73d733dae 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -42,6 +42,7 @@ enum imx6_pcie_variants {
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
+#define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
@@ -710,7 +711,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		tmp |= PORT_LOGIC_SPEED_CHANGE;
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
-		if (imx6_pcie->drvdata->variant != IMX7D) {
+		if (imx6_pcie->drvdata->flags &
+		    IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE) {
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -1099,15 +1101,18 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
