Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B029C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B6221B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="giSX6vW3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p+LzcDEU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCnCLwLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B6221B68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FwnCFmEzGmvKjmLtIB0MWOon1NJx3pEK1NmZADI/IdU=; b=giSX6vW3TjqnhA
	yR0qxXK35dbkUpnQ7ze+XQjSwKrMQ9URro7dp7Q65YKtkS6bTzMKa49N22qrxiw+mr8juIDH9c2n8
	y87YMruvDDd5lmbrwF1LX+UBO0BZuT5YmtfDENEXrhDmGmFQJrvy4f4lSp+AQAPzbH/k2N+AfIPFM
	ET7en2Sj7ER4XVFPJjy725REO9jEnnWbZt6mgmisa5wWtcfULIew6FA0pYTFeBqYpJ3cRXkq0TWE4
	vojH+pVX/vLpDDkwJljR07BoGh2iedBocvIvQ0XXQYF4p074jm51sKx9vgz0mUB/4lcsOF2wgGq22
	a8WKlGsTAOKGbYy1fhyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRgP-0005tq-EP; Fri, 15 Feb 2019 00:48:49 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRfj-000562-PL
 for linux-arm-kernel@bombadil.infradead.org; Fri, 15 Feb 2019 00:48:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ph6fdiVxcmW8XtXa5whDwKhP3LOHYplxekgagmVEN9k=; b=p+LzcDEU48N01ijgf6nI4kHteU
 AZARje0sjOYjr0JrTEhbrT/Ni5Deef0hh/zPI2X1BR5xprUlBmrf2BpIbGkaFRSEbwL5is7ixNby+
 khhP2VNIX6QM/1gukyE1X/Dl06OURImxS/1XRYGZ3S79olzHMGQRGXxkvLTQQTkTzXToQXPWOSFrw
 +Mt7uFc5K6r6nj4O0eeIy7etUhPKnLgH8Tnuo7LqgE81V2wh5oKDq/lJnL6Us3yYgk/BGGh4klCjV
 k6ECpBD2PM648KlWJohBtas37SLShrp17R/r9qC5MN6FXrEkOutzKOg6BH1beF4lNNt2TjQehtJqy
 5OJPYIWg==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRfd-0005VC-4K
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:48:03 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 86E172229F;
 Fri, 15 Feb 2019 00:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550191679;
 bh=T354beYzSKX9jaLyEiLMxRWSCwNVNXXElIwYhxrdRy4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LCnCLwLi4KMpA1TxI3aIASI4aE7Q2bPh3PLq1VM5GAH1Hgc0IDrMsE4aVdtVQNQw/
 1gpQBK6ykXxkVzCpuzxxcU3QkEaUrUDxtopneOK4wgEKjXYSueaUpdmV11gggPBYDF
 BPhkebYjCAiDVJlaIlYzMSCmW3T2ufey5py3gS9c=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 30/43] perf cs-etm: Cleaning up function cs_etm__alloc_queue()
Date: Thu, 14 Feb 2019 21:45:26 -0300
Message-Id: <20190215004539.23571-31-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_004801_516532_8C4F4781 
X-CRM114-Status: GOOD (  16.35  )
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulouse <suzuki.poulose@arm.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Function cs_etm__alloc_queue() should only be concerned with the allocation
of memory for the etmq and accompanying decoder.  Everything else should
be done in the calling function.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-9-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
