Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D30C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:50:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66617206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OFwsG4fX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7gHW/jW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66617206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=OefubjpxbMaFsJVqrHuQVfmch50hSvYoB0KBfxOMHWg=; b=OFwsG4fXfoZhx+NDoUVFCnVqjW
	Fvvf6A0OK3mtN7Xf2SbtvkiQXyHqttwsRPLjvpg9RgIgpjXtbwZRqNJ0T5bqtVZ3qta46WmzzKA1H
	IZqZ16BBKuMjGO9e+pfOFI1CuySyIjJKopWDXwVgCYanBA/9Xs7eD5RQ0TnfoI78nJhnDh9UAV43C
	MTQJce2IxD2W52UKCK+hwTWU+j81gnFHBVq3Q3ySjysBOpAhugn9CrO2ZxDbEpH8m2TGH855j74lN
	i5hnVSsc6V2bMRpdJjGXIjWThGcWmxeiAup2wDutAMNcJi8CGWWzKP77SwcBN30comga+Yipg8tBr
	P+kuw2wA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvKM-0002AN-Tu; Fri, 11 Jan 2019 11:50:18 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvKA-0001C8-S3
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:50:12 +0000
Received: by mail-pg1-x543.google.com with SMTP id v28so6219327pgk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 03:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6abORcUabUlyQ/4AP1uyvPR1q2RgpmyN10/gdUhWenU=;
 b=g7gHW/jWIMatBO2ENQA5SeXRuUX/6+SBSitd2LC02rG48Qav0QUTKMPvKqhqp+PIPo
 B17vysB8REO2mwgTVcJS2rLsQUkjzmafkzovfO4ZR04o7Xu8yIs58dZIcLV1fQ9oIFHf
 KRaGg5tEbFErZjiuevko6B4g1rStpuLJoimOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6abORcUabUlyQ/4AP1uyvPR1q2RgpmyN10/gdUhWenU=;
 b=a17QY3ENGEjh2wH71sMTQrv3ydQDcnXSzQUcg+OPR+EEVKnKXMz5wIeEINTu8JAAFT
 /TBqsGCca/KaQNiMcvvkByOsQDBnUWSvzSYmmuMmLh+HlbGB8Fk4GRRq17SyYYNkt9Ly
 dRXwYwi3uboFhNWMIXG7ZIBbINmn9jNG1FtGgSGgBcq5lkzfO77RiD8SQEy8Ob4WqZAU
 GgdfRH87MA8+7Mml3jsEqljAwNHHNXh8ucYVG4ukdNBji5xgJ7gYxEwgsqIS1OLw4dfo
 cXQg9p7wDjO1CkpRNcakoo0oRvjngraXCIwmIoyyi/6Jls8pA7BNn1+FLCLSC2/fudLK
 dzUw==
X-Gm-Message-State: AJcUukcg+4B++XEEvP+XXbBnAarZWA06YcyNcMY1CQFlNR+J6rY4DU/+
 gFj0WRrytJpNdgMwnKZMY2jBNaC5vD8=
X-Google-Smtp-Source: ALg8bN7XYNUYJM7hDizvK2p4tYdBY6+A0ZJZjunM2Hc/7vNmrrdGjYmjvidWWZisWpHamDADz/6l+g==
X-Received: by 2002:a62:8e19:: with SMTP id k25mr14208417pfe.185.1547207405038; 
 Fri, 11 Jan 2019 03:50:05 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.251])
 by smtp.gmail.com with ESMTPSA id b2sm143199988pfm.3.2019.01.11.03.49.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Jan 2019 03:50:04 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v3 1/4] tee: add bus driver framework for TEE based devices
Date: Fri, 11 Jan 2019 17:17:28 +0530
Message-Id: <1547207251-9372-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547207251-9372-1-git-send-email-sumit.garg@linaro.org>
References: <1547207251-9372-1-git-send-email-sumit.garg@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_035007_489465_298EC8A1 
X-CRM114-Status: GOOD (  19.75  )
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
 drivers/tee/tee_core.c  | 43 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/tee_drv.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 7b2bb4c..a685940 100644
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
@@ -1040,10 +1063,23 @@ static int __init tee_init(void)
 	rc = alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
 	if (rc) {
 		pr_err("failed to allocate char dev region\n");
-		class_destroy(tee_class);
-		tee_class = NULL;
+		goto chrdev_err;
 	}
 
+	rc = bus_register(&tee_bus_type);
+	if (rc) {
+		pr_err("failed to register tee bus\n");
+		goto bus_err;
+	}
+
+	return 0;
+
+bus_err:
+	unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
+chrdev_err:
+	class_destroy(tee_class);
+	tee_class = NULL;
+
 	return rc;
 }
 
@@ -1052,6 +1088,7 @@ static void __exit tee_exit(void)
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
