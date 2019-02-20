Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD413C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:03:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D62A2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VKIC90X6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCfZdzVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D62A2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=6meH52j7DIhNPZ9454Kh6ATbAS7EHYColn/Zk2VFvj4=; b=VKI
	C90X6bWpA0namBnMf/Daywnhhy32iudTIt3SZGknhLVLDz/pNkh5EDCb+zrlkHw9a14NmaGLFV6IH
	YznfbA/q5mpT9h+5jy0Wukf5nEWTaghi0o4NuojKwyvyYumdO6OB1i7uXE7l6Ibg3/plA3GyjyWF6
	aNY8Dk6jFu8ZN1vZ9E4cR3CoFJHycZw4TpD1Xvz8Z0LnpbeBLwhW/UzkUwxlwPU6ca4+rPJyRKeSo
	Gi1LlZ4rdCkBAeKXyJ5Jgjv1ySMvQxmJnTG1fJv9Q+5I+E1COowg73DtZO9Rfq0WNQ28+DgmyJPaL
	SBup8bwu5gNF7j0GCVDh42PsMHaW3Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwKyB-00011l-NB; Wed, 20 Feb 2019 06:02:59 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwKy8-000115-HF
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 06:02:57 +0000
Received: by mail-pf1-x433.google.com with SMTP id c123so11391701pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 22:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=d6A0igDOsc3jNLySuAErsWHOJjhNYwodP/Hd1Anf35E=;
 b=lCfZdzVfUjOoBZ+L8AhBPSXnJxoCCXiZL2BEUhM0u/EDD5wRHimQtqgOVKdwAGdkAQ
 Q/oXwg6XKdb5HBpqN1JMFfKNQe3Aci1BcQO8YnMU+CDAnSNCTUyamtg7rPp/1wqvWbsI
 P0sW1zttfI77GPUv8JNKqWo6ssEN3oT8rGc+Px7yzx9311+98ohUXhTG0GSXvulA3B/g
 lRy4Vl7wfN6DdNoxzKljPaUgS3r7r2Zpyre01RJ7KAeNgfMXp+/zerRWN+knm+QbPHDJ
 uNLbESWIvEEsxf+c/la+zTkeLUQexa4kEL6gjivyE9Tj/wh7zQ4HEwT0XZ1W1Y29dwT6
 wcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=d6A0igDOsc3jNLySuAErsWHOJjhNYwodP/Hd1Anf35E=;
 b=iphwSkIvor/IC7/S9ZfTf09NXgIZKZGiA9jenUkBfYQXPO6lIJ9KBRWwa7JAUQ/h2T
 lKW7xFgGTZL342tyTK3qKB9nOL1YPjDteheTj/xjxkmYOgNSgwRfJ/BClzN28uV63RVl
 SbHEAP+cer7ituI7MCgxaeEjRtHDdUGfT601sSAFAtOV3kjvdipk/IUSKr8JvVuFa6PS
 bEouDQsKYDbxFLkNlyDXD6SsNGdsZfPlQmpy4CIr5e929m4zh16QNdKEB1d3zcyyTtq0
 pG+DqIqKOzBUP5HJvv3sGzqslAmet9Q53Q/7hK3jqMCmtRQP1N7C2tPP2QAkv52TJm/m
 C87g==
X-Gm-Message-State: AHQUAuYOyrFHv77/XRfri309FkJhVNSzkBus1ofswtFFcwHD2pgWy4oH
 QGhh9vfQSEPyvaDK2+cc+ZLJ0A==
X-Google-Smtp-Source: AHgI3Ibb7+OEMMx+PAtTLBwWXLV97iKaVhnzkebAn/EsMfiF5pX9uBo7SLQ3+kYLg/Npf9UoKhQNWg==
X-Received: by 2002:a63:5b1c:: with SMTP id p28mr27045620pgb.73.1550642573331; 
 Tue, 19 Feb 2019 22:02:53 -0800 (PST)
Received: from localhost.localdomain ([117.252.69.94])
 by smtp.gmail.com with ESMTPSA id z1sm27945835pfi.155.2019.02.19.22.02.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 19 Feb 2019 22:02:52 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: jens.wiklander@linaro.org
Subject: [PATCH -next] tee: fix possible error pointer ctx dereferencing
Date: Wed, 20 Feb 2019 11:32:27 +0530
Message-Id: <1550642547-21968-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_220256_603649_8C25CD2F 
X-CRM114-Status: GOOD (  11.65  )
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
Cc: Sumit Garg <sumit.garg@linaro.org>, linux-arm-kernel@lists.infradead.org,
 dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add check for valid ctx pointer and then only dereference ctx to
configure supp_nowait flag.

Fixes: 42bf4152d8a7 ("tee: add supp_nowait flag in tee_context struct")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 25f3b9c..06fbfc0 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -993,7 +993,9 @@ tee_client_open_context(struct tee_context *start,
 	 * tee_client_open_session() if any in kernel client requires
 	 * different behaviour.
 	 */
-	ctx->supp_nowait = true;
+	if (!IS_ERR(ctx))
+		ctx->supp_nowait = true;
+
 	return ctx;
 }
 EXPORT_SYMBOL_GPL(tee_client_open_context);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
