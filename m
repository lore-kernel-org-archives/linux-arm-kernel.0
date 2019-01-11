Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712B5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:50:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF312064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jG7+FoKz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdQYo3km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF312064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MrwJxGGjnZgrV3aYPEruiLoSF0e+w+G4NkEtezqDKPo=; b=jG7+FoKzJ2jEmmBnBAa157x/xC
	029Lafw3GNBL3lEsA8AIbtHb19FJXHmpjZMQ9FCJNa3XqhGJE4Zdbtfy+v9vVia67yXIumKLSy5Hv
	zqV3KS3Wz++7riZt25HEOrI2XIqFmt8BUqotTm/7/ksiEJZicnNtJbuG7gCsfrORSAKh9Eslg+oLN
	ddLVihVujQVfTx2MKeckOaYCak43yy7FrWFQYASbDLpGTCNNsu1Heovk0BMOJnbs228bwNDcGk6Up
	OynQCnFzYf+vhtyIOUb8B022xBRmD14rJO01+M1v+niOysH8iPukupRTE5Ag4jUlLi9EYxYMtZsA7
	BBdf8jSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvKw-0002d1-Ki; Fri, 11 Jan 2019 11:50:54 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvKO-0002Cd-IP
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:50:30 +0000
Received: by mail-pl1-x643.google.com with SMTP id z23so6698386plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 03:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dnEldj1krFnyBcZ28g4diO0QN2WcNK+iA+Bx1sW0hq8=;
 b=fdQYo3kmCkeAaNH1504R+ZjcZ/Mjnh+9oIiMFWuuYZyF1sCzUoufwO8ibOFWopjGlu
 58aiX9toAVA6qVouHFDMwwvHG2UsF53zGcuUgQWfg5GVNfd9zBNS1W8tnrfdW55hkhZa
 BODyTYz8kDJSrUzT7hmV51jHt44lzeNwmjSc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dnEldj1krFnyBcZ28g4diO0QN2WcNK+iA+Bx1sW0hq8=;
 b=gJsoDMCjUgad+ibBWKsPmUblBe59Dz7NkmhlC86LUcor/NaaMoTTUoCUY0WuldHBsI
 WTkI4tJ0Amw3qkN0LxxiVhuPy96U26xLa7sK6GGhKk9mqo5UhBQku10EUQoi7ih10b1m
 kdxC38w9wYvPqmAPQQF258LYdNjcAFJwWLf9s/438HRKEyF6MQtUMyYq7e7TXxbVulim
 zJ/fXpmOks/TA51CR0dPMveUws+j/AfhQb7ZeKaWTyxGrZ6fiLE/fOZ/zwop/r+e1tWv
 0QnAYIS9dY4Td96SBDt1ImTx8PF6tXLLEkQlHjKPnCdLd46U9fG+y3741HL+VcplYknZ
 aEEg==
X-Gm-Message-State: AJcUukfbVWjqC9P/0P1Yp5rCgol1ao+WFWA+BctK0QxxwMwcE7vwCy2j
 9Iu2E5jrCJQVUehye76RJj1JcJdj3Cg=
X-Google-Smtp-Source: ALg8bN47uMTKJ6y7QGDpdfwmD/V75F+OT+Lp8WzfGCJF3JxhXZsWkzxD+U5auXEyisk57G70N0arkg==
X-Received: by 2002:a17:902:6b83:: with SMTP id
 p3mr14242950plk.118.1547207419680; 
 Fri, 11 Jan 2019 03:50:19 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.251])
 by smtp.gmail.com with ESMTPSA id b2sm143199988pfm.3.2019.01.11.03.50.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Jan 2019 03:50:19 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v3 3/4] tee: optee: add TEE bus device enumeration support
Date: Fri, 11 Jan 2019 17:17:30 +0530
Message-Id: <1547207251-9372-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547207251-9372-1-git-send-email-sumit.garg@linaro.org>
References: <1547207251-9372-1-git-send-email-sumit.garg@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_035021_867547_AD103EA3 
X-CRM114-Status: GOOD (  18.26  )
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

OP-TEE provides a pseudo TA to enumerate TAs which can act as devices/
services for TEE bus. So implement device enumeration using invoke
function: PTA_CMD_GET_DEVICES provided by pseudo TA to fetch array of
device UUIDs. Also register these enumerated devices with TEE bus as
"optee-clntX" device.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/core.c          |   4 +
 drivers/tee/optee/device.c        | 153 ++++++++++++++++++++++++++++++++++++++
 drivers/tee/optee/optee_private.h |   3 +
 4 files changed, 161 insertions(+)
 create mode 100644 drivers/tee/optee/device.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 48d262a..56263ae 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -5,3 +5,4 @@ optee-objs += call.o
 optee-objs += rpc.o
 optee-objs += supp.o
 optee-objs += shm_pool.o
+optee-objs += device.o
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index e5efce3..ac59c77 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -634,6 +634,10 @@ static struct optee *optee_probe(struct device_node *np)
 	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
 		pr_info("dynamic shared memory is enabled\n");
 
