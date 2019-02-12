Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222DAC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DF5222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p5eaP2oG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzyNQMny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DF5222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BXxX31t/O6wWpB2UEfm/zwHgdWZ7Mynbbw82XnZVgzs=; b=p5eaP2oGzk7mGwDMiWgtYWDe2I
	pZP/Oun2I0ElQNXWzPWuL2AcI2yD+jMrrrToc+8lcfllyIUFHRPfGMvz6WDkpWwyeVxEHq9IwzMSI
	DdTb9PoAoMR6L2JG0gA6cpGe5GC12QPlW8IzrwNO5bjmbNcYbL6XCpNGcVc/DTucMH+4Q7K4F7lXN
	v9BihNFyU0vb/Dx3kXLeJcgvSMcXpPKp8v9JvvCs6/hIDn81ubV44M9n8BEZVqCnpl2wf7S+fby4J
	5s3XOYHFXWI3ZYyqGTrNvcC3UHQzi8zbAHcwaj+IbuIrwG13fG5XNabTzBF38MpQBWobvxGjSm6u5
	QcqDkcsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbhg-0003M2-F4; Tue, 12 Feb 2019 17:18:40 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbfY-0001Mj-TN
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:16:36 +0000
Received: by mail-pf1-x442.google.com with SMTP id n74so1586894pfi.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XOTxqo9OH5aLAc5Vxl6Hirh4+uNIGwOwzNR9lCBfbZ0=;
 b=TzyNQMnyrMRx6Y03GfKuRDaDoyBCPgxtVbwbn+yIjf7NIdqbElgGSzg2CYYQ6OGLh6
 XvT6xAW3yQT5YqEcw9iqBEU1XZOVLOHM5SLE5L+exa1VCE8dkm9fXvMhg4sC+V2QJi/A
 5CuG2AOCjjHGJ2Ok8wXOC1QVlS7gYQq5frcZWTEMtLrUNh59UpMJ8zTJ6EiFQUu5L+Ce
 TE58F/dufPL/i3irM2lthKRkJhcMTrRx2eoxQ8w/a39eMxcfKiKzRIND7iyZzVA+xYum
 UXQbZq17Mz4stq7GIvAvkgRke/Wtr2TF9/BhRb8bWwoPblOIT6MFE2hoIv3s7U9K2nME
 VgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XOTxqo9OH5aLAc5Vxl6Hirh4+uNIGwOwzNR9lCBfbZ0=;
 b=JeY/Rj7k49Ew5KkzcUzyLCTXoQrcWOAokT4Yk+qGwybNjSoxz642HH6QxpFosb0GEp
 d9QbwvqL72VvdjvpasuuV7Vp0XcSwtm8pClohWGu9PxF6isR62SErNks9NJ2LoHOo7Ur
 7E3sYtjOyitz90NU//PoUmliCsG4XAKVPF3dPjchultySqrY88Rx3m2HeCyafWsaAw+B
 dfz8U515iRUX1386qesjV5Nk88XO29pABaHvRUOfu65p49q/vcUiCEUhfLjlRI3TCUTU
 8DAYCuvemRoUwP3Lvf+uZBOAupa8hgbkTjnmyjZTvop7pHvucZ9lFT9pkzHg3dLJcdi5
 XRbQ==
X-Gm-Message-State: AHQUAuZ9GXArWlRV5f4Zwb9nas84G3z3XLqTszZkYxLjqRQAxMkHP9Bq
 6UQK+fXH9F1T+EmBZ7YyE2LGdg==
X-Google-Smtp-Source: AHgI3IbyEQPXS5XlqajkeNC3crlslWESDoQrWKmidpETwW6xhgEji2GKIaZtV/f8cxfDXsvk7PdGgg==
X-Received: by 2002:a63:a:: with SMTP id 10mr4523207pga.121.1549991788408;
 Tue, 12 Feb 2019 09:16:28 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 09:16:27 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH 07/13] perf tools: Fix erroneous comment
Date: Tue, 12 Feb 2019 10:16:12 -0700
Message-Id: <20190212171618.25355-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_091629_426916_1752D755 
X-CRM114-Status: GOOD (  13.19  )
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
Cc: suzuki.poulose@arm.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, leo.yan@linaro.org, jolsa@redhat.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The comment just before initialising the decoder is plane wrong since it
is part of the decoding queue setup function and the operation code
specifically mention that trace data is to be decoded rather than printed
out.

This patch simply fix the comment to prevent people from getting really
confused.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f3a6dfaf3026..4cc9fce97a86 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -459,7 +459,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (cs_etm__init_trace_params(t_params, etm))
 		goto out_free;
 
-	/* Set decoder parameters to simply print the trace packets */
+	/* Set decoder parameters to decode trace packets */
 	if (cs_etm__init_decoder_params(&d_params, etmq,
 					CS_ETM_OPERATION_DECODE))
 		goto out_free;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
