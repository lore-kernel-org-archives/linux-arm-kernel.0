Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D68C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D002F222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sGCedNZO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IakIojWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D002F222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MKo3h2Enx4VAWOwDXZ2CIy3JjBwQPSS5u2c/qSbXhJs=; b=sGCedNZOaZpV86OxPQrzmv+xGT
	VJ2rwTsZ3lT8GhcT0dD/qZeDGVqYbWuaVFJHrMIKqXQvCam46DLRcf9VcW+tk7T1sOuj1m8tnhf1C
	gu8Iw0tXnJVWiqT6cN5pDSURkP3mOf4F5/xqqCmQk1qTEYgXpHdDmYgTHEC4IofBRergArtD3tekB
	uIAzhVxflNiEvABzHYZT8DzVzYEUX1t99E7SGUBwGpOkZEyiNl70HMEy18D9lRGNmpI+3vNdtsDHj
	FTQ3QPmUosqjU6PHwDbQKKol35HDO0fl5VsrFq6yA8B14pLzBvHQMxhHWea7ZM4hkSabQ/UDVyNyd
	O2n+IK4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbg6-0001sL-Nx; Tue, 12 Feb 2019 17:17:02 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbfT-0001HX-5k
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:16:24 +0000
Received: by mail-pg1-x544.google.com with SMTP id r11so1546106pgp.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VCeE+fVe6sOPfIScwVf+tBPxTH5OVWtBxrO1s0RcHJI=;
 b=IakIojWrVhLLuunKXwwN4iY4XDiT0UcS3/3wk8jIMBLxEkKEYFPIytjPBl0G/M45oy
 eAkA1XwPou7P12w14qY2H2PWiXTxCEJALNrYPPwQfbxobxcLs5Jnzcm87oyN0A4u4v7A
 pX1gg3cbtN6KNoA+2Mw5Vl1BYGpEX8vnqUpJV210HchPYaPVmu9/q/2ld8MuGtyCrBJv
 uDLQpBy386ikkiecyTPEkggRObY58Y2aX+2rMKEuOg8a2WO1EtUSzZKVmfoVvXpLy1zt
 oyR/VaKnp9BlTMDaFcKTA8FgbrGEErj/v/rpVce3Q8YThiGHpj2Gk0nbfxshcVp+imC3
 jWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VCeE+fVe6sOPfIScwVf+tBPxTH5OVWtBxrO1s0RcHJI=;
 b=sAqQtSOF3M0Xr8GaRecgw15btHjIskWEQoTrf4vfTAiJ2RO7eaPnlCqbkyTpo9mSQP
 e2q1tqaXv3o6g4pyIXnXVWtvad5DwSeqXP53R0RiVvi1ceZjzW4bly37hsELiK8F3+4i
 UW4dFrUj6zbcv18hpWI9i/RHkU/JMCY9TthM64MtALlzY9oY4XcF13S0mB3qOI5xvBJh
 od7LskGxPHyKlX7C4zMxyeLSME+IvfgKi9MIAyi22WsPXRG1NcTN7IZtpyL6RWy3sgJ+
 IZlwe/bAvRaJhb7UyBjtYOM1wkEWS1mM2r1hlNIw5EAMoGP2zTS/SfMhRiKe5bQnhZ+z
 sG7g==
X-Gm-Message-State: AHQUAuZi58W+2QkU6rJ1WZ/G4xFgmOwqDOnijVGy8idN08tf09ydY802
 arFZB8Eu/ALSd2+bwNoXejJl5Q==
X-Google-Smtp-Source: AHgI3IYDQJ50KAjYQ3/cuGL5b4e47X/ziZL9vx4vc2EdDCeAGWMRdssrnfB4hNNwuLy8liTp1BSTAQ==
X-Received: by 2002:a65:6491:: with SMTP id e17mr4540223pgv.418.1549991782641; 
 Tue, 12 Feb 2019 09:16:22 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 09:16:22 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH 02/13] perf tools: Remove unused structure field "time" and
 "timestamp"
Date: Tue, 12 Feb 2019 10:16:07 -0700
Message-Id: <20190212171618.25355-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_091623_217402_70C68D28 
X-CRM114-Status: GOOD (  13.22  )
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

Field "time" and "timestamp" in structure cs_etm_queue are no longer used
and need to be removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
