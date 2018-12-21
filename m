Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92820C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:34:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4450421903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bF8TTwdU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIAPuSL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4450421903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6ELSefv5b/3PVIJMth/ImaZqsvB3ACTmH7WZYPWZ8Z0=; b=bF8TTwdU5d7kAo
	S+5PoW1kB1Tf1d/f+P/C7dkWsKs5gLeSrBde/yBPSWJNkdzokpXLKgdTwqX2dD97ld7kh7bRh5spc
	c1h2HAuNx9V/VsrrxDacKl2a3bwyzy8n57UEP4g3zwifeklq5NoZlUdGRM0OfZuOSjvxZvs6ZTEt1
	g9s3acJT9EzjDKFyKmnsmkTFCgSEeyoTIJBYYNIqxUUvXZvX7mWsW/BVIfGPzsGW/a7Q/3qOMpPgo
	RNpTWXUo0cDHv8+677agTv5l7Lfr3QRfdzF/m99FaD9yGJbbyNxX2E80CDcJ4Lhudr1fNlCv5bJP5
	mrL9G9IUh3naoDYpD3+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFJu-0000G7-38; Fri, 21 Dec 2018 07:34:06 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFEO-000210-KV
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:31 +0000
Received: by mail-pf1-x443.google.com with SMTP id r136so2180565pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5ARpz9jknH5H4OT3/qhVId8qmQoNOpINqmDP2FaaZjU=;
 b=NIAPuSL/hJ9VQhEPvORXCppBEwzMPcpOj+Yz1GdpGMptpcWx6R/lfmtmqP52n7x6NE
 Y/jNRWGJhUvcF0oks69JriSQNc4Q6xDTQT6Fjn/VsLFiL+sYTznDXO4g4p27zWTzfudR
 ItnCJqyGMARxqtTyEOSOVdi4pfnje11fMcLawX3vBpuKhfQBlIbmSlcrW/RXPD0xdapR
 I5oFZvehmIFXXCyOFEpl4FbGq7UDdC+bB3/jomelhAUpNK7YMv53b7wV6vsnbMPFqcXJ
 tUM0upyMAiRySpzkZeTtBu6ngv7iKvq5euUG9Fg9pEOWWVtvYw+OGcak7W6Ln9Nhtu2g
 C3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5ARpz9jknH5H4OT3/qhVId8qmQoNOpINqmDP2FaaZjU=;
 b=Tdgm7PWlu32OcM7kolNiDIPzfsXpluA1TvddmPwOJfpyawVwMwsK3mcPbKitPKpvZ7
 EsqRwEL9Ao2JtCZxHRvA3hcj+PJ+qkcsSvva6w7o+DKA8THJ7WJgt/EEN1J0dPckdWdc
 LtTEwA1CUnykN5TGyolEXfmSXNb0HW8vCHfXIO3E50+RQ9bWq7Nm3+IQk/+OND7NeQzy
 IBGw4U4X8HR0rRKgJZaS3OPk7ggQut+oS9v6jZDkCzwgCyjWgw9o2k6SaSP8TOurHz17
 8D0/P2wFoVoiVPBsz1XwC2LVFNQocEWTsoOpfMbz5NMIeCq1s7hm7i2df6c2qNnIVrJu
 4v4w==
X-Gm-Message-State: AA+aEWagDPn79wPRMFSf5mKbbEzQucJWFX4/ekb9qHIAx9Hz69wpAjBM
 Epfsp+6wvbIwEK9N3+fRjMq4tVUs
X-Google-Smtp-Source: AFSGD/WHbfSdl51UrygLkZMS8SUXS+WuEQRRNZr7+xB+nhOhArYgwZi+iDHx+rhFP2zfPhYRg/P9+w==
X-Received: by 2002:a62:35c7:: with SMTP id c190mr1466498pfa.76.1545377293403; 
 Thu, 20 Dec 2018 23:28:13 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:28:12 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 18/21] PCI: imx6: Simplify bit operations in
 imx6_setup_phy_mpll()
Date: Thu, 20 Dec 2018 23:27:13 -0800
Message-Id: <20181221072716.29017-19-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232825_425438_B090EB01 
X-CRM114-Status: GOOD (  11.41  )
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

Simplify bit operations in imx6_setup_phy_mpll() by using
GENMASK/FIELD_PREP. No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 38c8e8baa077..678f5fa85e12 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -96,12 +96,10 @@ struct imx6_pcie {
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
 #define  PCIE_PHY_ATEOVRD_EN			BIT(2)
-#define  PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT	0
-#define  PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK	0x1
+#define  PCIE_PHY_ATEOVRD_REF_CLKDIV		BIT(0)
 
 #define PCIE_PHY_MPLL_OVRD_IN_LO		0x11
-#define  PCIE_PHY_MPLL_MULTIPLIER_SHIFT		2
-#define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
+#define  PCIE_PHY_MPLL_MULTIPLIER		GENMASK(8, 2)
 #define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		BIT(9)
 
 #define PHY_RX_OVRD_IN_LO 0x1005
@@ -565,16 +563,14 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	}
 
 	pcie_phy_read(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, &val);
-	val &= ~(PCIE_PHY_MPLL_MULTIPLIER_MASK <<
-		 PCIE_PHY_MPLL_MULTIPLIER_SHIFT);
-	val |= mult << PCIE_PHY_MPLL_MULTIPLIER_SHIFT;
+	val &= ~PCIE_PHY_MPLL_MULTIPLIER;
+	val |= FIELD_PREP(PCIE_PHY_MPLL_MULTIPLIER, mult);
 	val |= PCIE_PHY_MPLL_MULTIPLIER_OVRD;
 	pcie_phy_write(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, val);
 
 	pcie_phy_read(imx6_pcie, PCIE_PHY_ATEOVRD, &val);
-	val &= ~(PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK <<
-		 PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT);
-	val |= div << PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT;
+	val &= ~PCIE_PHY_ATEOVRD_REF_CLKDIV;
+	val |= FIELD_PREP(PCIE_PHY_ATEOVRD_REF_CLKDIV, div);
 	val |= PCIE_PHY_ATEOVRD_EN;
 	pcie_phy_write(imx6_pcie, PCIE_PHY_ATEOVRD, val);
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
