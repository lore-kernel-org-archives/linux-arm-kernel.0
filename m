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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEDAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:03:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04B9218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ArZmFZdO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZxaW+KgH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMiOwlSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04B9218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZfpqIjkI+meWrSZkyX2BiI/WMimrQonIEy7FSIgKUDY=; b=ArZmFZdOXFNW70
	5vTm3D+nzYn2w1Ru8jCzCfxmv7/6NSPyIPyP9Fe1Md4mh2UK21IPP3414pnVxae643bjBWAo9dMwu
	AjOpOPX8gMcoJ+40cozSIF4/SiohU1C0j4dHD5k0cO0OC4zdusFSCzPqAz083Ls3qhJVU9Wf1RNIB
	VEs17iG+vn8DSEXRR/U/pXrAxMAiLPPnxzZON+hKMWA1Lai/JI5S0JcBw2z8Da0bTdTg/tq9mx6iw
	+uNG+nhsPrSldlwJBf6TpLWrjzQmx17fNTQz13iXnVzoCyK++AO/SsdHODEYE8g6t1poxegwRLeDe
	O22DMjNnReAmgAASaG2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTo9-0000HU-Nm; Fri, 04 Jan 2019 18:02:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbk-0004h5-3C
 for linux-arm-kernel@bombadil.infradead.org; Fri, 04 Jan 2019 17:50:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xAm2jIq52pUhEC2sZCasu0hrDgVXQMY4yfjOEAVqYOg=; b=ZxaW+KgHS5LYpBKJUKNYe89Vv9
 QkVAJ2vwJDwdeZR9mZ7OOJgC1mGtsGHQvi/FJHBvN8mlVM+eQxxioPVY9GynPguCtueAjsag/3YOW
 LlLZ+rBbRN47MnSCG3kmQhxmXonz/5soBJckZxncuScCSiGWogBNyGjfcnqFjA/n3PHWxyjAvJxmf
 95f72Z/BaSb/f0pjGbWIlRW7nOFu3x1layG/0WQe5UnfZ8LzJUFrDaYEt9tDzyzjiXwHAVImx/JGZ
 Cj8U8I4q318hY0HAvTt5uuxOWo5qcOj/P7sEW//3cPxzyVAP3co6l69I+dSdM9qLCjSWZjBkFiha2
 XJmQ2www==;
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbg-0004T1-PM
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:06 +0000
Received: by mail-pg1-x541.google.com with SMTP id m1so17784555pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xAm2jIq52pUhEC2sZCasu0hrDgVXQMY4yfjOEAVqYOg=;
 b=mMiOwlSG4DC/Fg65Au78ypOcmntahyb2RvO65PwPALy3W5u+zIqvl1kRo6cjfSVzAG
 C8XGHCWqRYNl3tZReBRxpTWxJHsgA9FDYpLUwN0j/Sb2anz6hfNVplUdlig/rOvq1SaF
 DcCmtLyUiT4k6779xkqnyIFkUNVCu7DnRqHBi1fUBaON/B59O0FHd3m/jvmUv/E68SEL
 v9xEyegM2PTVmL9v1vujXnMfHAM5HEE7lLrxKov2muITiK3+hjPAO/6FpgjgqgwlND65
 Ap9cV8/YvBH1RqnWF0uaaWTbUE/l/HvA/HVnmvPSIG2LKC+D2RBMU4UOtLoN8om3XTKs
 WYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xAm2jIq52pUhEC2sZCasu0hrDgVXQMY4yfjOEAVqYOg=;
 b=PkWs6A9f1suz5+29qbkZka5kwROVeloIvjAN2Ncyj3BXMmQMGSomrciiTyLkTFTlRL
 TyzlHsqnwMA1+c819J+0gAa58Mi+iSOP3dlMdpKff3kNT7xzNPfqMty+tWSeKhfr1emK
 Pv+2GakX6LIHm/7L9Jrfb9ikxq1cv/ky94VoGhuzMDiHnMNAu6xDP642z2ZwL3cRkN65
 pKlB/zAnQOBNEmOHJyxTeVf1meYkzpI7JbmMUGgibpiyoqJNJ/WXItUDa6cnx2Rcs4uH
 0heoGBmg9BNDWvUs+XEi21pwcXuOaSKxgoENYjNj8g+chRPVUSOA6bZ4dOp7DlfF0+gM
 7bQA==
X-Gm-Message-State: AJcUukfKD8K64rG2l31OtBhkN2Dsn7cHCIXORTij1Bf1rW4bshUfALrk
 SKKUdz1kkugJxfiHa+wvuso=
X-Google-Smtp-Source: AFSGD/U8/aliG21Hl9OPuMY8e2lEDtbWolIemfd93+t+jlOoz3jIbHM1T819Xm5vLncIZ0Lj8YKbXA==
X-Received: by 2002:a62:6f88:: with SMTP id
 k130mr52806398pfc.234.1546624202196; 
 Fri, 04 Jan 2019 09:50:02 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:50:01 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 11/20] PCI: imx6: Make use of BIT() in constant definitions
Date: Fri,  4 Jan 2019 09:49:16 -0800
Message-Id: <20190104174925.17153-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_175004_850211_0F79EBD2 
X-CRM114-Status: GOOD (  12.55  )
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

Avoid using explicit left shifts and convert various definitions to
use BIT() instead. No functional change intended.

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
index 5e7fab089bde..180ba57da4e8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -112,18 +112,18 @@ struct imx6_pcie {
 
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
-#define  PCIE_PHY_ATEOVRD_EN			(0x1 << 2)
+#define  PCIE_PHY_ATEOVRD_EN			BIT(2)
 #define  PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT	0
 #define  PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK	0x1
 
 #define PCIE_PHY_MPLL_OVRD_IN_LO		0x11
 #define  PCIE_PHY_MPLL_MULTIPLIER_SHIFT		2
 #define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
-#define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		(0x1 << 9)
+#define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		BIT(9)
 
 #define PHY_RX_OVRD_IN_LO 0x1005
-#define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
-#define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
+#define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
+#define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
