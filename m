Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72967C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F97D222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q6NiTMiz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cObDZdMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F97D222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0Ut7KUN9iR5jvfj/1K5aEovInr2vAHM2tz4vTXbDDnE=; b=Q6NiTMizTkmYuhV0wUVGXl64B5
	peuAJtFwqeEtdsJkz/HRDX/8zxcCzK+383a1C1BqR8iH2s1/w+NbHF94jGCJ7JFiNp9WBzp38q1PI
	giF581xIZZBWZAOvLzQ6vaxFYhMHaFuU9Jtr05VJ2TCUuhq9UMTntW8Xf2YlnyhshSdBgh779nMLf
	CTMbZeG4o9yvD/+6t9CpbQOk5h7y1J3rcusiw/OFYtsrgcpxj84wtyvN6RI5jcKk6bUhqbCRe0FT6
	6AXQksFEt2g1La5Z8g5ho10RdZNCkyuMB3psdY9ETUo1GAt4/7OZmal5MX4hkP3y4sXKFODI4sNqS
	s6lhBTjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbgt-0002at-Dz; Tue, 12 Feb 2019 17:17:51 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbfW-0001Jk-Im
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:16:31 +0000
Received: by mail-pg1-x544.google.com with SMTP id g189so1544787pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V0vDEzF3Mc5eeutz94nbRQZ6xPyugJQXobqfjuLKiSM=;
 b=cObDZdMvnlT9QoWFKtK5J0NH3yLnZBykk0W6O6czUdQ/wYALlhy+/89BGrRGgozWdD
 M9OBesQ2ZbzZmMEKzL3X5eFzKAfw5RToYyZFRGIjd7UT8ljdT3ekmZ0Up6mcbVozjiEL
 DRIx4WCIZNObHIFFf1/umNJU1yic69+R5q6hOLr5lBKjoZbkhQRA/D5TOqyaHIGld3P0
 8GHrzUVTDPRgUxbcQ1vy63emJiAy7J9y22QOVf8fiOd/y9RtvBtd4uP88uwaPSFIQjzZ
 +IOKPHt++r1IAu+P5vmeWCbjTOrYh7HW/LAof8xPoCWlwi7DRfpbGyGAjn1nMIBgh2Md
 TFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V0vDEzF3Mc5eeutz94nbRQZ6xPyugJQXobqfjuLKiSM=;
 b=UY7/RyL2vY8fTaj38nCMsENG9b+5OTOd7h/awHz8J81LrkXmQuG7mJcfENFUK7nn4i
 Sfn9stf+BN4dZagpEO/nVsqB5ta0bCiXUACXRPUPU+UT9d02Yjs1DDlRg07Y13+wXGPP
 muR5l7H3VD16nPefsuHJvMoIbTUp2iDPfO5MFedn0BkEcjUbp4W0rVvlQm65GBlMMMz7
 dY+pmd1jVx/dDhtp3ogjxkEWoVC8+nGLoDjrTfq7AgPnGJt3y0AxypdNkT6xl7n+u6k8
 dmVrUHSCsoi/74euE9T2QvV9fScEjTJJZSQEu2dqlyc5/4ymMtkPqrLrDfR1NCB+OC+m
 LA2Q==
X-Gm-Message-State: AHQUAuZ1ZtUtg59PBkKjaTiKMsnkMoy3UML5CrZXlT6eNsRTVjrRHCUr
 L4GO1WkXij2aqqHP//ibmBWc1Q==
X-Google-Smtp-Source: AHgI3IYKR0kXyO4xGvlkymDUvl4GyOnjKTSy8Wr+bhwCgfEF5lwn2EwlWC9Wtp1KVNdkwoOwPklo7Q==
X-Received: by 2002:a63:c345:: with SMTP id e5mr4571313pgd.103.1549991786088; 
 Tue, 12 Feb 2019 09:16:26 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 09:16:25 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH 05/13] perf tools: Fix memory leak in error path
Date: Tue, 12 Feb 2019 10:16:10 -0700
Message-Id: <20190212171618.25355-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_091626_993718_6BF57480 
X-CRM114-Status: GOOD (  14.69  )
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

Memory allocated for variable 't_params' isn't released properly in the
error path of function cs_etm_queue *cs_etm__alloc_queue() and
cs_etm__dump_event(), something this patch addresses.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3011c6cae531..aac07f950074 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -175,6 +175,10 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
+
+	if (!t_params)
+		return;
+
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
 			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
@@ -206,14 +210,12 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, NULL,
 					CS_ETM_OPERATION_PRINT))
-		return;
+		goto out_free;
 
 	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-	zfree(&t_params);
-
 	if (!decoder)
-		return;
+		goto out_free;
 	do {
 		size_t consumed;
 
@@ -228,6 +230,9 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	} while (buffer_used < buffer->size);
 
 	cs_etm_decoder__free(decoder);
+
+out_free:
+	zfree(&t_params);
 }
 
 static int cs_etm__flush_events(struct perf_session *session,
@@ -379,7 +384,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 {
 	int i;
 	struct cs_etm_decoder_params d_params;
-	struct cs_etm_trace_params  *t_params;
+	struct cs_etm_trace_params  *t_params = NULL;
 	struct cs_etm_queue *etmq;
 	size_t szp = sizeof(struct cs_etm_packet);
 
@@ -461,8 +466,6 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 
 	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-	zfree(&t_params);
-
 	if (!etmq->decoder)
 		goto out_free;
 
@@ -475,6 +478,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 					      cs_etm__mem_access))
 		goto out_free_decoder;
 
+	zfree(&t_params);
+
 	etmq->offset = 0;
 	etmq->period_instructions = 0;
 
@@ -483,6 +488,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 out_free_decoder:
 	cs_etm_decoder__free(etmq->decoder);
 out_free:
+	zfree(&t_params);
 	zfree(&etmq->event_buf);
 	zfree(&etmq->last_branch);
 	zfree(&etmq->last_branch_rb);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
