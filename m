Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DDFC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:30:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5B020989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z47SrDLS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bt8zc/t0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5B020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8bsjrfd9prDGbTAweQxb1PBKb3rT4nhhMrZpEiHH+UI=; b=Z47SrDLS6LxdVVHU5RYy1TPHDg
	cb3vJs45UvZ+ViV4JGbLhxkXnrTYJqAN9EKdI/QSaMEsuQFytHETybFz2P8NubK+mXQmflweLdSG2
	XGFMcudEpx4Vsleg+x6m2dqr3G07edXe9sE4ZEWBshjI87bp+qgIk3SnLWGi/iGcOLtec+6AzBVKK
	GRfRmuaMtzpZLzXzay+VkzckXVxqAgeAXAOws8arzLJzpMoAjM8vR6TgoM/LyRz2oYau52VxK3sB6
	fcGXwOLohQnKVRpSHngCm5EOs+EZ9Rq+zJqqEslfsNrhsB8oCVhq84f/PYBoXbhYN2lLCnP9U3jzG
	cwHXvbrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVue-0005Tw-VY; Mon, 21 Jan 2019 09:30:36 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVuC-0004AN-KL
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 09:30:14 +0000
Received: by mail-pg1-x541.google.com with SMTP id w7so9200818pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 01:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KVZe+JdIXEOq53OVAEyR9i83a9gBMP1LhsWNd9YK638=;
 b=Bt8zc/t0rEncfMEdzopClS60wNL6dg/68jiLQWvQvSVyqXf/yTbCxvq6JBHox1FYXx
 enWK7NNO+z4KeO6tGAh70/MMonVYsKehNreJak/U1sDsSw2/XY37qsCHch/zAjeP6LEV
 CGy1ui8bHhEqFZUFW9x8ukL+eYxR0GfQGYXHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KVZe+JdIXEOq53OVAEyR9i83a9gBMP1LhsWNd9YK638=;
 b=QCv0foh1zIBdris5BGfo79CxZkTCLWbg4mDyf7xnekn8QDUt8gvO2viInNv3faPjzS
 LAI5t2XX14l/DxA1CRN7kP5qjxYn8nZf0d8knGtPs6YnYPWDLsG09tNIlxICqRsN/e95
 AM+Gw8/1qzwdMb5tH++A2T/EEZB5WdwVX7aYUS9tbYf/d0sdIUmtNklvwYjlIBbLuGPK
 z0oNcMTZpfX43pwe+80BDRKfNqzznxXsctyGcwBA4ChfEgecvtql3Kw7WKu9OWnQGwui
 7ipvU3+Nn/3C76oh+jf0A3kzh/js1mSidpncrf1k7e9NgF+rwWB/DT7w5N5l9GNVHv48
 IoHA==
X-Gm-Message-State: AJcUukdeoQj8fe0Zc+RvIVXXj8tBI/kfSuoorAsbtkBimp2TTt6glROL
 KMt3vwioDVEezPg2PNxT1zNhSw==
X-Google-Smtp-Source: ALg8bN70J2rK0ct9ynM+tDCxdfFWPaj3IonQUPAizzbbXqYdJ+HPL5IZPHtdtIOVQnW76F/P/QAdMw==
X-Received: by 2002:a62:8949:: with SMTP id v70mr28459427pfd.85.1548063007852; 
 Mon, 21 Jan 2019 01:30:07 -0800 (PST)
Received: from localhost.localdomain ([117.252.65.115])
 by smtp.gmail.com with ESMTPSA id h9sm16182777pgd.53.2019.01.21.01.30.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 21 Jan 2019 01:30:07 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: jens.wiklander@linaro.org,
	herbert@gondor.apana.org.au
Subject: [PATCH v4 2/4] tee: add supp_nowait flag in tee_context struct
Date: Mon, 21 Jan 2019 14:59:17 +0530
Message-Id: <1548062959-31860-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
References: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_013009_597460_3463889A 
X-CRM114-Status: GOOD (  16.19  )
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
 daniel.thompson@linaro.org, arnd@arndb.de, ard.biesheuvel@linaro.org,
 gregkh@linuxfoundation.org, bhsharma@redhat.com, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, robh+dt@kernel.org, linux-crypto@vger.kernel.org,
 mpm@selenic.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This flag indicates that requests in this context should not wait for
tee-supplicant daemon to be started if not present and just return
with an error code. It is needed for requests which should be
non-blocking in nature like ones arising from TEE based kernel drivers
or any in kernel api that uses TEE internal client interface.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/supp.c | 10 +++++++++-
 drivers/tee/tee_core.c   | 13 +++++++++++++
 include/linux/tee_drv.h  |  6 ++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 43626e1..92f56b8 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -88,10 +88,18 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_supp *supp = &optee->supp;
-	struct optee_supp_req *req = kzalloc(sizeof(*req), GFP_KERNEL);
+	struct optee_supp_req *req;
 	bool interruptable;
 	u32 ret;
 
+	/*
+	 * Return in case there is no supplicant available and
+	 * non-blocking request.
+	 */
+	if (!supp->ctx && ctx->supp_nowait)
+		return TEEC_ERROR_COMMUNICATION;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
 		return TEEC_ERROR_OUT_OF_MEMORY;
 
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 55370d5..56222ea 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -105,6 +105,11 @@ static int tee_open(struct inode *inode, struct file *filp)
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	/*
+	 * Default user-space behaviour is to wait for tee-supplicant
+	 * if not present for any requests in this context.
+	 */
+	ctx->supp_nowait = false;
 	filp->private_data = ctx;
 	return 0;
 }
@@ -981,6 +986,14 @@ tee_client_open_context(struct tee_context *start,
 	} while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
 
 	put_device(put_dev);
+	/*
+	 * Default behaviour for in kernel client is to not wait for
+	 * tee-supplicant if not present for any requests in this context.
+	 * Also this flag could be configured again before call to
+	 * tee_client_open_session() if any in kernel client requires
+	 * different behaviour.
+	 */
+	ctx->supp_nowait = true;
 	return ctx;
 }
 EXPORT_SYMBOL_GPL(tee_client_open_context);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index ba985d8..a44374a 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -49,6 +49,11 @@ struct tee_shm_pool;
  * @releasing:  flag that indicates if context is being released right now.
  *		It is needed to break circular dependency on context during
  *              shared memory release.
+ * @supp_nowait: flag that indicates that requests in this context should not
+ *              wait for tee-supplicant daemon to be started if not present
+ *              and just return with an error code. It is needed for requests
+ *              that arises from TEE based kernel drivers that should be
+ *              non-blocking in nature.
  */
 struct tee_context {
 	struct tee_device *teedev;
@@ -56,6 +61,7 @@ struct tee_context {
 	void *data;
 	struct kref refcount;
 	bool releasing;
+	bool supp_nowait;
 };
 
 struct tee_param_memref {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
