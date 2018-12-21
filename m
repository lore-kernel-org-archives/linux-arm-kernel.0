Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EDDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:31:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A53A21903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J0YVIXB7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0FQH0vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A53A21903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s2LirQrWaEc490S+4Jkq/2bt1UFb/VklnwZ+KN9lwOw=; b=J0YVIXB7WGEmGh
	OOMPeTB9C0iFIORHoHO6Kke15uI/27Ui46x8gX5+1ADuHc08HqQRjtrKervrrBNaH7o+v5q0M8AxF
	UHrfY91E+CqfHYKfjhBSxzGkYmVcHZnyS3U8+V+nsqZmksNh1c6VgRXBieZLkkWYQDmYeU41Yu8Wh
	5C6MiBbRqbrVo2NfwXF9el7ZnQAWgZwNevwS9e0kwZlNkn5Xk5gykI9hO//J7Mi6eOBMfl0D02Msz
	eAPRfqEKudkHCQfFcWFMIPWNRSTNjDHvvRdo8UFH0C+/tXkLA7ujN4IVvnJJHEHSxR4lTEPiOWrFQ
	PXIqePzlnF08pe2+vmBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFHD-0006F0-Uf; Fri, 21 Dec 2018 07:31:19 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFEA-0001yi-4m
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:12 +0000
Received: by mail-pl1-x643.google.com with SMTP id e5so2112156plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t+Ph+iIWzFZpNu9UO0nka2W/68YLTAo65CCi/cOl030=;
 b=j0FQH0vp+t6h9imxvu+6dBbyxK3d4Ipy5RIH8JbEGIqHCo8P81v3vgw2YU2UpunsOS
 Fo+msqpMgIKuVOXKJJg0M4q2lLh7vdIJj0mx4eF4scSJAYpEotocf4aVc5Eojw53LC/Z
 mAsKiH3OGVkJ6vc90Wnz50ZWgMB5ZowlpGOVmoiqKORVay+S9L/F3PZ3/Ks+Ih9kg0Hb
 gkDFAafLkxizxQyd/zjfmOTpxkaTGxlmLuZTJ52QBwkfxcxNcH2udLXl0ZhWZDlBA3yx
 hyCQICAPgGHyPVo8JDKxgDjxv8/jDulwG+a2jXSbC76KGqfUeVZ/c0og3vuQcqRF6gjM
 ZgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t+Ph+iIWzFZpNu9UO0nka2W/68YLTAo65CCi/cOl030=;
 b=FxtXN9D8a2dWtEx/A8otGy9IKc+7GScZMS5BvZIP/QU5dYjiObjPAr998nwTbCep2+
 OzjutBUuNHW3JJg+9XLvxGXjifiVNaTjujLwEA6453hAuljJtW3pM3nWref7SfwoQ5KE
 Kq32/b4iGu8vaOGhU0Kf+StUfN3lt3xQSZWZoLIPTNgBB1t3qyI+ECLjC4OwkcBrrzam
 Ig+rCumBj7jdjY/f3SLjpDMwzWEyg8NQ1xC6cBEuD2rhE51xiXPArJmPNg8FImt/z7Kw
 3Vkpm/Smgr+opEgtvAJ9sfWun9P81dsE+Wq0vH7k+aRx6zuBlpF8g2VoQzU55mm3lhls
 Y55g==
X-Gm-Message-State: AJcUukfbSOqL3oDHaVgKFvLk6SsVfgPtOa6iIdijAKj9RaZvWtydJ0Uh
 lyC3Ilxq5+LZhu4XCc8NaBI=
X-Google-Smtp-Source: ALg8bN71+thEST0OsUXu3TFyPC+dUURS3WkuHuuBEe7LNF1pOVQoxUDkkNhtWIxNF1diH4o8CzIqag==
X-Received: by 2002:a17:902:8641:: with SMTP id
 y1mr1406449plt.159.1545377289324; 
 Thu, 20 Dec 2018 23:28:09 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:28:08 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 16/21] PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
Date: Thu, 20 Dec 2018 23:27:11 -0800
Message-Id: <20181221072716.29017-17-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232810_234469_450572AB 
X-CRM114-Status: GOOD (  12.47  )
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

Save a couple of lines of code by dropping assignement to 'var' and
passing constants as via function arguments directly. No functional
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
 drivers/pci/controller/dwc/pci-imx6.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 98e3730e75fa..bade9d608605 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -155,7 +155,6 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	u32 phy_ctl;
 	int ret;
 
 	ret = pcie_phy_wait_ack(imx6_pcie, addr);
@@ -163,8 +162,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 		return ret;
 
 	/* assert Read signal */
-	phy_ctl = PCIE_PHY_CTRL_RD;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_RD);
 
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
 	if (ret)
@@ -202,8 +200,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* deassert cap data */
-	var = PCIE_PHY_CTRL_DATA(data);
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_DATA(data));
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
@@ -211,8 +208,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* assert wr signal */
-	var = PCIE_PHY_CTRL_WR;
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_WR);
 
 	/* wait for ack */
 	ret = pcie_phy_poll_ack(imx6_pcie, 1);
@@ -220,8 +216,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 		return ret;
 
 	/* deassert wr signal */
-	var = PCIE_PHY_CTRL_DATA(data);
-	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, PCIE_PHY_CTRL_DATA(data));
 
 	/* wait for ack de-assertion */
 	ret = pcie_phy_poll_ack(imx6_pcie, 0);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
