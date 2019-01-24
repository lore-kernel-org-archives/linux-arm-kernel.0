Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E31AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:11:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D52421855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nqCwae/P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrW4JPf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D52421855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=GXS+/wKbWCdTo9zfJkOUeYLceSoZSzkj7CP5lF8Qbcg=; b=nqC
	wae/P+aV4Mj37ZZ7Z9gaFSfva0uB/u3xhNHQthnFF7VAoT8h4p0JdG0BTy66HKfplAZlV4VEyAvfR
	JMtX0UrcL7oyDgi4VI4b0rf1GPt/+xnQZiJ+5mJmqyCdsHDvCTCJX5yg98lo2q3TcNqER8XmdKu0e
	TPe7YWoLzyJxMvNgQTgPfFIuzQYZ0xnvDEEMp83iERf+EP6OB7yqwznxYVFn/lMBg8PqCosWjlfZm
	oLfaSUe5pufXfnlTsGVM2sB8Eo3oPZdl0mw2skjicYiXB6aCA1xzIP2R/PKFMfLWN/qdupBDEyhw1
	Z6/Kho8niobb9Xyr/U8ibGCNfxeEXmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmenR-00010G-OZ; Thu, 24 Jan 2019 13:11:53 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmenO-0000yN-Ve
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 13:11:52 +0000
Received: by mail-lj1-x243.google.com with SMTP id u89-v6so5207964lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 05:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=M5kM16zyd/EiORNWuO/i8/IoR4fv7qnZKxV0scf9zO0=;
 b=VrW4JPf/trBoEUxZFLak6MnFQ8yOzjvXFGiMb9sx4ubbFBi75cuglw5eeLfxqPelMv
 YDQn+65yjQci49S3NHEXhk0euqnRBJOmnh4MkX8rwNcftqwRL6HMR8JioMqEn77rhbdB
 Usa/rr9JJXzLGo+AIYKstriVHWDkesqk60pIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=M5kM16zyd/EiORNWuO/i8/IoR4fv7qnZKxV0scf9zO0=;
 b=HzGUBmg4nQBkd9U6XKAvM7GwGIVADG+b/KT2J5Vj/cw0/5dms1vvJk1Xwk1Wt5xsIq
 tEtXALfCmfT9m33MOVcOPI8/7x/ayYZ9osCvu3BzwetqIKf9Q0HafJcoD0es9pR4cELp
 xx08VR1Q9nLZKQJjyqOTmr1iZ0v4u07Iualhy4D0v8A5XPfAUa0PolzEa5VtcTEd0oai
 xQoOb06Rag6+bR/UKkln4GKXKcS3eIn644r3kJ71FKQCf8dNRJrS4ap89MQORTudWASj
 ZmKhnYlRDMGpqhhB4wcokIPeTbpzU2SVFtxF4Z5PQQyH5ldNzKyi7dEY/9Qv1tLsGMQn
 Sacw==
X-Gm-Message-State: AJcUukcT9/p6lPbrs49OWRq8DGcNrsr5Xy68T9nn9dsCMcnxiH0O8U3g
 73UGbb+qHegXnHJXHZS2JNa5Jw==
X-Google-Smtp-Source: ALg8bN6/8ayVgXcnEBPQ8Fuz4g3lfP7Kq2EuzDauja88HlWUbwnFuy8qiW726xfHyP5pgA9VqBr7Gg==
X-Received: by 2002:a2e:a0d5:: with SMTP id
 f21-v6mr5576293ljm.98.1548335503991; 
 Thu, 24 Jan 2019 05:11:43 -0800 (PST)
Received: from localhost ([195.238.92.223])
 by smtp.gmail.com with ESMTPSA id 18-v6sm982144ljg.83.2019.01.24.05.11.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 05:11:42 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@linaro.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 tee-dev@lists.linaro.org
Subject: [PATCH 1/1] tee: add cancellation support to client interface
Date: Thu, 24 Jan 2019 15:11:41 +0200
Message-Id: <1548335501-7868-1-git-send-email-igor.opaniuk@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_051151_028388_A2D937BA 
X-CRM114-Status: GOOD (  11.63  )
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
Cc: sumit.garg@linaro.org, prime.zeng@hisilicon.com, jens.wiklander@linaro.org,
 jerome.forissier@linaro.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support of cancellation request to the TEE kernel internal
client interface. Can be used by software TPM drivers, that leverage
TEE under the hood (for instance in TPM2.0 mobile profile), for requesting
cancellation of time-consuming operations (RSA key-pair generation etc.).

Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
---
 drivers/tee/tee_core.c  | 12 ++++++++++++
 include/linux/tee_drv.h | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 7b2bb4c..aba71a8 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1027,6 +1027,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
 }
 EXPORT_SYMBOL_GPL(tee_client_invoke_func);
 
+int tee_client_cancel_req(struct tee_context *ctx,
+			  u32 cancel_id,
+			  u32 session)
+{
+
+	if (!ctx->teedev->desc->ops->cancel_req)
+		return -EINVAL;
+	return ctx->teedev->desc->ops->cancel_req(ctx, cancel_id,
+						  session);
+}
+EXPORT_SYMBOL_GPL(tee_client_cancel_req);
+
 static int __init tee_init(void)
 {
 	int rc;
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 6cfe058..62a0b56 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -526,6 +526,20 @@ int tee_client_invoke_func(struct tee_context *ctx,
 			   struct tee_ioctl_invoke_arg *arg,
 			   struct tee_param *param);
 
+/**
+ * tee_client_cancel_req() - Request cancellation of the previous open-session
+ * or invoke-command operations in a Trusted Application
+ * @ctx:       TEE Context
+ * @arg:       Unique cancel request id
+ * @param:     Session id
+ *
+ * Returns < 0 on error else see @arg->ret for result.
+ */
+int tee_client_cancel_req(struct tee_context *ctx,
+			  u32 cancel_id,
+			  u32 session);
+
+
 static inline bool tee_param_is_memref(struct tee_param *param)
 {
 	switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