+	rc = optee_enumerate_devices();
+	if (rc)
+		goto err;
+
 	pr_info("initialized driver\n");
 	return optee;
 err:
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
new file mode 100644
index 0000000..987e552
--- /dev/null
+++ b/drivers/tee/optee/device.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+#include <linux/uuid.h>
+#include "optee_private.h"
+
+/*
+ * Get device UUIDs
+ *
+ * [out]     memref[0]        Array of device UUIDs
+ *
+ * Return codes:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ * TEE_ERROR_SHORT_BUFFER - Output buffer size less than required
+ */
+#define PTA_CMD_GET_DEVICES		0x0
+
+static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
+		return 1;
+	else
+		return 0;
+}
+
+static int get_devices(struct tee_context *ctx, u32 session,
+		       struct tee_shm *device_shm, u32 *shm_size)
+{
+	u32 ret = 0;
+	struct tee_ioctl_invoke_arg inv_arg = {0};
+	struct tee_param param[4] = {0};
+
+	/* Invoke PTA_CMD_GET_DEVICES function */
+	inv_arg.func = PTA_CMD_GET_DEVICES;
+	inv_arg.session = session;
+	inv_arg.num_params = 4;
+
+	/* Fill invoke cmd params */
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[0].u.memref.shm = device_shm;
+	param[0].u.memref.size = *shm_size;
+	param[0].u.memref.shm_offs = 0;
+
+	ret = tee_client_invoke_func(ctx, &inv_arg, param);
+	if ((ret < 0) || ((inv_arg.ret != TEEC_SUCCESS) &&
+			  (inv_arg.ret != TEEC_ERROR_SHORT_BUFFER))) {
+		pr_err("PTA_CMD_GET_DEVICES invoke function err: %x\n",
+		       inv_arg.ret);
+		return -EINVAL;
+	}
+
+	*shm_size = param[0].u.memref.size;
+
+	return 0;
+}
+
+static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
+{
+	struct tee_client_device *optee_device = NULL;
+	int rc;
+
+	optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
+	if (!optee_device)
+		return -ENOMEM;
+
+	optee_device->dev.bus = &tee_bus_type;
+	dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
+	uuid_copy(&optee_device->id.uuid, device_uuid);
+
+	rc = device_register(&optee_device->dev);
+	if (rc) {
+		pr_err("device registration failed, err: %d\n", rc);
+		kfree(optee_device);
+	}
+
+	return rc;
+}
+
+int optee_enumerate_devices(void)
+{
+	const uuid_t pta_uuid =
+		UUID_INIT(0x7011a688, 0xddde, 0x4053,
+			  0xa5, 0xa9, 0x7b, 0x3c, 0x4d, 0xdf, 0x13, 0xb8);
+	struct tee_ioctl_open_session_arg sess_arg = {0};
+	struct tee_shm *device_shm = NULL;
+	const uuid_t *device_uuid = NULL;
+	struct tee_context *ctx = NULL;
+	u32 shm_size = 0, idx, num_devices = 0;
+	int rc;
+
+	/* Open context with OP-TEE driver */
+	ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
+	if (IS_ERR(ctx))
+		return -ENODEV;
+
+	/* Open session with device enumeration pseudo TA */
+	memcpy(sess_arg.uuid, pta_uuid.b, TEE_IOCTL_UUID_LEN);
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
+	sess_arg.num_params = 0;
+
+	rc = tee_client_open_session(ctx, &sess_arg, NULL);
+	if ((rc < 0) || (sess_arg.ret != TEEC_SUCCESS)) {
+		/* Device enumeration pseudo TA not found */
+		rc = 0;
+		goto out_ctx;
+	}
+
+	rc = get_devices(ctx, sess_arg.session, NULL, &shm_size);
+	if (rc < 0)
+		goto out_sess;
+
+	device_shm = tee_shm_alloc(ctx, shm_size,
+				   TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	if (IS_ERR(device_shm)) {
+		pr_err("tee_shm_alloc failed\n");
+		rc = PTR_ERR(device_shm);
+		goto out_sess;
+	}
+
+	rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size);
+	if (rc < 0)
+		goto out_shm;
+
+	device_uuid = tee_shm_get_va(device_shm, 0);
+	if (IS_ERR(device_uuid)) {
+		pr_err("tee_shm_get_va failed\n");
+		rc = PTR_ERR(device_uuid);
+		goto out_shm;
+	}
+
+	num_devices = shm_size / sizeof(uuid_t);
+
+	for (idx = 0; idx < num_devices; idx++) {
+		rc = optee_register_device(&device_uuid[idx], idx);
+		if (rc)
+			goto out_shm;
+	}
+
+out_shm:
+	tee_shm_free(device_shm);
+out_sess:
+	tee_client_close_session(ctx, sess_arg.session);
+out_ctx:
+	tee_client_close_context(ctx);
+
+	return rc;
+}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 35e7938..a5e84af 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -28,6 +28,7 @@
 #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
 #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
 #define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
+#define TEEC_ERROR_SHORT_BUFFER		0xFFFF0010
 
 #define TEEC_ORIGIN_COMMS		0x00000002
 
@@ -181,6 +182,8 @@ void optee_free_pages_list(void *array, size_t num_entries);
 void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
 			   size_t page_offset);
 
+int optee_enumerate_devices(void);
+
 /*
  * Small helpers
  */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
