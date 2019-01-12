Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BAAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:57:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28608206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NY/AElwn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kuv7qzIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28608206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3AqDTp1ug2QdfCz6cyWC3YjAPh0qoQejdj9HEYfHAvo=; b=NY/AElwnQiZ18J
	ddzrP4Fcm5WOPFHkhlwsG2b+PW5hNC+W2dSMMhRHB+qZ0jjOUdJR6lgehlBPPNxZr0I3nBNJUjsaD
	5/uZpJe10f/RKBIEkprHqLMIIhXWOYVM7Y/W4eh26CvNOk90gRo7UZ64+tFBx8SzZEKKGCGzAOBdZ
	yxi5ORdZ3NrtBtxLkMHQREvEIKC5pC+tii6bAfI1HEdd/AFcwaU5K83GPzQ/M60f2yf1/pwUMaQch
	NW4KbxqK2Gm0VQGgAeygwo/+ElBAKHmAVhit8bJZ8vK6XDjU+5E+G2dtBF10rcqYgsTRVm7bFIL3f
	O6/afVSbTaILDe69tAIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giRGz-0000Gg-VA; Sat, 12 Jan 2019 21:56:57 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giRGM-00081L-5y
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 21:56:21 +0000
Received: by mail-pl1-x642.google.com with SMTP id y1so8363525plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 13:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=grv6pQHsa4pXAbDoNpvOmMqpK++yv1uYVerEQhWxFvk=;
 b=Kuv7qzIbQhre4OSksQolLwFyYTkHfGpBCjwpwKyM22grwmpKwGFrwvNSYJtVfYAZmw
 P7z5qhzC8wabLAeNVrL44/hyUil5fCvNMuteleFSCGM4s94M0cdnRkACWx4RXDKamiaP
 XW27/YZPCvn4Xar3+1NLvbifrZ0ervs/2Nc0/m0I5uzjlyD6uVsO9aHqb43cfPNUKlzP
 RvdNSXTH0hNcYhm0/sWwbz2erbvk+mE/u0T8Hqr0SjMaHnxlf6UjK7TYrusQZuHPLOAO
 BprsYn37B4JU2lINfIt3vcSbZ7rsXJPmmNF2iPqgqlRlh+N/W47XzZcBDHmujZ8F97Nl
 o7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=grv6pQHsa4pXAbDoNpvOmMqpK++yv1uYVerEQhWxFvk=;
 b=izuLYZ6m/zxtLtiTS2gbJVFP31jzo4xJ65e2LLfKvu3mxLxFH6og+V5bH/wTMYf/ET
 tdBbm7yKhEROXqgwSZhdYy5xdVQ92e6wHOXNGrsiqdbfMDgvAytZnZhORLJd+j9ZaSsx
 YsCP0L9Pt6CLhJK9an/ittT1p8mxeY4Vmsh+Uq65E4z5pGk8BY7fpxhbaDzMFEsCkHMg
 XHhBn7HpVgOHZhsSGNRhu0mOCXIvMPGQXD0Qo6aGWU+c/cc+GtP0saDoFhf2HzCzeHGh
 Jk+1xbs49//oFKqi6BdYOATbSgUbGlJatzL+KlAeEADn1xdJFkM6++xG+A5AADw4UR0O
 CJIQ==
X-Gm-Message-State: AJcUukdmJBqKlii+El8CZSMNnLOIrXnt1B+6kWuHyfnnErQLOoNODGfz
 SIGe1tlFI2aMBlONc6LQEfc=
X-Google-Smtp-Source: ALg8bN5NDmSSPpnsO+0GK//5zOzcbDBvrMWbaTodN+dIu7CJIzd5uMBguzeeFg7iO3p3LpuVM654vQ==
X-Received: by 2002:a17:902:7848:: with SMTP id
 e8mr20361348pln.100.1547330177586; 
 Sat, 12 Jan 2019 13:56:17 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i72sm122284327pfe.181.2019.01.12.13.56.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 13:56:16 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v5 3/4] PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to
 use a flag
Date: Sat, 12 Jan 2019 13:56:00 -0800
Message-Id: <20190112215601.9535-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112215601.9535-1-andrew.smirnov@gmail.com>
References: <20190112215601.9535-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_135618_435011_B74AD327 
X-CRM114-Status: GOOD (  14.22  )
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
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c55d93c1187d..75ee0cd7af3b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -42,6 +42,7 @@ enum imx6_pcie_variants {
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
+#define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
@@ -711,7 +712,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		tmp |= PORT_LOGIC_SPEED_CHANGE;
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
-		if (imx6_pcie->drvdata->variant != IMX7D) {
+		if (imx6_pcie->drvdata->flags &
+		    IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE) {
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -1097,15 +1099,18 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
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
