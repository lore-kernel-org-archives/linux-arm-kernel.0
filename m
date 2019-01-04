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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95669C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C3221872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EjwVkE4j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxuskCBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C3221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1MoU0yc3JGcc7c0bc3AAsTR9HbQndRKwmApdToAmDx0=; b=EjwVkE4jzOKsLR
	ZlhWIciiKMAhrom6l/hWPHqy5qhKYPnzRg3pxMyg0q59AQc5q57/a8Aextr2D0dA+J87OBkDFKBDZ
	8f4O3UkNoUE62lEC6kpMN73yZQswVgKCyAy35LiHR6GD2yQM4LzvdrnoZuvrlk8CS/FGF2c3eP+6W
	sClhKljrI4MeLLdMr+DTxasEdV9Jm0nXp1dwIK+//WK0xA4Dd2VE/lpN5ljGjyLpMfYMok1mdkD2N
	UHh7OvJgXigUM6Jr2tPOagChPqT57VL7Y6nxeRM3s1Abixc11Z7iKf0NUjB2rynPzYyzmkMxkl27y
	WNG0bAtoYszwPJcq2TPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTc7-00065j-Ts; Fri, 04 Jan 2019 17:50:31 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbM-00044D-9S
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:49:49 +0000
Received: by mail-pf1-x443.google.com with SMTP id 64so18619449pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qGsfwtEO4Mu6yENA4Q+2w4zzaj5XitiKPr8jlGDyGeo=;
 b=YxuskCBM45AXemDIJ2J/t1aM4U212J7AUmDeYvPZaIXjSGh9cy7GbOd7yfKc/NYuHh
 t9oivhxz5ZRzufDm1+dfzLGwj1nYYbWBk29iZbo+1TJU/DHUDlzRFzmRIolbi6ntWDan
 WOfcXmgxq7YT/zJqs4TIYnUv4H5sYKi8o1PeBu/L8OslxCZ/fXzvjWOB0vZcPNHIzr6A
 TjOZP25L4PpmSj5aqL6oeX3sPBmmZ7ZEQawAdNw7NTiJKME9qVsyOoy93Hf4JBiWoV+p
 VT9PnQR00RzoWy/fQFhVVMKIX4P035yXvE2SeLImzJ3lyXeI+xdpGko1hh0VKJRqnvtC
 uPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qGsfwtEO4Mu6yENA4Q+2w4zzaj5XitiKPr8jlGDyGeo=;
 b=SO7nrx4Rg7lkDE/JUwQFYpvfwTrgsUx2UinyBHtaddGH8O6mCy7wo7sWEz0mSgKubI
 MeEpDIjegXZtMygQkJOOwlkGxib77angDHlZVrOqkT77J+uQDYmtBvHpGU8KSaQ+AIzz
 83Hri2C0AhYCI2dLEcd8tuYMEdFT+710/UvO8wqKKkzkTXrA6lu+pkDRiWM8JFuH+RiP
 dhmnWm9mGtWRlwO9je5/+wvRyy3ObgvKCS2vp4E3/dhjICuOv62KLMp9TAWKXFoPlky9
 lB0erR0+dEsMnYHcOD8f9TpGkR8PFBapKofhxel5RuSiiIrJ+dZYLhI4ng3w4wdFmhYi
 kZRQ==
X-Gm-Message-State: AJcUukfmDm73llgqqmi3PduslrSaymanjPfihBEhK5/v7RiBHJK3RztQ
 vdbV/L0rx49lcuet/DfVmPs=
X-Google-Smtp-Source: ALg8bN4hDTKnyz/RSy+cC/+oLPKwkfJ8lmWA+5xUtKcgLiApBqTMtrA3ryaQxQYLrzSgPDJfaCpfPg==
X-Received: by 2002:a63:d5e:: with SMTP id 30mr2431937pgn.54.1546624183460;
 Fri, 04 Jan 2019 09:49:43 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:49:42 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 02/20] PCI: imx6: Remove redundant debug tracing
Date: Fri,  4 Jan 2019 09:49:07 -0800
Message-Id: <20190104174925.17153-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_094944_595662_AA8CF361 
X-CRM114-Status: GOOD (  12.68  )
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

All calls to imx6_pcie_wait_for_link() share the same error path and
the state of PHY debug registers will already be printed there.

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
 drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c73c7a6a4c55..491a93a02c80 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -677,16 +677,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	struct device *dev = pci->dev;
 
 	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pci))
-		return 0;
-
-	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
-	return -ETIMEDOUT;
+	return dw_pcie_wait_for_link(pci);
 }
 
 static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
