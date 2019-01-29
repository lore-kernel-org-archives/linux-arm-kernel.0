Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111A8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C190E2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h4xApQs+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h62oC/St"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C190E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7ivLlyHe5HQR4vUlEeWw6D6tvLv0vpF5Y9taC/oORJo=; b=h4xApQs+RUtGgZSOHdb+7sG2dd
	lH390I4Rq0K8MOLslixCSQdCTk6TY2AZaWmXHeQ+DwubAfa5XznJMOSxBSCO7uJd3x2p62fj6hDfo
	xwYasyJoQQ/MklKinOi1sr9PUE4irNPInhzU02FBnBQWS9suDIva46DV+G2k6wAKHLizOlLnQo4xj
	p0V0Y+TtUpuaH9IQL3q0+fj+RWSkHBfwtIv9S8qrzI7U2HMaQ+u6q6Cp7FyBeW+47RzuTkocd8MZM
	RaOqtVLuQ0S1iGHFvuVRXkjkavx4xlPfHVPRKiEEdbNx9tFwQCYUa/wI92xrqltNc1QzZy6OqJUTi
	fq60IuGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goSXW-0007bH-Dq; Tue, 29 Jan 2019 12:30:54 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goSWe-0005bk-OW
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 12:30:09 +0000
Received: by mail-pf1-x443.google.com with SMTP id b7so9583158pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 04:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wCTfSFlK4C7FXgdKOX/CUsRQoqsszJ7JLDVdsKNX608=;
 b=h62oC/St4ysiVkeDn5+gNpBIxbddW/cR8Q7J5/A4VfBEdO0y1pPxXkDwcdTwEhsCOm
 HNrpKoUj0H8ltawqSDNgqMqrVX/gJchBmGIGkmYSr/HNTHnt1Aca8ZxacPUkQyhGRnEA
 kJnGIKcu8w8fqD5SjPk8Ip/Q2CnCFfeYeflJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wCTfSFlK4C7FXgdKOX/CUsRQoqsszJ7JLDVdsKNX608=;
 b=BzZzizGTVStwsrFsE9UqgQED01+B+UcJgH1luNInV4VUizykFU0F3Bzu2U40lYpaqu
 j5SlGLyQ0Le5QKo9maRw0C4ULcnLWlS0AUVmQ/DrsHzkXBdTJa6g2oxVVaB7AsxiJz7S
 R9hwpGP30gpETMe5OEJ45VzM81KsOzYvXwEojVn3UynGnZ/jforsFLE9lq9yyKUsBoy8
 RJvHjklQgW0vvG6XE85GPuFSC18wB9e7E/8KI4g2A0G3Ez4xuKrvyvJCs9bzEE7ze/TL
 R4+XRjeKfVgWehus26ZgzwezXsbchTVmlnvxK6O9bsoPXP8i057fNEgYD0zzG6guEF5Y
 yQ9g==
X-Gm-Message-State: AJcUukf6nYbDCtDjjqN17igOQS9XejDcWj2/gsz0qSjawYUj92GZgaQi
 uHD5io/xkNsXs4vMDZtncHNG5g==
X-Google-Smtp-Source: ALg8bN7GGisxap8BzjpfSfJJKj8wKKM0wCnICyIxgBjGKAPZeZb9sXA5hMJdWa6IS2QMyg1L5EDyiQ==
X-Received: by 2002:a63:2586:: with SMTP id
 l128mr23899786pgl.104.1548764999906; 
 Tue, 29 Jan 2019 04:29:59 -0800 (PST)
Received: from localhost.localdomain (li569-141.members.linode.com.
 [192.155.82.141])
 by smtp.gmail.com with ESMTPSA id h64sm59552502pfc.142.2019.01.29.04.29.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 04:29:59 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v7 3/8] perf cs-etm: Set sample flags for trace discontinuity
Date: Tue, 29 Jan 2019 20:28:37 +0800
Message-Id: <20190129122842.32041-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129122842.32041-1-leo.yan@linaro.org>
References: <20190129122842.32041-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_043001_360905_3598B85A 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: Leo Yan <leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In the middle of trace stream, it might be interrupted thus the trace
data is not continuous, the trace stream firstly is ended for previous
trace block and restarted for next block.

To display related information for showing trace is restarted, this
patch set sample flags for trace discontinuity:

- If one discontinuity packet is coming, append flag
  PERF_IP_FLAG_TRACE_END to the previous packet to indicate the trace
  has been ended;
- If one instruction packet is following discontinuity packet, this
  instruction packet is the first one packet to restarting trace.  So
  set flag PERF_IP_FLAG_TRACE_START to discontinuity packet, this flag
  will be used to generate sample when connect with the sequential
  instruction packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d05cac5295f1..1aa29633ce77 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1111,6 +1111,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
 static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_packet *packet = etmq->packet;
+	struct cs_etm_packet *prev_packet = etmq->prev_packet;
 
 	switch (packet->sample_type) {
 	case CS_ETM_RANGE:
@@ -1170,8 +1171,26 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 		    packet->last_instr_subtype == OCSD_S_INSTR_V8_RET)
 			packet->flags = PERF_IP_FLAG_BRANCH |
 					PERF_IP_FLAG_RETURN;
+
+		/*
+		 * Decoder might insert a discontinuity in the middle of
+		 * instruction packets, fixup prev_packet with flag
+		 * PERF_IP_FLAG_TRACE_BEGIN to indicate restarting trace.
+		 */
+		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
+			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
+					      PERF_IP_FLAG_TRACE_BEGIN;
 		break;
 	case CS_ETM_DISCONTINUITY:
+		/*
+		 * The trace is discontinuous, if the previous packet is
+		 * instruction packet, set flag PERF_IP_FLAG_TRACE_END
+		 * for previous packet.
+		 */
+		if (prev_packet->sample_type == CS_ETM_RANGE)
+			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
+					      PERF_IP_FLAG_TRACE_END;
+		break;
 	case CS_ETM_EXCEPTION:
 	case CS_ETM_EXCEPTION_RET:
 	case CS_ETM_EMPTY:
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
