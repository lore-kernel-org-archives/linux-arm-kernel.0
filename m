Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFE6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:33:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABF821903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QIMQvHc7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj97J01v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABF821903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l9SRFawJzShKm9eFAtXKs2LGqEZt31DOxEQGUg/wi0Y=; b=QIMQvHc7aU/quv
	kbgbwcTSKck199QLV/wRgAGM1wgBdUHj+gbDvievtW5MuuPieaF28ZJqFT/+tBmRv8vmF+Eg0cFaa
	mD4yf86vm0DtCWyQiUnmBhlJCCSP4dh/6m8x8s9rF52dQeoxTGTKG+l8/AESv1QhNTE0yqF9W+xUM
	Bfkqi/XmLbwEA/R7D7eya0nMq4rzdXpOqWDCwFRe/pz+tD87QHhg0o9/qhAM1xFnemRAoHsIgd7El
	MNwd5K/NpORBo2iYEqvBTv5MO9ZpboFh+6iX7N39+gIFBG1DlvAqazgaqm01PfX5RFQqQu8nN8B9R
	GWECVc9nCE62mN7nkNLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFIt-0007Xo-E5; Fri, 21 Dec 2018 07:33:03 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFEM-0001zw-Am
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:32 +0000
Received: by mail-pl1-x641.google.com with SMTP id e5so2112214plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=os5HCIWWSeiXp86kNFBUOm5Js1nl9fgasgDsX5LPT/Y=;
 b=Kj97J01vYaRO2Tsth4vmAsL09eUm8ZfT+Y1IlvimyYHPKsSNx4cwmrtBkpYQB/pyrY
 L2QtTUlnNmLrAX6TAqZr6yne1yTCd7kLgANDnmAiDbBQ+jDHoohFzgZOxUlnDHv54PDr
 p/0c8okKY+ylW2UNiyjZoYDn0AP/jOhvFNzjPn5SlLTkBMhpXeuShdh29XLKsxy2//6M
 x2UDRXm0qvBnzH1AQz5M7CD4goUCjur5DPjsL2jX1PMz9RAxheMINSdKvTaZpiUJOT3E
 0jBzNJMp0nMuxAbU6/aBF4PL85YI9mSyYL39bKCxPVSI4Th1puQCwHYDr5+7U9jYU7CT
 KdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=os5HCIWWSeiXp86kNFBUOm5Js1nl9fgasgDsX5LPT/Y=;
 b=VxHLjiSfWzszIwndmvXQNwyr4oeeooVsHFyjTqHGmvLfQLtX4ZsZPB1WUzuaqilBLc
 8AUnfWZtK8LffmN1sEioi2s7hA57VmYsk+NwGrHT4rZo5L/RioG3qLksUQbMCYnHIROX
 /u7yJ7vIDiEokm0jvUdwykIAyo3qoNvbzxY40NZ4YRXPfZyDMCO4rbFQ6GsjVOaay4LC
 aC/Kyo47C9ZXmnkGpAwdSzmbXD4XkNw5Wp09mfW6D/JlF5iC5KsYagvb14KfnrF6HmeL
 n5rrIgsiK4Wu6/KHsIPJw/nHhqL6GlBHFPAh2VA74AO7WjIvrnq0vbacSYHynrPeQ2lv
 DyCg==
X-Gm-Message-State: AJcUukceb1Z4o7q8712HaHgUEwTxAK7xcOzfNKwdcy23aOlEtJvYky1w
 uFb2ZDvygLxX5qeV4bgLo8I=
X-Google-Smtp-Source: ALg8bN4z4ZU5nz72DBY5q8YOvRp5wW78zQBbybW7pRGQW2hcy8aJw7wfTvss0oEMNvtfTdMs0MWtMQ==
X-Received: by 2002:a17:902:d697:: with SMTP id
 v23mr1388203ply.261.1545377291783; 
 Thu, 20 Dec 2018 23:28:11 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:28:10 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 17/21] PCI: imx6: Use common mask in imx6_pcie_reset_phy()
Date: Thu, 20 Dec 2018 23:27:12 -0800
Message-Id: <20181221072716.29017-18-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232823_307820_7BECFDDE 
X-CRM114-Status: GOOD (  11.40  )
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
index bade9d608605..38c8e8baa077 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -230,18 +230,18 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
+	const u16 mask = PHY_RX_OVRD_IN_LO_RX_DATA_EN |
+			 PHY_RX_OVRD_IN_LO_RX_PLL_EN;
 	u16 tmp;
 
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
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
