Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43739C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BC821872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tvXtyrSX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um3WmXbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BC821872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o5baCJXp+NBA0vgNpTRlUkPBD77zSE6y6kLy0uF9mlU=; b=tvXtyrSXnRocWD
	U46RTWLPiBLX3RUBYe/YR0ne070Xe7MvSBBGdEK07KnXfGvrHnXyIkeJ5IV5/zMxalEW3RLBmK59P
	/Tjj3mIeGR898fHRv2wCsfsX0dQB0MJmGS7bmofx+pafmE8pBeIJ86ssAAVI5nin1jBU9Q6l694Se
	yuTUgYaR8gYe3ZzSEgYy/T7TgXCARYWiFkOmvvqO+DzyLXthnI3jkiDRKnXYfu875M+8/mOx6ru6D
	KONk7fe5KxPC+av4PZK4KAxAASls1PLJuPkF6ryEEd+rUQIO+Tr/wTMJ7XcIOUcOX7hKuKU7jS45F
	b8503QbQgp2fS+QdKx/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTdk-0007na-Nc; Fri, 04 Jan 2019 17:52:12 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbc-0004OE-Ta
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:27 +0000
Received: by mail-pg1-x543.google.com with SMTP id w7so17760310pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5GPVKMBGU5ZvNu6g1jC/voOA4PDlqiI+yiygPIURHSo=;
 b=Um3WmXbSD2WHftXb7YDOCm2GnKkStW9iff77m/sinDSPuAyDCa2CkNOhrWt+5bAZ2+
 fVtQRJAOXwY3/14+mCUAmm3B7Wza1kiMGA5l5l53catA+AOanNdzl7AHXFuTkqgVQ7If
 gthkNJVv093LCzdTcZCJ/Q22OAxLwFvwK5ygTCqK6tAmILOvpNtwWe8QTLj1VbQIkztd
 D/FTCrXL0QQ+6PfXwDX+1Gpm0nIiWImGBPquaWETLsXeTwLRM4MZFzeeXhNu6AFEzTSd
 sAd1AACcrluL2oXJBXK+gpQpuR9VlutzaR7EaGgCBvgmO8xb7/P5F96cX0qWW1pJGa+x
 01EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5GPVKMBGU5ZvNu6g1jC/voOA4PDlqiI+yiygPIURHSo=;
 b=rP66lmGFRxbegAWgUnLgtmxTirhnGtGWkU7qrSHr+FXgWUzZJASOw4I5LWKS0YppLE
 v8RtZhudqDCPFwlvJL9i6VzNXMFVA1JApYaB7KzoyqLixBwSWf1noXEteUnlzZRBC0wa
 qInLYZ6R6ouoVa+d7Gysa0/R/EEn0bywkzHxZ/Cx3fJN1CTprsmmnbcMFih7Ec8DeyNl
 sviQWT5GEvlDc1IXZ8SAAjrBNeAgvczlkMRbwEKJkEaAVplULeSFffBylc9XQqy1nv+3
 ggyZAVsDPJ7c+lfVwz+POv2+bLy23Zjkrv6jnPQh7djjkw6pabxUo+/1tXHwaCLPI6xy
 A7qQ==
X-Gm-Message-State: AA+aEWbjSZ6td/nbdMq3xexKeX7lNgoXh4QTUb4+p/7fxCVdF0RQEYxV
 DWETs7B2LiP5ofZdzXMw8TCRuFvsqmY=
X-Google-Smtp-Source: AFSGD/VZP1C1IS24z+0UcPkxVu/MZQFkTGhZq3FCBDvgZajuV5DLwpdWnMLZ7mFUMZPpd/VByx2xxA==
X-Received: by 2002:a62:1e87:: with SMTP id
 e129mr52726011pfe.221.1546624199860; 
 Fri, 04 Jan 2019 09:49:59 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:49:59 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 10/20] PCI: dwc: Make use of BIT() in constant definitions
Date: Fri,  4 Jan 2019 09:49:15 -0800
Message-Id: <20190104174925.17153-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_095001_491294_1829F15B 
X-CRM114-Status: GOOD (  10.75  )
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
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-kernel@vger.kernel.org,
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
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.h | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index d123ac290b9e..086e87a40316 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -300,7 +300,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 	}
 
 	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~PCIE_ATU_ENABLE);
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
 }
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 58735fd01668..348e91b6daa2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -40,11 +40,11 @@
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
 #define PCIE_PORT_DEBUG1		0x72C
-#define PCIE_PORT_DEBUG1_LINK_UP		(0x1 << 4)
-#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	(0x1 << 29)
+#define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
+#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
-#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
+#define PORT_LOGIC_SPEED_CHANGE		BIT(17)
 #define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
 #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
 #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
@@ -58,8 +58,8 @@
 #define PCIE_MSI_INTR0_STATUS		0x830
 
 #define PCIE_ATU_VIEWPORT		0x900
-#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
-#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
+#define PCIE_ATU_REGION_INBOUND		BIT(31)
+#define PCIE_ATU_REGION_OUTBOUND	0
 #define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
 #define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
 #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
@@ -69,8 +69,8 @@
 #define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
 #define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
 #define PCIE_ATU_CR2			0x908
-#define PCIE_ATU_ENABLE			(0x1 << 31)
-#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
+#define PCIE_ATU_ENABLE			BIT(31)
+#define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
 #define PCIE_ATU_LOWER_BASE		0x90C
 #define PCIE_ATU_UPPER_BASE		0x910
 #define PCIE_ATU_LIMIT			0x914
@@ -81,7 +81,7 @@
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
 #define PCIE_MISC_CONTROL_1_OFF		0x8BC
-#define PCIE_DBI_RO_WR_EN		(0x1 << 0)
+#define PCIE_DBI_RO_WR_EN		BIT(0)
 
 /*
  * iATU Unroll-specific register definitions
@@ -108,7 +108,7 @@
 		((region) << 9)
 
 #define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region) \
-		(((region) << 9) | (0x1 << 8))
+		(((region) << 9) | BIT(8))
 
 #define MAX_MSI_IRQS			256
 #define MAX_MSI_IRQS_PER_CTRL		32
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
