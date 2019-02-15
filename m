Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A16C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25BE222D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V5xnweal";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuGtlp3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25BE222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jf3v3E3obbJp6PH7xsLsDObDyDtZFtGS3ncOhnOruZQ=; b=V5xnwealsA8jxW
	jQKg5eynEHUXGQxfkW2WyoeYFUrIyWewHYfSYA5SLwHnSpYk+F3mKgkd4IsN7n2Ne2nk67OGWLJds
	Xsm0VH9ZYO2eaIEpJ3DVy9zvzjNXJmPEb5/P5jgjeSNymDax3eJVFMt+3biS8/+VHGx9fds6S87yY
	tFEKMOA04VpCi+wpqWsOLXAbTosmRKHKVrNqImp3ZmfcQ5zjhMKhMBpVbjxe5Lw3kEeueuN/7+xxG
	wHRrdlTTuoLM7qzg8CZalKgRRMTLZjAS7FQ6f8X11LyYMucJxoV+PulLFAvo+vYA1O/S/BuyAuK3F
	iEVi/EoiULGIFFSalc1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRfO-0004fP-QH; Fri, 15 Feb 2019 00:47:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRfA-0004Nu-T9
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:47:37 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E1EC82229F;
 Fri, 15 Feb 2019 00:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550191652;
 bh=QIatHaw3Pd5ihg58PDRuNTKAZDK95EbTjHOpkdkaj0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HuGtlp3Ob8IeHmdrInDSqwbqnbmKQj/a+Ozr7S3TYLPKshbt/ejIT23YvK0meAVnd
 8EcpsglRAqdRDOlCl4D8vrlKy++0eoBNK6XR9NGV7Xp8Gg/pnF+hk3a6TKu1FuPjZd
 5gpO/G6apyG1HWqnt6ZFFlsmI3L+z4ohDwibTGjE=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 24/43] perf cs-etm: Remove unused structure field "time" and
 "timestamp"
Date: Thu, 14 Feb 2019 21:45:20 -0300
Message-Id: <20190215004539.23571-25-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_164733_144655_37D021F4 
X-CRM114-Status: GOOD (  11.03  )
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

Field "time" and "timestamp" in structure cs_etm_queue are no longer
used and need to be removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-3-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ebd68eb43da9..1d9419a0cf0c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -69,8 +69,6 @@ struct cs_etm_queue {
 	unsigned int queue_nr;
 	pid_t pid, tid;
 	int cpu;
-	u64 time;
-	u64 timestamp;
 	u64 offset;
 	u64 period_instructions;
 	struct branch_stack *last_branch;
@@ -82,7 +80,7 @@ struct cs_etm_queue {
 
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
-					   pid_t tid, u64 time_);
+					   pid_t tid);
 
 /* PTMs ETMIDR [11:8] set to b0011 */
 #define ETMIDR_PTM_VERSION 0x00000300
@@ -234,7 +232,7 @@ static int cs_etm__flush_events(struct perf_session *session,
 	if (ret < 0)
 		return ret;
 
-	return cs_etm__process_timeless_queues(etm, -1, MAX_TIMESTAMP - 1);
+	return cs_etm__process_timeless_queues(etm, -1);
 }
 
 static void cs_etm__free_queue(void *priv)
@@ -1583,7 +1581,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 }
 
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
-					   pid_t tid, u64 time_)
+					   pid_t tid)
 {
 	unsigned int i;
 	struct auxtrace_queues *queues = &etm->queues;
@@ -1593,7 +1591,6 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 		struct cs_etm_queue *etmq = queue->priv;
 
 		if (etmq && ((tid == -1) || (etmq->tid == tid))) {
-			etmq->time = time_;
 			cs_etm__set_pid_tid_cpu(etm, queue);
 			cs_etm__run_decoder(etmq);
 		}
@@ -1637,8 +1634,7 @@ static int cs_etm__process_event(struct perf_session *session,
 
 	if (event->header.type == PERF_RECORD_EXIT)
 		return cs_etm__process_timeless_queues(etm,
-						       event->fork.tid,
-						       sample->time);
+						       event->fork.tid);
 
 	return 0;
 }
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
