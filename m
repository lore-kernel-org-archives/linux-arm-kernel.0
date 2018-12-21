Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4DBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:31:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2544121903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LucXzsCo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9Auu21d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2544121903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+sN9egbIBQkYkyHoaInmFpyXbocgXjKNjnsPJwp4YtU=; b=LucXzsCo3fvJh8
	MQNhgNfFdJC7R+Dim/tZ1VcgLMdmweTrAzuVM5IFmEbVxwVUBOy+JXVtNTcU9Wm7cOaLsrwM8Zk4W
	Lt/5Ipra/gBav21slaXkMaJWUTqueq7SsFHHMaf8dr/GjPnVeN2mf+dne0+ToZDT8HoGiQe20cADR
	NTo+ZHk8PqLsQ5eWW9pF1qHJsZKgTl3aCAkyg9p6dpL/Fb2uI1LVMDJT42SQc8/82Mpdh3Wc3yrQ5
	G6/IiSGNsycf0KjhCYFokB51QvPW/7AEZu5f9VN2U6H3ZHgRqHa+HEFRuSqFnm0c2sDSzBHDGQtAI
	qjek0gaMcV6nPNwyVy0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFGw-0005z2-JX; Fri, 21 Dec 2018 07:31:02 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFE9-0001qF-Gk
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:11 +0000
Received: by mail-pl1-x641.google.com with SMTP id 101so2106879pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TqYCFphTE89qwX5r9RN/jgIceUrAGJyLboLH1gjiqTU=;
 b=T9Auu21dO+fPpRqohnW/C+5tSklOBK/DUBX20FiVnu8xHc0T/An1rBo5B2i+ENO0+N
 gipONMVohHBbWbt4wqeDEZa4gB0NGELCRQZA4INafJ7EntVQy4Kf5WIb54oCOT+Ct3yI
 pu2UFPnDwqLo2DgBb1qi9z1wmJ+1sUbJtsCCeROo4OC4DrB3Y8iwJqiEvshv5sg/sxvG
 XOy3AuJ6oDQwNGR9hm3NmGGspi4kgJP4lPAMfnB/ZunBOlmuoX+cC4M32WlLoeYOAGPd
 swEszRp5rZxwIRTzF5N81LYeL4jiPmy0shs30vcTC9bqaYnp3DZ2DmfkY3uH3/DrY0iF
 fgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TqYCFphTE89qwX5r9RN/jgIceUrAGJyLboLH1gjiqTU=;
 b=mOS1AGjY5rnblTuK6cCy+FZEyK5Q/PtLQMZ1f7MAaeV4ttu9aMMHS0KaUG54wZdyMV
 A4+g3k5iiKevX8AUXgtGKLWHeT7f00fkZ7JO+jA5minOG0XoIB3ebVj4KpEREVhNwXEQ
 0YJOQ/Ce3uBRN/z/jBekaV/4+QNutlPneso1XP1k8p8j2qxYxSJEMZ6qKouudlbSaWXO
 963QOaH0PUBMvLv5CNoeiB4lev7sMy1wPXF40NfIw2JVLkCa4K4velraG2bQdQOUCYFG
 Aw5NmwDKSAVgF5Og5QFXdxX3sKbeJnCt+WRutmLYEKsdzPDRdl9PvpXHj/zVqeLCDUiN
 zV7g==
X-Gm-Message-State: AJcUukfAghfbUwrQxiTyKfhoxFNGHrmc45BGEvhZXsqJWP9Dn1jXItz5
 +3GBT09aPHTns2EXq1dRZ6bal1xN
X-Google-Smtp-Source: ALg8bN7VFNOfyipcRVN4uHadck2NF4rcy2dCIULEnDmBnNnp6tn/CxUmIVmP48c7+xPdGJUmJd7jdg==
X-Received: by 2002:a17:902:9b93:: with SMTP id
 y19mr1437738plp.336.1545377281678; 
 Thu, 20 Dec 2018 23:28:01 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:28:00 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 12/21] PCI: imx6: Make use of BIT() in constant definitions
Date: Thu, 20 Dec 2018 23:27:07 -0800
Message-Id: <20181221072716.29017-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232809_592340_269EE203 
X-CRM114-Status: GOOD (  11.11  )
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
index c0b073cf20c0..2737526158fa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -95,18 +95,18 @@ struct imx6_pcie {
 
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
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
