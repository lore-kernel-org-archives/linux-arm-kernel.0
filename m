Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B71C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954B920665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ny+DQCY9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7SKdesZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954B920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bUZH7PylqQqHBu4OFs0uKjswtXCU2GXpv59EpIE8KiY=; b=ny+DQCY9ooFx6UiCNt4dwUXalx
	cjrgM5PQXghxHmS3AOCTxnuH6QMa0m8DCDNR6pslryDd3VgjlddsI4IfzkNjQHj6OvBwhi/Gp8gDw
	GxpCMGthi3M49VPPAMomj5zIIzJF7xDU619dVYwz3+TMfCqIc5nsdiDgTIHm0scuRWan7huI1iDy4
	Uxy80l58m+3g/X+RG7OiyE8aaj+iVlbSCdzR/zIxYJXPgLybeytIfJgRPOjDRG5M0wfiJaWg8Wqdo
	SaRLSysSDwNKldT4MMMcEmpE9LbaF6cxJOWunRG9HZVRltS4O/EjEJDp4EPyKkFV/r9kwu5zLke2S
	90xnNlNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZPq-0004G7-Cq; Thu, 10 Jan 2019 12:26:30 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZPN-0003r3-V5
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 12:26:26 +0000
Received: by mail-pf1-x443.google.com with SMTP id u6so5220602pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 04:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xmkcyMZKGPzMvMKxjtfmwiWNsAxxqPR66jDHmZbAgx0=;
 b=J7SKdesZLm6Y9+X6F2SsUmlo3xJzXD6shk9TFdntFYJZFwu+eCwEhAFHjhc5wmSEsm
 jbvAthFaklKJC+Z3Y78vA8b03Vv60Kcm8Txwoz4qjERSviQU1YXSC0o4tBfXDm96vYHp
 aemXD3QAeJnkKuq3CUrnnvJNosMSE1XFh2Yic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xmkcyMZKGPzMvMKxjtfmwiWNsAxxqPR66jDHmZbAgx0=;
 b=NJ12e9BB3C5yW19Qk4zTOhREE0+Es3FQBDnkgWdfJMyntbUjnEQTEVUGnSNe1W3rwz
 ZIAS4qTTgruBqJPopLOSUtFk3Qk5uDICtIWy7DdyJQoX2xOtVui6QXdJwGG6sCMZeA2b
 9CxAu6TMJ9zup/x+b1rhwiUR2PNP1y3IGzpBoZVYIOH494iIoN22YZRczr7qKa/PCKu/
 UMfwuovkc+UEv0w88PK7g9YgHK4ZlUNUAcyiqMV7DktEcl5VI5jwEFknVxptsGZWiU2r
 4U5NUln39v3swWM14oBW+I6pErFY6G56InhrxVcauQkbafd7BCMPvGXARiU71jNBfbFf
 9t8Q==
X-Gm-Message-State: AJcUukerPLB5m5XF6w/9meScM6I2BAmXw9CGMWwqOKNXug1SuMmoELt5
 +5fChaP4O2MKsncvHPNMqJVHEjQIagc=
X-Google-Smtp-Source: ALg8bN6ioSM9jYGnCYQdKNpJXazspwjwMQTGCEdrWP6BYVLiUtGDe/IxVnpJkVVOu7MfHw5wn7hgOg==
X-Received: by 2002:a63:ea4f:: with SMTP id l15mr9028354pgk.102.1547123161238; 
 Thu, 10 Jan 2019 04:26:01 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.251])
 by smtp.gmail.com with ESMTPSA id m67sm142985541pfb.25.2019.01.10.04.25.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 04:26:00 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v2 3/4] tee: add supp_nowait flag in tee_context struct
Date: Thu, 10 Jan 2019 17:54:56 +0530
Message-Id: <1547123097-16431-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_042602_546884_4DE2FD8F 
X-CRM114-Status: GOOD (  15.72  )
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

This flag indicates that requests in this context should not wait for
tee-supplicant daemon to be started if not present and just return
with an error code. It is needed for requests which should be
non-blocking in nature like ones arising from TEE based kernel drivers
or any in kernel api that uses TEE internal client interface.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/supp.c | 10 +++++++++-
 drivers/tee/tee_core.c   |  2 ++
 include/linux/tee_drv.h  |  6 ++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index 9ddb89e..5d6c317 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -105,6 +105,7 @@ static int tee_open(struct inode *inode, struct file *filp)
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	ctx->supp_nowait = false;
 	filp->private_data = ctx;
 	return 0;
 }
@@ -981,6 +982,7 @@ tee_client_open_context(struct tee_context *start,
 	} while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
 
 	put_device(put_dev);
+	ctx->supp_nowait = true;
 	return ctx;
 }
 EXPORT_SYMBOL_GPL(tee_client_open_context);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index ed16bf1..fe1a920 100644
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
