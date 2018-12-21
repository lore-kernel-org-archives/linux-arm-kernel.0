Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3E5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:33:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4526D21903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KTV+PoLU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laDZnjBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4526D21903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mEgfYfuB36G6HXpjSYC3E2Rsp+ecQgGhLTCfxGWa80s=; b=KTV+PoLUn1nUHp
	rvlrmAkoMPP/dw7jrkGpi7Lqjz7JITlpcJM1WogOVyuQVRhHmB0jEbtpp42y7EhZ5ufZjhmH0jx3/
	+slqXC87v+hGCIdOqK0x0Wr60DQZMGJWJqQpCplYSJW8miFvC2wlWWySagyinAPHkYTDwK6vXEq0t
	McxhsAl1G1Pn+eYSst6+d5+AIeNRPKIidMD413iTelAVHic6ofsL5BqusTF4QR/v54beLkPdKGhfs
	TRtIPUvj1MRtOV/dl2ErJTVipl+F8xBk6oKuUg1RPBX8W5GG9EtiMCU7cspTf0EyYBpvVlVCWEKj6
	1kRLiOg9fmtnHnyxWrDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFJS-0008DY-Bi; Fri, 21 Dec 2018 07:33:38 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFEE-0001sc-3f
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:17 +0000
Received: by mail-pl1-x644.google.com with SMTP id b5so2109972plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UyXZTOk3menKB/t8eFutGA3nZkIu5JphmYQKvkOh16M=;
 b=laDZnjBh2J4T2ev7D1FV58fMa8r4adUyojMiRp0SJ3Ugh4ByRxvLrmgvzHWUCdP+kD
 mD1gRJiYoLmAzhMcwt6Q03hCiDyV/qW96AZlDDhpVhRpxnYMxqgeOaLX2YNB6cy7qX68
 TTyAMHhlheu060Br6rSsPccyVgh4nLgyxU+xuxZqZ6hK2K8gZF1+iDulI9qnGsijAPtc
 R3Kj+rEsW9PcLgh37LiM+kb4hIGUMf3UV/Z7Syw5lXYdcWXDd37/St4InI+jAILu/ILP
 xUr9TB+GWOCaW7gUoK+wvKBT7IM/zWRDjzTY+gxVpGwsYWRd+PKrKVAgvDdJPGgs3eIB
 Tekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UyXZTOk3menKB/t8eFutGA3nZkIu5JphmYQKvkOh16M=;
 b=kyzuYNGwM8puhck2Wc5VV33ACJw9nJqcUXXuztrgW2JW119b6v6GopxjwNITlGqd0x
 wLh0AbSA1rDUZ5F6mAWjQlwn35//pHkgu/eLSkByuKlsBhjQEzvToCdHnDhhx03gTNLR
 HTJonwRsXFPUhU32gLycjM8ePS7NIxPdJWSEMkH0fH5NaVoAPWQfBUUgVH8nx19b5jyQ
 hr4E5ob56JuXf+a4QPRIQFW3On6EHmkXUVZL/YF+HfUesymkBuqhAPf4bfRhszgO2plR
 J8ixD0r/p7SU8UHAsrfYcIRn/6Gi5gHmx5/QfsJeLXD4RqrZy+WJpp7I5gsBQvV0iqg3
 Agbg==
X-Gm-Message-State: AJcUukfxp3wdLx0ZzImKpurbfzfP8eNHlr9Z6gYC9C0C6eYfd5ymqY41
 7q8a39B8QocJcuLyh38hlrQ=
X-Google-Smtp-Source: ALg8bN4woDopvm84fXXLBZIgM5gLLHjUS68sG/W844AnAlmgZsycDcfGBv5dKNpXSO98w/5WbH1sbA==
X-Received: by 2002:a17:902:e002:: with SMTP id
 ca2mr1438205plb.103.1545377283510; 
 Thu, 20 Dec 2018 23:28:03 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:28:02 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 13/21] PCI: imx6: Simplify bit operations in PHY functions
Date: Thu, 20 Dec 2018 23:27:08 -0800
Message-Id: <20181221072716.29017-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232814_596601_28AD8475 
X-CRM114-Status: GOOD (  12.05  )
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
index 2737526158fa..40d348bb9a2b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -84,11 +84,11 @@ struct imx6_pcie {
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
@@ -135,17 +135,17 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
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
@@ -163,7 +163,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
 		return ret;
 
 	/* assert Read signal */
-	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
+	phy_ctl = PCIE_PHY_CTRL_RD;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -191,11 +191,11 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
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
@@ -203,7 +203,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* deassert cap data */
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
@@ -212,7 +212,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* assert wr signal */
-	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
+	var = PCIE_PHY_CTRL_WR;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack */
@@ -221,7 +221,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 		return ret;
 
 	/* deassert wr signal */
-	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	var = PCIE_PHY_CTRL_DATA(data);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
