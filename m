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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649C4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:07:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C55218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OWfoXMap";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u+UpNPMI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEoo1a/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C55218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xdlpOcWFIYKPokEbmiC7jyBTluftCQ3TaZiiHEC5kXQ=; b=OWfoXMap4RVs5T
	KgT12fBQDRyuX68ph/gawWqi1hLDhox9/oIPHKDUj8gyEfOCvFNmM7y2AOL0MrtarbCM/wXr7xbBZ
	lQSX08sabKAd4FQwp/mXDxLR/jFX5QUMlDfvDzFowV8kXYJhu1GVI4rws7r5XHjcKuXQ9gi5+JOiB
	wqXnJyb1UNATf/BXXs6kEMn+q9n/DJQPWn8RNt5XbP7YQTkjCmdMo3UyDWZJ+z08AUdzEALMErz1b
	SGpyZzVQqdgl+vlNhGXRoAadsqaoDVii1VsPkiS+dBYZn0qiDXmRvLOLrwFMHqYHwbnqyUDmbsDo7
	//ET6UeQs000WkGiMV5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTsB-00030N-6C; Fri, 04 Jan 2019 18:07:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTs1-0002Vg-OG
 for linux-arm-kernel@bombadil.infradead.org; Fri, 04 Jan 2019 18:06:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wgbDW5dpUQt98rEUFIyBYJEI6ndB9gcDqUzY7mel/6s=; b=u+UpNPMITZLG2P9ldkG9FyU1+s
 zUnZ9IqUsZEDsL5LYWMNOA3rupK7i3l+kaEpn1H7TESxckYkWxYs5ZbrUcXDD/2r0/ys//4fBgNfM
 W+fl82dMH1HfE6Aw/46lWMPaBriwlTmT0U/ZlX27ky3c2UA7rxw5SYLZ9UKIbj8wqIn/wCvON1IDN
 Ku40gzwBa/cAJeK6eEVIt8/N1le32aSmjdvpyZlgUUFuPG2p2APD26SlBeYslN/IaLVGdcKqlsEn3
 smgHHUuXn7NChQQUT+7bf82R81YlL9tIhkRN4QjR3GA01Q4oq0laYkQ617e6GKPm1tiF1rfYKfcUm
 sn2s3S9w==;
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbp-0004UK-H3
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:15 +0000
Received: by mail-pl1-x644.google.com with SMTP id 101so17734000pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wgbDW5dpUQt98rEUFIyBYJEI6ndB9gcDqUzY7mel/6s=;
 b=iEoo1a/OKkKJZtfMoSTJBNRwLRmxHYiy5BELr0ZahkEJGPUnWHwAwbGSGWVnA2K3N8
 DWThaSV1BEmfcBxiAl1ghAgv91foOjqkSX4pMTvTNUCjzCLNrdOz1weDJPulXHqesjzh
 eo5y6w4t7zvPtU5sktiCfCu1pXpsRxMjWppuO9SHLgmgKT9gXL2SX8Wfj6adxuE+Rugt
 GNg31n1h4+XGXfq7q7scRS3JKuR0gATy2gkluOWZDDgVBnj+gkDP79Tcl6mcoJ0SV7QR
 2uJGVeXBm/wDHSiTwgvW5dPiDfSObElXccqjn1ADPmRyVU/oijZ3B9efIS2HA31eCYsK
 FvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wgbDW5dpUQt98rEUFIyBYJEI6ndB9gcDqUzY7mel/6s=;
 b=YXv4EkWG2QQtDX6OgI+MhHHS6Ni3uctPY0dYzkNj19OqhDawT1mgNkmSP/okheqHXl
 1zjNJymLxz+N8ua4sX5ysIMVGvWYQeWUDGV1OnGpPGCz4ojxzRctmwGk4fsJOzUCVwJA
 Kgi7iQQJvW2ghhpEA99PkMPoaQQpAFgr0wSPzDo/UaP0xuHMs4hrjPMCTrDDOWh/Qe+W
 lo+VMwsyVc/Yx1iyyGdHshGZCzLIxfYqusmdFMrRp6CrEOQI7QKKdIgvyY4z5bo7Npiq
 5vG3ttadA49NVZqio0bYMIGaiyBhZ6haQGTLdYFkeIPSOxgCCnXeAfiuyVR8tBgyka8/
 MJCw==
X-Gm-Message-State: AJcUukddL0i9WwCmMkyTZJu4YBtLjM2i4E9rYYTn7HJrlOs/s+6AAG27
 VJFxauUcT0ypOr7TwYL+rj0=
X-Google-Smtp-Source: ALg8bN7DWXymiFDJPJKMM8BjkzXwfxTzSSAkZlFhar78VPcv/On4+5l+ipcw6E2WWjhb9eRrCzZmFw==
X-Received: by 2002:a17:902:2a66:: with SMTP id
 i93mr50874325plb.113.1546624211721; 
 Fri, 04 Jan 2019 09:50:11 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:50:11 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 16/20] PCI: imx6: Use common mask in imx6_pcie_reset_phy()
Date: Fri,  4 Jan 2019 09:49:21 -0800
Message-Id: <20190104174925.17153-17-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_175013_597046_F6834530 
X-CRM114-Status: GOOD (  12.31  )
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

Simplify imx6_pcie_reset_phy() by using common mask. No functional
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
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index befbc09c9c41..130f577670c8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -247,21 +247,21 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
+	const u16 mask = PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+			 PHY_RX_OVRD_IN_LO_RX_PLL_EN;
 	u16 tmp;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return;
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
-	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
-		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	tmp |= mask;
 	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 
 	usleep_range(2000, 3000);
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
-	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
-		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	tmp &= ~mask;
 	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
