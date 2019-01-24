Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4AEC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:55:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D894218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pVABPKKN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGNKJHNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D894218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=+ZO4C4G0/Cu3piL4fmwF2k9mMmHznJwf/H9eLhRK0g0=; b=pVABPKKNgO6pJnuU/EH6UHkVAC
	cVGqW8Ti2n9FCehU5eGBU0UONKXSmJldwrr5IPgtik56HQ4uN0gAZgmkpsc6QEKra3wZAjE843N7H
	i4ugiYWd3eonDL9fjUXcmPi4+xXbIu74GGmrJf4S8XiaECgqFChCXJceo9yVWBi52pP9M1zkeBFbo
	m99bYZP9Ps09og4RYTyb2bYIWw2jKzP89MQBMiQqu3XyEjpYjOTISQgkSm20XF5xMRC0G70M0NOAE
	FPphNwRdQTuyuToxs7aaOldQeSQwacGboz/qCEBmjRSqOrLhRpKoZu3M1KwyjcpRAdbXaPSCr6hBM
	9vITNjGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmXzE-00083s-Ur; Thu, 24 Jan 2019 05:55:36 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmXyw-0007lt-Ae
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 05:55:22 +0000
Received: by mail-pl1-x644.google.com with SMTP id b5so2388201plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 21:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uCrF0MHFiiOEn/l4nkIlAADg2vAfaRqdogSuqFtzV9k=;
 b=JGNKJHNfB8OpS+iqfBYSqEZmTbwnhdAh72JuR+u7tWudBZETFbpORniJwId0PaTomh
 MnQK0pINot+0uTLkzC69EkObthIGj9NdWyGDjya6f04uljmgqMgxf7b97X0/G2LtZBH2
 kWRKG8CCYHWouyTsX2tEfQus59wm7apcMSyvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uCrF0MHFiiOEn/l4nkIlAADg2vAfaRqdogSuqFtzV9k=;
 b=G2xegRUr/5WA33IcYVTQk+IQtxWUgWf/lzKrLbo/5HYyg0cUXlfRxcaDO0CNSCYvik
 +l4X4iHgNKoHrKoBv6/eAlxWyst2BwBa9F3OmKwx3ysQNyfFKmZyTLaqWpY3KnfpDI8G
 CROBI9Lt4RQTw12x2qxRs1jhjLgeb3cR7M1p6T8rbigJbP9nWI3qoS6cS25joOUgUqcI
 XOuICNq2tyJvgbYzVU+XSXsgSb1y7cFrOJwsWQ2WZ8dBoq96u0SMe9AgF6pMcY86UFDV
 /1ZsdPprvTmHKZ4iqe4REi1lXMQJMY877FNmS2MhW7sBgWhQUNxhbGA0CM6cuMjVkdJP
 i7gw==
X-Gm-Message-State: AJcUuke1S3OKtQEhPRCZrBknSiwZCYK7x5KLJ7jb2cpjX7EF35MCv+MS
 LxL+i9Kd92mJ6ysaFw6WaSw09g==
X-Google-Smtp-Source: ALg8bN6ldiMHHBIFS2VBhl+ZRCCYNNzvlKEAWtoexLEWKT9BE7xEVh7a5Ihwaj/R+IK9ToXMpW0jtg==
X-Received: by 2002:a17:902:6bc9:: with SMTP id
 m9mr5165878plt.173.1548309317693; 
 Wed, 23 Jan 2019 21:55:17 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.31])
 by smtp.gmail.com with ESMTPSA id i2sm32297287pfi.66.2019.01.23.21.55.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 23 Jan 2019 21:55:17 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: jens.wiklander@linaro.org, herbert@gondor.apana.org.au,
 ard.biesheuvel@linaro.org
Subject: [PATCH v5 2/4] tee: add supp_nowait flag in tee_context struct
Date: Thu, 24 Jan 2019 11:24:37 +0530
Message-Id: <1548309279-5281-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548309279-5281-1-git-send-email-sumit.garg@linaro.org>
References: <1548309279-5281-1-git-send-email-sumit.garg@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_215518_475452_5C67ADDB 
X-CRM114-Status: GOOD (  16.40  )
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
 daniel.thompson@linaro.org, michal.lkml@markovi.net, arnd@arndb.de,
 gregkh@linuxfoundation.org, bhsharma@redhat.com, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, yamada.masahiro@socionext.com, robh+dt@kernel.org,
 linux-crypto@vger.kernel.org, mpm@selenic.com,
 linux-arm-kernel@lists.infradead.org
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
index 9f4c8bc..2612dfa 100644
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
index ce957ce..56d7f1b 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -50,6 +50,11 @@ struct tee_shm_pool;
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
@@ -57,6 +62,7 @@ struct tee_context {
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
