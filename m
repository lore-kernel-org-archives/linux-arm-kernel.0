Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854D1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441D82080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oJw6cWFq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GZL7bMWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441D82080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/0lyvzr6I+yrXFmHoJn4kJaiJf2uY9ZP1gDfv6to4FQ=; b=oJw6cWFqWPJ4xymlL/cUXe9T+X
	6F3sa17D0bgQWpGXoQOwK1CxYQy3uJdIvzt/YA5RUI7EmfVkv7GvBkMykEpHoIsIDLShBsHdkGJe1
	Ejox5dR1/jGDrRIAOAWz/3tsqDxxRJRAuOhWxuMgckDWim7QTli1SeeWOFWGq7Eaph9k0+LBUstBZ
	GSUOymLkF30GNC0wSrn5HTKfgEe8wzQrF8oePloOWKZ9AJDluZmO4n2rJqXa+bzH7JHeKDsSJAA2/
	mukEn5rbh+RW++wBixM5+tq9uNnBcnriiCoxBmcoRmatbq03fjDl3LrFf7krhFGPQFhFJpNGx/k9Q
	GHeLjUew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLIG-0001UG-UK; Thu, 14 Feb 2019 17:59:28 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLGw-0008Fb-PY
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:58:27 +0000
Received: by mail-it1-x142.google.com with SMTP id l131so16405928ita.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fF0LtqiU+ezqKDEGBPuxdJhivCCihna6QbzlCwznwyo=;
 b=GZL7bMWsuhT/yxy1rHdCzEmJxBLDze3KipqjsMO9AXNUmndIK/l3k0kAWpt/whJBt9
 9fHjkTAAbCBKGNdGJbpPGGpTT6Bc/+4M8mQ7NCRNgL8bcPE+xk6WHXsTpKU++DxO4/YU
 +0igyBni8rrMxWl00/XM07aa3JleVBnu28Da4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fF0LtqiU+ezqKDEGBPuxdJhivCCihna6QbzlCwznwyo=;
 b=GCbgq92bxj/yo+QmuVuwgPHDAI3OSJNVA3X3kNxHyjilH/EaUIA1J2kbOHOsOMqvbb
 EKMTOxJ9xgPYck0BcmNRGQgteoPZu//weDePSKSsoA2SCznawbNv+3hSJVDlreZ5cO1V
 +FYQNwCB/i0ANwGo4aEaRhxq0vdUDOPWaE78M0dWUgh2Bfi2wYE1gLmdPEYzxvRauCQx
 irUoHczE1PI/Zy+04djW7Spn0mQ1bEko/JuzdD1lv+Zrq3TG4b2AJk/AHMsConfVVVuB
 Vrb0hwp1/70ZgNhaWl7BYo+g1mjM4vyB5AdmDYy/7aMvWOWtsYX0hrQTLoQGYD9WAdpp
 ihUA==
X-Gm-Message-State: AHQUAuZtrYTovACBPc/spVEjOqDogwl30ZQiKw+1Xi7xP7BdRBghSzCa
 j/P9jtf17kQ6Dvg8OG543HWDRQ==
X-Google-Smtp-Source: AHgI3IY5j6xsuyyk1XVs+BpvsO4vD5bIoDMrBNL02aS+ROITaVKAg9qVntm6joUMi1D2DR5QQ70b7w==
X-Received: by 2002:a24:bdcc:: with SMTP id x195mr1541749ite.149.1550167085551; 
 Thu, 14 Feb 2019 09:58:05 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.58.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 09:58:04 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 7/8] i2c: iproc: add NIC I2C support
Date: Thu, 14 Feb 2019 09:57:24 -0800
Message-Id: <20190214175725.60462-8-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095807_058529_79583582 
X-CRM114-Status: GOOD (  18.66  )
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
Cc: devicetree@vger.kernel.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add NIC I2C support to the iProc I2C driver. Access to the NIC I2C base
registers requires going through the IDM wrapper to map into the NIC's
address space

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 79 ++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 5b9cbd7a3776..9598e1d0048e 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -17,9 +17,11 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#define IDM_CTRL_DIRECT_OFFSET       0x00
 #define CFG_OFFSET                   0x00
 #define CFG_RESET_SHIFT              31
 #define CFG_EN_SHIFT                 30
