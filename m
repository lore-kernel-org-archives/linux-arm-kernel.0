Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0052E207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TYfJQMKi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOxdY/jQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0052E207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iFsNQb5vL1AGtpcnI+DFTUWiM1Id5BNVlY5r1kEiSmU=; b=TYfJQMKiR8vBES
	JcD0euXWIr0bHg36oui+3C3z4jkqNftkZxy6ksrqFbVNHveY9HGp1bzbvq5QT+NdIXZUNKOAdjg73
	0NaLoBxSi5QtHkVMzHcvFIhUgRoVy0hyTxeoQHcMw3ci05+sWLE2aMMaskUEx/VfxLtDoujQYLSF4
	qSGY/lEu7aeJlyqV9YSgrO8YJH3DkIxL7GxvnuokhlRl8XLpXwOwjdh4LNj2YSB9Hns6rkUhY+nI3
	+Y7+lpNdG2zstiSoomVU5DXYWHtN8BGcEaOqM2eJpyYa0vvkWd6qSRe6r685TwLJF8Ca3+Wn4oasW
	l2KoWBCh9N0rWYK40HBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuug-0000mS-2s; Wed, 13 Feb 2019 13:49:22 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuuL-0000Gx-KR
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:49:03 +0000
Received: by mail-wm1-x341.google.com with SMTP id y185so1934545wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 05:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oEjaCbJAI7v1M+EBiHgejuQl+NdCAyaoj/59FsOaZdQ=;
 b=WOxdY/jQNyU3QUdgwc7S/5/eubNDSXUsh3jaw2xdt5w/y6LzOxWP61Q3R0Impb7SYT
 6XZlTBGgZO+nmDvggpeaoJPFnyhi9y7Ob/rpazmZZUnX/gUyzPeoc9EUAx4t/8gOjUpf
 b4nhNP0kMbabzMZZ7qcmBWwovdoeU4m+cfZzW4ciDa+K5f/bmZn2UC4gcblh4jbnEkWO
 QdKCncnBD6Rxot8+hX2YHoAt/f6gmsNysvoIlCaNMb492TG9d5GDhzu4RwdxyFqOlsqB
 pX5vcD/KEQ65Cw8erYrnlRy49sCiMBLp8BXXaRY6RDqVyLvAS1gsIhUltwttH7wvCPKb
 ZOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oEjaCbJAI7v1M+EBiHgejuQl+NdCAyaoj/59FsOaZdQ=;
 b=IM73onW15dpJCLOwgl+6M2bYSkoTkY2LWONITXdnWkTuFdQtB7VTHjVZZTrYi34wQS
 bfldRxTDuoB6pnQefdUL/r98I3+D2cblUk1GGeD7n32wrKMNSpDyDo+YUdFKkV9SeUFz
 0Z6bf26bfw+jou6t/psE2HXVFxsbvLAbl+lfNSTNI0+lKmAquV/qS4btDgxmn7qiPEyZ
 PlkjtOqtOiELsQAoNgyw6cU/310C0/zkXl9ccS9fCGqyUMm4UHf/VhHfi1A6Ca2IHAtU
 SvLgoV4xRvBKWEburL2/1py2L2T9ZlaDMxvsNZ/xvW9HU9WWsyjdv3k1G+tkgLOYDDhL
 Dbhw==
X-Gm-Message-State: AHQUAuYiHZlmR0IYi7wcLr6ppiXOplBdUIkUwspS1e7kn1y3RY8ONiuL
 Y/+2VqoSXnihf7FKqGJ7W01lvQuuhtM=
X-Google-Smtp-Source: AHgI3IbC1OIsE/j9eYtGYBRKfxu8AW58LnKn915Sl0raXjwGS/EMezyt952G82d+Ba1ol9Pm02GkZw==
X-Received: by 2002:a1c:a98b:: with SMTP id s133mr359038wme.129.1550065739319; 
 Wed, 13 Feb 2019 05:48:59 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
 by smtp.gmail.com with ESMTPSA id g11sm3333838wmk.26.2019.02.13.05.48.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 05:48:58 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: coresight@lists.linaro.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/3] drivers: amba: Update component matching to use the
 CoreSight UCI values.
Date: Wed, 13 Feb 2019 13:48:22 +0000
Message-Id: <20190213134823.20150-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213134823.20150-1-mike.leach@linaro.org>
References: <20190213134823.20150-1-mike.leach@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_054901_676224_6C5124AC 
X-CRM114-Status: GOOD (  17.31  )
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
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Mike Leach <mike.leach@linaro.org>
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
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

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
