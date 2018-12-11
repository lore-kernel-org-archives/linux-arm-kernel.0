Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45F4C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:42:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CE02082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GGpl4spp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PM3xYxmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CE02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PWvzRB/WJebNgf+zzS6IK+wCqHY2wCjvLUtHOfFR3d8=; b=GGpl4sppYodNiHCcLbnORRy1eH
	svpToq8lPC6qJ5tHUJaPlZ0dywhhSbYkrT3ZBdIfmwTRj1lY3+8ONYl58rMPGxwof+QzIqZTTgWZl
	w04QeoNmx4uihAZ+8PkKPto+rzPgTTFccnv3mZlLP1XsM+Msdj3wz8UE/yh10RQJnoAk6ndqXt1xl
	/c9UYu0fQ7s9BIjf0JaRjbV66cYyo6XFdUKqm52G3rvfTic4JbgIRJ5aWbxyR9LVvESfdoVkQKSj4
	A8ZfVZM1qU5sE0VD4pC3D9/gPT9EtvH1hXf3z1iE07a0GrdZRKwxV74mPMGkPRW6Ah2vGbHh4mbWQ
	20KcMPbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcg1-0008Uj-66; Tue, 11 Dec 2018 07:41:57 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcf4-0007Rv-Ew
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:41:07 +0000
Received: by mail-wm1-x344.google.com with SMTP id y139so1074654wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 23:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8QxeFRHi4qMd6sFFXgNwZ7/cePOdaHaHqRD9zBqmzN0=;
 b=PM3xYxmRvN7QFw/ApSK0f06969XEiMhna7Uv/Jkq2k11tmt8+LvU9ZXYgOc6wBQV3w
 aVjr4v+dCjLpMjEdFy/3zVB5ocLwNsTODs0yUKijLmQFNzdLu0i1493yErLraGO5E5DE
 5OyuM+U8w0K60gn+K/R54JuWbGABvZCA3kpmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8QxeFRHi4qMd6sFFXgNwZ7/cePOdaHaHqRD9zBqmzN0=;
 b=ab4JzfaRr4CafuhBRc6GsQyWoTc/81ONb7Jcps09yIFZjbknBvv4sjXCzp2pgKCvTq
 KojVDhJJqWYbn3ZFuGr2QejyG/P09iJvC1WZPUZpRId976AWku3RfInuoOxJludG/hxf
 ySGw4/db4/SZUzI3buceIi584Q8/7pzjIIFQH1cIG755JH8/m6Kao5ICerlRjZle8zM3
 7NUA2rfixFnAHYI20hWmDAXEZI14hSRdu6EsPo3D4z4KpEZUaFHcaq8/jXDBQiRfdm4i
 o+Gunv1N6bAFDsIImY7DJcCupe6LqFRtJixiiYw+oLrU+L5DS12HipNtk3g28rHjauAP
 ZU5Q==
X-Gm-Message-State: AA+aEWarmuCVujdsc0xEb+1Rq31Svmm+5cUxaVMwosXMUPcrsiVBEEp/
 TND1PkPTEQ4Dy7oj4VB3E0jCzA==
X-Google-Smtp-Source: AFSGD/V00h7XRR/tjP7v2kH+nYU+zPbPOGUHxGQWpwdiB1CiowvpJtqWW/+Cdi+nSyfP6ggJfEH/sw==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr1354069wmj.0.1544514047002;
 Mon, 10 Dec 2018 23:40:47 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 23:40:46 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v3 5/8] perf cs-etm: Rename CS_ETM_TRACE_ON to
 CS_ETM_DISCONTINUITY
Date: Tue, 11 Dec 2018 15:38:25 +0800
Message-Id: <1544513908-16805-6-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_234059_284515_A1B22F66 
X-CRM114-Status: GOOD (  18.49  )
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
Cc: Robert Walker <robert.walker@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TRACE_ON element is used at the beginning of trace, it also can be
appeared in the middle of trace data to indicate discontinuity; for
example, it's possible to see multiple TRACE_ON elements in the trace
stream if the trace is being limited by address range filtering.

Furthermore, except TRACE_ON element is for discontinuity, NO_SYNC and
EO_TRACE also can be used to indicate discontinuity, though they are
used for different scenarios for trace is interrupted.

This patch is to rename sample type CS_ETM_TRACE_ON to
CS_ETM_DISCONTINUITY, firstly the new name describes more closely the
purpose of the packet; secondly this is a preparation for other output
elements which also cause the trace discontinuity thus they can share
the same one packet type.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 +++++-----
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  2 +-
 tools/perf/util/cs-etm.c                        | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 97b39b1..1039f364 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -390,11 +390,11 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
-				const uint8_t trace_chan_id)
+cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
+					   const uint8_t trace_chan_id)
 {
 	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_TRACE_ON);
+					     CS_ETM_DISCONTINUITY);
 }
 
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
@@ -412,8 +412,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
-		resp = cs_etm_decoder__buffer_trace_on(decoder,
-						       trace_chan_id);
+		resp = cs_etm_decoder__buffer_discontinuity(decoder,
+							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
 		resp = cs_etm_decoder__buffer_range(decoder, elem,
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 3819a04..a272317 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -25,7 +25,7 @@ struct cs_etm_buffer {
 enum cs_etm_sample_type {
 	CS_ETM_EMPTY,
 	CS_ETM_RANGE,
-	CS_ETM_TRACE_ON,
+	CS_ETM_DISCONTINUITY,
 };
 
 enum cs_etm_isa {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ffc4fe5..cea3158 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -562,8 +562,8 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 {
-	/* Returns 0 for the CS_ETM_TRACE_ON packet */
-	if (packet->sample_type == CS_ETM_TRACE_ON)
+	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
+	if (packet->sample_type == CS_ETM_DISCONTINUITY)
 		return 0;
 
 	return packet->start_addr;
@@ -572,8 +572,8 @@ static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 static inline
 u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
 {
-	/* Returns 0 for the CS_ETM_TRACE_ON packet */
-	if (packet->sample_type == CS_ETM_TRACE_ON)
+	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
+	if (packet->sample_type == CS_ETM_DISCONTINUITY)
 		return 0;
 
 	return packet->end_addr - packet->last_instr_size;
@@ -972,7 +972,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 		bool generate_sample = false;
 
 		/* Generate sample for tracing on packet */
-		if (etmq->prev_packet->sample_type == CS_ETM_TRACE_ON)
+		if (etmq->prev_packet->sample_type == CS_ETM_DISCONTINUITY)
 			generate_sample = true;
 
 		/* Generate sample for branch taken packet */
@@ -1148,7 +1148,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					cs_etm__sample(etmq);
 					break;
-				case CS_ETM_TRACE_ON:
+				case CS_ETM_DISCONTINUITY:
 					/*
 					 * Discontinuity in trace, flush
 					 * previous branch stack
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
