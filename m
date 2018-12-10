Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47741C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:54:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDEB2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="trimoYL3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hh5hvVJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDEB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=l7cHAVWkHk8/rev8aRMorXfk3sv96h00Co7GZOgO2fc=; b=trimoYL3/9aSjcYi/+vhQoO2I7
	eLnkcDeG+XTM0HQBdZkOI6kYMVPpRl5cLzFBpugveKS1SzW6wASzvJ0G+ueik33YWPfHErUufUyHH
	zEOwWcWJfTKaryu4qWJeep1rcAbrKXTuWsCYY7tSinGPnGYY22dtvhOcQJrXUkh1sc4mLH6wywoPb
	mUKE7lL8EuGT4wIkXEzv/Fp1n0fjDvwh2pE0ejwZdv+kjoby57S9zOOFIA9L698++z6UHo72QO1Pj
	2skFiVjmn8RbkYg+HyyxjfI5+VgjS/PbAMybCyoL6DmhYRxhp1vGgs0s2yZ1MkJhhrphFlxnzn3Iq
	n303yFHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHKU-00005f-Gw; Mon, 10 Dec 2018 08:54:18 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHJv-0007ov-FQ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:53:46 +0000
Received: by mail-wm1-x343.google.com with SMTP id y1so9956959wmi.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 00:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UxbO/7Yb84DOLHcddrUr5aAiSlOBxbFaQ0ZxQ1p5BBE=;
 b=hh5hvVJ5pHoSWCWWZ4ZmtUGrWZD+w0mM5NhzpjThGctwh0L3Or/PAdk/IJ1Iqjiu9r
 XY0Okn9BmXzk08RMy52CyfRQzV2PJQmE9XSCGz+PYuGN7SkmbTRzoqhQkcuNlvNSXKuG
 /q+2uvk6kzBOoMoUmQcSZKwPG5PfDFp9JoUuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UxbO/7Yb84DOLHcddrUr5aAiSlOBxbFaQ0ZxQ1p5BBE=;
 b=Vmv5ZuE3mMKD4I9gqVx2RYWDSBaaqhfHOuaDbct5HfBrbgjuVfoing7zBpjG5r7HuP
 orYZ5r4m06fU/WT6fsFefImViCi2v4DMWXSFR6t5bNGU/6bU+5gVC1XMuE2mWKBWr/I8
 VIoxHLFYpsU+saCRHaVqP5uMjJAM5bAi6egiM+a9S1Q6ZEaKQg0vXZBJ2cE6eA45b6pO
 eP6nDoS4jgUD7oZ4ik+FD7ZkImrp1dZlvW+GuW3FZkcAomm/me0bqzHA8DZrbeVeh0CR
 XkdJ30OE/JcMhRexzn5/zeJq7Veeo5Ztn8yiHaIyr1/ISMcvAtpzPC9H3RKCnO3rrLlU
 zWCg==
X-Gm-Message-State: AA+aEWai8KH6hyqRyAAkjXg79PA+zunvMkMb0txqO/8xN8+a61fIz8u5
 d5XndbLx4qSuHEfmfZl9SRX0Dg==
X-Google-Smtp-Source: AFSGD/WRUR3xNVnCicw5S6FhCqSkqpH8hLIU6WTOW9PKdP9MOd/1EhBJOX+dyWBHD3fZXRGHisTMnQ==
X-Received: by 2002:a1c:8d49:: with SMTP id p70mr10506505wmd.68.1544432011789; 
 Mon, 10 Dec 2018 00:53:31 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id m4sm9097351wml.2.2018.12.10.00.53.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 00:53:31 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v2 3/6] perf cs-etm: Rename CS_ETM_TRACE_ON to
 CS_ETM_DISCONTINUITY
Date: Mon, 10 Dec 2018 16:52:58 +0800
Message-Id: <1544431981-24144-4-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_005344_374029_98751A26 
X-CRM114-Status: GOOD (  19.87  )
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

This patch also refactors the enumerations in cs_etm_sample_type by
converting from bit shifting value to continuous numbers.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 +++++-----
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  6 +++---
 tools/perf/util/cs-etm.c                        | 12 ++++++------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 0b4c862..a3994f1 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -391,11 +391,11 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
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
@@ -414,8 +414,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		decoder->trace_on = false;
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
-		resp = cs_etm_decoder__buffer_trace_on(decoder,
-						       trace_chan_id);
+		resp = cs_etm_decoder__buffer_discontinuity(decoder,
+							    trace_chan_id);
 		decoder->trace_on = true;
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index b295dd2..a272317 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -23,9 +23,9 @@ struct cs_etm_buffer {
 };
 
 enum cs_etm_sample_type {
-	CS_ETM_EMPTY = 0,
-	CS_ETM_RANGE = 1 << 0,
-	CS_ETM_TRACE_ON = 1 << 1,
+	CS_ETM_EMPTY,
+	CS_ETM_RANGE,
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
