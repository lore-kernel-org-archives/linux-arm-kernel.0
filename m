Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE0AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:18:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587E22081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uUy6CNlJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BfMIxfD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587E22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/0lyvzr6I+yrXFmHoJn4kJaiJf2uY9ZP1gDfv6to4FQ=; b=uUy6CNlJV0NudgOg0sqtkkT83C
	cxhooDE4w+q8H45HqgXszi4jI77BxbHwavyVWpO+glY1g/jiUFLr9bnl1XWtyVhbjUPEgxb1HN0qM
	Cp2B8vgGXm9P3ENtB4bNs7L7QuGG1ypPkFCrZxN5uJzU0+5/a6qk9yGAmVJupbdTuQ0TrVJTe/+Ym
	ozsP3LsTTduz9pXOar2UTjtp5t0651aHe+lq/ipsoJKYYHIn/3UuuviPuhBARB25qmBsGKMUvcw84
	yDcMcm0/vpD345wuElwIIDeu8fQ2KjZHznZBQTbi27mt5CjffHRaLyxg0UIXamsU3fxPlTwBsX0uC
	w9Ul5Z9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqnVA-0008TB-UR; Mon, 04 Feb 2019 23:18:09 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqnTb-0006uC-IP
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 23:16:55 +0000
Received: by mail-pg1-x544.google.com with SMTP id d9so614602pgl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 15:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fF0LtqiU+ezqKDEGBPuxdJhivCCihna6QbzlCwznwyo=;
 b=BfMIxfD6Im8RxiPMweyz+P9gqiVJX2jYh+9FqM2zwAjF+jxe1C2cGY7fvdH67E78rG
 9EMnlsINpko7jxznSo3TQUo6QDtO/pTuufvVb2UmH8jDaII0/FY9+Z31t2vYIxW8EEd5
 PM7nSXzMgpY7Wi34Na/6HlNMbVIixY29mD4Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fF0LtqiU+ezqKDEGBPuxdJhivCCihna6QbzlCwznwyo=;
 b=oNIslsjpQOvbScXoGm0YpZiTegYlSxA3AivDms6ImCbdtQ0TZsy2hRA/hfh8iZGXVq
 n7X5cVnA5uLdUH5TB5IFHiJWDCA4KdFy6exT6EreCavniiuwT95U3Ri4sbmbe3N1uymx
 V4crmtiTBeDEoWMUgKvk92Nl7e11FSNgK+/gSyoG5+xj/naNJM+3OHY4iIcvuEfaTe7Y
 LARKD0soqdig0PND3b1JI2Pi4SQoWWma3//+IEWYdsM0/5NM4Hzmct/qMV5zDgZuD4KR
 9Y6cXNQeaeqMi/QwFl7g2zC8zou2RbuYnkObcVifiMTCLFgT3PcJTY5GpReTNyZ7zl9M
 yJYg==
X-Gm-Message-State: AHQUAubPPAk5/Tnyr7olmAQcqz1nEb/SdmpFYvGDEDsO/krW+VsNYGND
 wlX90aY1fQsUe2J1oM8w4kiclg==
X-Google-Smtp-Source: AHgI3Iag9OQOyLt6PZcBtG0qXhvNfLG0PWoVZN3qyC5SstsU5ff+8OO4gF+RabLAlaAUu5d9Efiocg==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr1873340pfg.183.1549322190894; 
 Mon, 04 Feb 2019 15:16:30 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id z14sm1281499pgv.47.2019.02.04.15.16.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 15:16:30 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 7/8] i2c: iproc: add NIC I2C support
Date: Mon,  4 Feb 2019 15:15:53 -0800
Message-Id: <20190204231554.87666-8-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204231554.87666-1-ray.jui@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_151632_297504_847B965D 
X-CRM114-Status: GOOD (  18.61  )
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
