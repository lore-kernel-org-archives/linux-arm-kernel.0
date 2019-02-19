Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F3CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:05:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEDA21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ROZLIbmJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+dvwvSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEDA21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tmpZ82rC5OHHwEba0zcf14mTcO7kKCmtRXKZvlLv6kg=; b=ROZLIbmJJZMBed
	vvR+ChkXk9qnYjBdr61WMHAOdAx02XHee8Sg5CjwqS4yvvTxqD+jLpXnzEvBV4HneyFkA7K2/aMhj
	GofMhPETHanSiXwATRuBmyW+ruIfancQ8kwNFGGQzs1aC9idEgviZhu1+2eautRqtVQ3R5dMmmmR0
	fOXmxb2MIyCMzUfwrBK+XbIgHiMWRRe6ewiKK3hFeLD2m1uJ73hvFNXGL+bhAq9Jd8BtPznAY4sG6
	4WZuVaBp/YGVDV1upzhM0W3Ni0DHs38cVHpVKyHNeYyaqltWSXbi4z62wGE64uLCgqhJDZkonzyyt
	BMcRiKLB5u5X2+P/u/uA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwBdi-00048s-H9; Tue, 19 Feb 2019 20:05:14 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwBcr-0002eM-QY
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 20:04:24 +0000
Received: by mail-pg1-x541.google.com with SMTP id q206so10636042pgq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 12:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gTZS3t8Lyn570x3oRncarDhKKj8oVR/yQ7+W/riZcU8=;
 b=G+dvwvSuDU6HE9jgfFG21HfXS4BEgBfzNKskDzwX91rsuKELDHESW0fs5hqOY2/3/F
 iRQL1z7xpeKG+1zlTLP6FkpfTgZ9JRUKJCwsfFrL4RogLj+xJTd94WvBdbD/AT+WZfGf
 nudFMCdQyvSe7qYa8FSGXVaZEMfbPZkjqpcU/x3ZQnwNP82XH01iqriLzmws6F83d0tq
 MX+14L4oqAAZAPnalbRTOC+7B81+PSBHpcjJ14SC7YYNUiF6nR80CH4xVNXQsFvFqAyH
 DUa/kmQBal3LSauQW24gx9bNuMLyaEsnaEDaP6+vLreBt2AYELyp4eo15wrcjZg0fAih
 bVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gTZS3t8Lyn570x3oRncarDhKKj8oVR/yQ7+W/riZcU8=;
 b=PYvHSygpmsK5qbbHBSZZonfeE21l+rAbZM2uOhAnkZ//UJI+bOXibiqL1qE/lzyTTl
 BV0HM3xI021fKneGVn3QqFkreF35GRu8Xmd3B1MQkTQf5k+fDR5+KoY3dkf9mRXCb1ll
 K6L6panAPTQkFpKUKIEdKMSl3yQniWEWM/LUCLqB9PLy7a7x+l+hIiUHA4c9iKJGIrBE
 7h8Wq32GmZ5bPdwxwrM/ptnJHT8Jc/8i8DmzW2w1Jl9GVIAVnfrqI7vWHohOYoWd2n/h
 eYR90sFlt1hUgNGO09kvKnYQn+3RQHM3VOu8QaZX4/gaDb4RodUI0uhG5jvOro6kHcpu
 FBvA==
X-Gm-Message-State: AHQUAua/udVfAHSiZaa9+CoSlmVJTho0tHXP5ZuaP3lN1uVy8dtHaWnS
 Qik5w5btAHPGa/eJDd/Pd2Y=
X-Google-Smtp-Source: AHgI3IbtUCPjKiYn8vRprZhcgLfAG7cHtYkA9MN4O7HEk3qZ8QWNEfA+R628X+qWcnqFcCpLAEyPYA==
X-Received: by 2002:a63:6881:: with SMTP id d123mr25343732pgc.10.1550606661180; 
 Tue, 19 Feb 2019 12:04:21 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id e63sm31519622pfc.47.2019.02.19.12.04.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 12:04:20 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 5/5] PCI: dwc: Remove superfluous shifting in definitions
Date: Tue, 19 Feb 2019 12:02:42 -0800
Message-Id: <20190219200242.17243-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219200242.17243-1-andrew.smirnov@gmail.com>
References: <20190219200242.17243-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_120421_957255_1EA6C1AE 
X-CRM114-Status: GOOD (  10.12  )
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
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Surrounding definitions no longer use explicit shift, so "<< 0" here
serve no purpose. Remove them. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
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
---
 drivers/pci/controller/dwc/pcie-designware.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 8ebfb06584d9..f6fb65a40f10 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -60,14 +60,14 @@
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
-#define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
-#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
-#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
+#define PCIE_ATU_REGION_INDEX2		0x2
+#define PCIE_ATU_REGION_INDEX1		0x1
+#define PCIE_ATU_REGION_INDEX0		0x0
 #define PCIE_ATU_CR1			0x904
-#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
-#define PCIE_ATU_TYPE_IO		(0x2 << 0)
-#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
-#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
+#define PCIE_ATU_TYPE_MEM		0x0
+#define PCIE_ATU_TYPE_IO		0x2
+#define PCIE_ATU_TYPE_CFG0		0x4
+#define PCIE_ATU_TYPE_CFG1		0x5
 #define PCIE_ATU_CR2			0x908
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
