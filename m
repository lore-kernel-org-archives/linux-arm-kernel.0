Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E0C20665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S6cxaiKS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dr9F0jpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E0C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vCa9Il49bjvQOepNQXTESMSrcwr3inGzZm7rrsicxHc=; b=S6cxaiKSyRevGhcwWZ4utwffFb
	KvV1OfwkmiKR9CMVApqOfpU+79SUB9uKD4kZNepxHSVGLekjEFm1ITQ2IHCY9edAEt3V16fjCddsl
	zdvrfKbDzbB9/Vj9qAFIxX1owfDaKqJR8vTCb1Abe05l2Mz39KuneQAz1/QM0gKOhCwayz9wupCrI
	d/EUxsBfkxB0Jy2GNt/Mv05ydOpoVfetGgxWa+ChUHvIo7QUl0FkfZEZl8IqDNLd7gCXA29BP+oBu
	bBO4PgFMUvKvq2JLXKEsuJlEJbBuk3OovvakRyaxEK8WjRA6uLFT/fWNHVZt80G3rDAEJz0lenFGz
	eMlLWaFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZPE-0003e3-Au; Thu, 10 Jan 2019 12:25:52 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZP6-0003Xd-Ip
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 12:25:47 +0000
Received: by mail-pl1-x644.google.com with SMTP id u18so5123830plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 04:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fG6Bxz4zCKnlte2DiphB1mWwnICLjL7B6OfDSnAmPoM=;
 b=dr9F0jptT97nERs45FBkoKZrhIfKnDtAMrmjVYkZirPQiYs5b3uF5s+/48Q/UDjHPp
 i2SgeCGe5nvs9VunxJXGc5jkpxH0l2STEwJak0PiPGSgqGPRQq1W5r5yJ6NiWpOToDDe
 dJlJUZj+7fCaql4lHbc78E0On8kv42sPV+GgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fG6Bxz4zCKnlte2DiphB1mWwnICLjL7B6OfDSnAmPoM=;
 b=X25GJdftm5dSp6zprUdblz2YGUdkv/6pdydAryA9oJFdtMhD6vMNLPXA3PyUJDaXJC
 jTkkEtnMdynVWm5iRVKM0Z7u/z36RM7/nsw94NJ3YIrSJJEHqLcGXuU86DqEZFMdrCHr
 aiD9u8wbZY7rWM+lhV+kHULY3fXRBAjQgBgKb6QDfHzEigrFYXZYK2BG/Fm+HeiLXTfz
 doUSMNGFupci2/Xv3cwNiJY+22s/aeo86ZkIEMoiENpa+65GXQS4EZ6e3UjfY045s58P
 W8vmnjA2ZzJLApwpyrv2OL1XT6POaIMraxVErgirFDAQB0I12nn1OOZpOfapgGYjahAX
 CYWQ==
X-Gm-Message-State: AJcUukd6jqGjEDFs9AkEQY1pAlQHVb1GFMJhZ5862HxTfnw3n27lHsh/
 FtlqQ29oi6IZqqtECSVUr9c/STBFRHM=
X-Google-Smtp-Source: ALg8bN5qWZqFUykCmBZNde/2W86VZJlGLO7awAyBW/y4aZ8NHZnyX2dcLCB8FvPlhZV5d5rB8dJ4cA==
X-Received: by 2002:a17:902:b592:: with SMTP id
 a18mr10171014pls.293.1547123143455; 
 Thu, 10 Jan 2019 04:25:43 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.251])
 by smtp.gmail.com with ESMTPSA id m67sm142985541pfb.25.2019.01.10.04.25.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 04:25:43 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v2 1/4] tee: add bus driver framework for TEE based devices
Date: Thu, 10 Jan 2019 17:54:54 +0530
Message-Id: <1547123097-16431-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_042544_988549_CC22512A 
X-CRM114-Status: GOOD (  20.34  )
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
Cc: mark.rutland@arm.com, Sumit Garg <sumit.garg@linaro.org>,
 daniel.thompson@linaro.org, herbert@gondor.apana.org.au, arnd@arndb.de,
 ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, bhsharma@redhat.com,
 linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org, robh+dt@kernel.org,
 mpm@selenic.com, jens.wiklander@linaro.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Introduce a generic TEE bus driver concept for TEE based kernel drivers
