Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573ACC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EBA20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g6O8N0M1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NG/qi3r9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EBA20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yjd/LxY7Pj4zGiAj2wQMs6PClROVmbhaeF/lJtfiUOA=; b=g6O8N0M1ZH2DZ4
	BySMpoaxST32HEirmhzGuXbVf1Y3ek3Y9Cc9ycNA5/Vv41jcU3d+WAAnzJF1A32s1u69S9kCkMRyQ
	yc6jnhHxPYuLqZmWN07bmq5npNtluk+icunZBsUWYWutuTj+njzghcP20PraSlEjJFTIz/6qLJckI
	2DNL+ggZe3m1N/3Ag5ghq7X9BAkElS+j+EbhgUOzaFf2O0uQb3RIlZx4LT7Tw7vnoo0RBVMTf7Qc0
	uDld/vQdg943x68hEjwwYq/HAOxOU3pS8vH43LEnQ9Duv3kb4Vemq4HjiSjyN5VDtlg6w+tP8uQUk
	PyFGVgkp+1NiEOSvcTRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gozU3-0006Lu-Fz; Wed, 30 Jan 2019 23:41:31 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gozTY-0005tL-BA
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 23:41:02 +0000
Received: by mail-wr1-x443.google.com with SMTP id u4so1348003wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 15:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tYoiEn3rGlYfp2djZcDtRq0G4N8SiFNVjNwRGoB1+ak=;
 b=NG/qi3r9Jong2qjYQkyYg6Gypld8RDdK4DWdP9KrS3GzGFcpWRvs0ZsM3JcGY14i2K
 0i4gZLY4L1L3bQrFomimVnGMrlYRk9X5Lq0tjJExWFTAhGrX4vyIIOW2F2b59B1cSoul
 cPVjwOZCc84dqDUpvHR5vAhrEkZY2ZpHLjnEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tYoiEn3rGlYfp2djZcDtRq0G4N8SiFNVjNwRGoB1+ak=;
 b=Az46LhpZdlG1bqqeF+1KdTcCqmmCuy4C/fEauLUxbuHGDEPi+7C2e+JPEJ7rMQlJXD
 UDLJ895uXrXSbn0CiU1bvLseRGYY7TClQ1x+elufXgh0X4+MZz1n/oPORrX7vOYqF3fv
 dXIh/CxU6a7KWMdEUEOpzh2O2cCyCul9755Xc8LX4IDmW1Ks+s/oVrdHgoEo3UXapsir
 E7JyBJSd98IHBwXNhMovL3tuIC4HEltoU9v0696Ap4DDTwXCtuJev+g/a9VJYcFXYtDq
 9F1CuLl7IXfroOhmc0dLtFwfSjOpD2+vjYiXNwresKOilto61nXfpMRDwPAjKQIEEoGC
 dosw==
X-Gm-Message-State: AJcUukdFf+uUcG5WCgEJw+QW/TgVyP8ckD+O3vH5PN7HY/XBi1HnVeeF
 5f/LG4mQTW580glEwia4wQNazL1Kq64=
X-Google-Smtp-Source: ALg8bN75ZFF1kDytY7l/gUl+safwed7S2O6sTIaGR87t2DxcGzQ0D7ilymqOcNoN4rPCPDYxeA3nfw==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr33224434wrm.218.1548891658976; 
 Wed, 30 Jan 2019 15:40:58 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
 by smtp.gmail.com with ESMTPSA id s3sm2344770wmj.23.2019.01.30.15.40.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 15:40:58 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
 coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] drivers: amba: Update component matching to use the
 CoreSight UCI values.
Date: Wed, 30 Jan 2019 23:40:50 +0000
Message-Id: <20190130234051.2294-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190130234051.2294-1-mike.leach@linaro.org>
References: <20190130234051.2294-1-mike.leach@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_154100_378981_7DC48198 
X-CRM114-Status: GOOD (  16.91  )
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
Cc: saiprakash.ranjan@codeaurora.org, arm@kernel.org, linux@armlinux.org.uk,
 mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patches provide an update of amba_device and matching code to handle
the additional registers required for the Class 0x9 (CoreSight) UCI.

The *data pointer in the amba_id is used by the driver to provide extended
ID register values for matching.

CoreSight components where PID/CID pair is currently sufficient for
unique identification need not provide this additional information.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/amba/bus.c       | 45 +++++++++++++++++++++++++++++++++-------
 include/linux/amba/bus.h |  6 ++++++
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 41b706403ef7..b4dae624b9af 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -26,19 +26,36 @@
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
-static const struct amba_id *
-amba_lookup(const struct amba_id *table, struct amba_device *dev)
+/* called on periphid match and class 0x9 coresight device. */
+static int
+amba_cs_uci_id_match(const struct amba_id *table, struct amba_device *dev)
 {
 	int ret = 0;
+	struct amba_cs_uci_id *uci;
+
+	uci = table->data;
 
+	/* no table data or zero mask - return match on periphid */
+	if (!uci || (uci->devarch_mask == 0))
+		return 1;
+
+	/* test against read devtype and masked devarch value */
+	ret = (dev->uci.devtype == uci->devtype) &&
+		((dev->uci.devarch & uci->devarch_mask) == uci->devarch);
+	return ret;
+}
+
+static const struct amba_id *
+amba_lookup(const struct amba_id *table, struct amba_device *dev)
+{
 	while (table->mask) {
-		ret = (dev->periphid & table->mask) == table->id;
-		if (ret)
-			break;
+		if (((dev->periphid & table->mask) == table->id) &&
+			((dev->cid != CORESIGHT_CID) ||
+			 (amba_cs_uci_id_match(table, dev))))
+			return table;
 		table++;
 	}
-
-	return ret ? table : NULL;
+	return NULL;
 }
 
 static int amba_match(struct device *dev, struct device_driver *drv)
@@ -399,10 +416,22 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
 				(i * 8);
 
+		if (cid == CORESIGHT_CID) {
+			/* set the base to the start of the last 4k block */
+			void __iomem *csbase = tmp + size - 4096;
+
+			dev->uci.devarch =
+				readl(csbase + UCI_REG_DEVARCH_OFFSET);
+			dev->uci.devtype =
+				readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
+		}
+
 		amba_put_disable_pclk(dev);
 
-		if (cid == AMBA_CID || cid == CORESIGHT_CID)
+		if (cid == AMBA_CID || cid == CORESIGHT_CID) {
 			dev->periphid = pid;
+			dev->cid = cid;
+		}
 
 		if (!dev->periphid)
 			ret = -ENODEV;
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index e3c36223e40b..f99b74a6e4ca 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -58,6 +58,10 @@ struct amba_cs_uci_id {
 	void *data;
 };
 
+/* define offsets for registers used by UCI */
+#define UCI_REG_DEVTYPE_OFFSET	0xFCC
+#define UCI_REG_DEVARCH_OFFSET	0xFBC
+
 struct clk;
 
 struct amba_device {
@@ -65,6 +69,8 @@ struct amba_device {
 	struct resource		res;
 	struct clk		*pclk;
 	unsigned int		periphid;
+	unsigned int		cid;
+	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
 	char			*driver_override;
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