@@ -174,11 +176,26 @@ enum bus_speed_index {
 	I2C_SPD_400K,
 };
 
+enum bcm_iproc_i2c_type {
+	IPROC_I2C,
+	IPROC_I2C_NIC
+};
+
 struct bcm_iproc_i2c_dev {
 	struct device *device;
+	enum bcm_iproc_i2c_type type;
 	int irq;
 
 	void __iomem *base;
+	void __iomem *idm_base;
+
+	u32 ape_addr_mask;
+
+	/* lock for indirect access through IDM */
+	spinlock_t idm_lock;
+
+	/* indicates no slave mode support */
+	bool no_slave;
 
 	struct i2c_adapter adapter;
 	unsigned int bus_speed;
@@ -215,13 +232,33 @@ static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
 static inline u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				   u32 offset)
 {
-	return readl(iproc_i2c->base + offset);
+	u32 val;
+
+	if (iproc_i2c->idm_base) {
+		spin_lock(&iproc_i2c->idm_lock);
+		writel(iproc_i2c->ape_addr_mask,
+		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
+		val = readl(iproc_i2c->base + offset);
+		spin_unlock(&iproc_i2c->idm_lock);
+	} else {
+		val = readl(iproc_i2c->base + offset);
+	}
+
+	return val;
 }
 
 static inline void iproc_i2c_wr_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				    u32 offset, u32 val)
 {
-	writel(val, iproc_i2c->base + offset);
+	if (iproc_i2c->idm_base) {
+		spin_lock(&iproc_i2c->idm_lock);
+		writel(iproc_i2c->ape_addr_mask,
+		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
+		writel(val, iproc_i2c->base + offset);
+		spin_unlock(&iproc_i2c->idm_lock);
+	} else {
+		writel(val, iproc_i2c->base + offset);
+	}
 }
 
 static void bcm_iproc_i2c_slave_init(
@@ -766,7 +803,13 @@ static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
 
 static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SLAVE;
+	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(adap);
+	u32 val = I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+
+	if (!iproc_i2c->no_slave)
+		val |= I2C_FUNC_SLAVE;
+
+	return val;
 }
 
 static const struct i2c_algorithm bcm_iproc_algo = {
@@ -829,6 +872,8 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iproc_i2c);
 	iproc_i2c->device = &pdev->dev;
+	iproc_i2c->type =
+		(enum bcm_iproc_i2c_type) of_device_get_match_data(&pdev->dev);
 	init_completion(&iproc_i2c->done);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -836,6 +881,26 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(iproc_i2c->base))
 		return PTR_ERR(iproc_i2c->base);
 
+	if (iproc_i2c->type == IPROC_I2C_NIC) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		iproc_i2c->idm_base = devm_ioremap_resource(iproc_i2c->device,
+							    res);
+		if (IS_ERR(iproc_i2c->idm_base))
+			return PTR_ERR(iproc_i2c->idm_base);
+
+		ret = of_property_read_u32(iproc_i2c->device->of_node,
+					   "brcm,ape-hsls-addr-mask",
+					   &iproc_i2c->ape_addr_mask);
+		if (ret < 0) {
+			dev_err(iproc_i2c->device,
+				"'brcm,ape-hsls-addr-mask' missing\n");
+			return -EINVAL;
+		}
+
+		spin_lock_init(&iproc_i2c->idm_lock);
+		iproc_i2c->no_slave = true;
+	}
+
 	ret = bcm_iproc_i2c_init(iproc_i2c);
 	if (ret)
 		return ret;
@@ -992,7 +1057,13 @@ static int bcm_iproc_i2c_unreg_slave(struct i2c_client *slave)
 }
 
 static const struct of_device_id bcm_iproc_i2c_of_match[] = {
-	{ .compatible = "brcm,iproc-i2c" },
+	{
+		.compatible = "brcm,iproc-i2c",
+		.data = (int *)IPROC_I2C,
+	}, {
+		.compatible = "brcm,iproc-nic-i2c",
+		.data = (int *)IPROC_I2C_NIC,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, bcm_iproc_i2c_of_match);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