which would like to communicate with TEE based devices/services.

In this TEE bus concept, devices/services are identified via Universally
Unique Identifier (UUID) and drivers register a table of device UUIDs
which they can support.

So this TEE bus framework registers a match() callback function which
iterates over the driver UUID table to find a corresponding match for
device UUID. If a match is found, then this particular device is probed
via corresponding probe api registered by the driver. This process
happens whenever a device or a driver is registered with TEE bus.

Also this framework allows for device enumeration to be specific to
corresponding TEE implementation like OP-TEE etc.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_core.c  | 41 ++++++++++++++++++++++++++++++++++++++---
 include/linux/tee_drv.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 7b2bb4c..9ddb89e 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -15,7 +15,6 @@
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/cdev.h>
-#include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/module.h>
@@ -1027,6 +1026,30 @@ int tee_client_invoke_func(struct tee_context *ctx,
 }
 EXPORT_SYMBOL_GPL(tee_client_invoke_func);
 
+static int tee_client_device_match(struct device *dev,
+				   struct device_driver *drv)
+{
+	struct tee_client_device *tee_device;
+	const struct tee_client_device_id *id_table;
+
+	tee_device = to_tee_client_device(dev);
+	id_table = to_tee_client_driver(drv)->id_table;
+
+	while (!uuid_is_null(&id_table->uuid)) {
+		if (uuid_equal(&tee_device->id.uuid, &id_table->uuid))
+			return 1;
+		id_table++;
+	}
+
+	return 0;
+}
+
+struct bus_type tee_bus_type = {
+	.name		= "tee",
+	.match		= tee_client_device_match,
+};
+EXPORT_SYMBOL_GPL(tee_bus_type);
+
 static int __init tee_init(void)
 {
 	int rc;
@@ -1040,10 +1063,21 @@ static int __init tee_init(void)
 	rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
 	if (rc) {
 		pr_err("failed to allocate char dev region\n");
-		class_destroy(tee_class);
-		tee_class = NULL;
+		goto class_err;
 	}
 
+	rc = bus_register(&tee_bus_type);
+	if (rc) {
+		pr_err("failed to register tee bus\n");
+		goto class_err;
+	}
+
+	return 0;
+
+class_err:
+	class_destroy(tee_class);
+	tee_class = NULL;
+
 	return rc;
 }
 
@@ -1052,6 +1086,7 @@ static void __exit tee_exit(void)
 	class_destroy(tee_class);
 	tee_class = NULL;
 	unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
+	bus_unregister(&tee_bus_type);
 }
 
 subsys_initcall(tee_init);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 6cfe058..ed16bf1 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -20,6 +20,8 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/tee.h>
+#include <linux/device.h>
+#include <linux/uuid.h>
 
 /*
  * The file describes the API provided by the generic TEE driver to the
@@ -538,4 +540,38 @@ static inline bool tee_param_is_memref(struct tee_param *param)
 	}
 }
 
+extern struct bus_type tee_bus_type;
+
+/**
+ * struct tee_client_device_id - tee based device identifier
+ * @uuid:		For TEE based client devices we use the device uuid
+ *			as the identifier.
+ */
+struct tee_client_device_id {
+	uuid_t uuid;
+};
+
+/**
+ * struct tee_client_device - tee based device
+ * @id:			device identifier
+ * @dev:		device structure
+ */
+struct tee_client_device {
+	struct tee_client_device_id id;
+	struct device dev;
+};
+#define to_tee_client_device(d) container_of(d, struct tee_client_device, dev)
+
+/**
+ * struct tee_client_driver - tee client driver
+ * @id_table:		device id table supported by this driver
+ * @driver:		driver structure
+ */
+struct tee_client_driver {
+	const struct tee_client_device_id *id_table;
+	struct device_driver driver;
+};
+#define to_tee_client_driver(d) \
+		container_of(d, struct tee_client_driver, driver)
+
 #endif /*__TEE_DRV_H*/
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
