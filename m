Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A5AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A72222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M7RrrWlr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+p+weP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A72222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=T7+UqzT/kH4rn5gTlV75GONdrxKS/j6L5pI4P2poZ2M=; b=M7RrrWlrotW7k5USAR1t3+vAGf
	TxOgCmOWrtoUjIxvqkMx/y5ays+5BwpaRZPzNIbDYPJWXyxkDbXBNrD1uzLsqhByN/rwcZWLBSYXS
	P+878nUHfvyk0bPfHoiX0w5CrnSp/xHEBWiucqwUhOCXyBdVPNc0Y3GQYKdwcmS7IkZ2TV7ng5B//
	rsfmLTpqnAVWKIolqkCQB4Z6IVdkrDN/VIram6XrQM7fLF1RVKvsI5CPj+YfXjXQMYzWIvPwuKTs/
	70TcKlUpUf50aJpypFXrggEgRYClxeGsKvFjOR/0+Gak9T7ZFK0n6z6sVKs6bALqqNkKrOLLH8GB0
	Wha0QcrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbhS-00037T-4j; Tue, 12 Feb 2019 17:18:26 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbfa-0001O9-1I
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:16:36 +0000
Received: by mail-pg1-x543.google.com with SMTP id z10so1542528pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+oNal5RstQ3YgpTY86Id5Pbgg+JpmJKHh+fQyKrDyG0=;
 b=Q+p+weP6kUGU7tzqY8/EauId7g4FmWlr24ilDKPKxgWckBycZcn62SX1aYAakhrvKl
 EU8uVaZezJhjYnlXKr8Xrd8N4mRuXMpf9oTz+R1x9TKN0zVI+Rj5wx2F7ySlvozeGlEz
 pQRLTS+UFyARG9yLiPEqEDuLtSrRXFVKUkFouKMYFkI79JeiA+JpIFU0xPb3TkHAQE97
 AuLbZOXkWItJBL4mP7/tiVWHEzSX8x1m1+Pg4Faieyd/LdmydSzjI+XwY9qlr7VSHXJp
 biACrsYOC4i0nvCD4972EwbxVtlHOZiz0ISWdlAMJiUJg+CV5vsgMLBCB1YY7ya0KddX
 b3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+oNal5RstQ3YgpTY86Id5Pbgg+JpmJKHh+fQyKrDyG0=;
 b=DyWlZAAzJ2Qs5fZc9jlfA9oxTrjDreablbNULyjoRVY2a2JNOFJV3EMp6Y3nCP0scZ
 c7kSiY9Cctma/z+xltgPXYuw6Ab4bjmUbrqASwIQ/UsyfuS6WNAAw/XZD5cisMI5bQln
 OJBb6HWaUVHbHYLSbaudByrzwluJs33+A+FTrGbAYC3cniQml6e4+tHjrclTlSD7mk/s
 CEUh3cWXFYeJS1b3MCyDVZHK4pHWUXhISY34ez4lZTYpqiARpO9HemDfO2mBqupUA+gk
 k2zDFOVcnDAvzrmhhHpQxjoTrULiQA0MyFYInbHkuAtDXWaFIJbpOfREnPhUd68CyeyB
 q5+A==
X-Gm-Message-State: AHQUAuY+YIkB6UwDUnOE3ne6Q4Po46wfQLD4GwkGWIGKW5XWoMXuYw/m
 bV3+UZNaEDAV1R9QHqJS+7E0dw==
X-Google-Smtp-Source: AHgI3IbfBAR1VsGCY/BgB3gelyUX9VPc9ORlkx/PGdh0Z5eHFdoEzUeTUezqIiaDPz95weNM4jHBWw==
X-Received: by 2002:a63:574e:: with SMTP id h14mr4369440pgm.336.1549991789518; 
 Tue, 12 Feb 2019 09:16:29 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 09:16:28 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH 08/13] perf tools: Cleaning up function cs_etm__alloc_queue()
Date: Tue, 12 Feb 2019 10:16:13 -0700
Message-Id: <20190212171618.25355-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_091630_513348_53BF836C 
X-CRM114-Status: GOOD (  15.59  )
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

Function cs_etm__alloc_queue() should only be concerned with the allocation
of memory for the etmq and accompanying decoder.  Everything else should
be done in the calling function.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4cc9fce97a86..c9a5b4935209 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -405,8 +405,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	return len;
 }
 
-static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
-						unsigned int queue_nr)
+static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 {
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params = NULL;
@@ -444,12 +443,6 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (!etmq->event_buf)
 		goto out_free;
 
-	etmq->etm = etm;
-	etmq->queue_nr = queue_nr;
-	etmq->pid = -1;
-	etmq->tid = -1;
-	etmq->cpu = -1;
-
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 
@@ -479,10 +472,6 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 		goto out_free_decoder;
 
 	zfree(&t_params);
-
-	etmq->offset = 0;
-	etmq->period_instructions = 0;
-
 	return etmq;
 
 out_free_decoder:
@@ -503,24 +492,30 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_queue *queue,
 			       unsigned int queue_nr)
 {
+	int ret = 0;
 	struct cs_etm_queue *etmq = queue->priv;
 
 	if (list_empty(&queue->head) || etmq)
-		return 0;
+		goto out;
 
-	etmq = cs_etm__alloc_queue(etm, queue_nr);
+	etmq = cs_etm__alloc_queue(etm);
 
-	if (!etmq)
-		return -ENOMEM;
+	if (!etmq) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	queue->priv = etmq;
-
-	if (queue->cpu != -1)
-		etmq->cpu = queue->cpu;
-
+	etmq->etm = etm;
+	etmq->queue_nr = queue_nr;
+	etmq->cpu = queue->cpu;
 	etmq->tid = queue->tid;
+	etmq->pid = -1;
+	etmq->offset = 0;
+	etmq->period_instructions = 0;
 
-	return 0;
+out:
+	return ret;
 }
 
 static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
