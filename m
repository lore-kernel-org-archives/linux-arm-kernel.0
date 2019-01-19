Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E225EC5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:45:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20BD20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kf3gSwKE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PiMbxk9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20BD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=svKAcOv5jKLeId89ARMPztDIftkUW8PJT1z2cg+Jizk=; b=Kf3gSwKEp8cu7TkzEG3drXy4HD
	YfFL5Bj6RHYxm5PiVUwKnHHhBMVbArCpPQ9ZG4xOsKgRk4T1iKm9t5uMsCNJPPsGczM6gKaUTHgse
	SMJXE2tEUWxYNd6ACkTzcJW38Qv+bi/sbmFVfMeZB1gS4S+XJOeopKYAiRdGinoozffPXpcU7Wb0A
	Sfm1AoTzivzLo/We/H6pMovCU8ciAnRFxiy6Bc8X90VhHQARLOYiu7fanGBIMv1TMlWzERHecFmkm
	3YxyrWll07nbmVzQxkaK8cVtmEe+mKVX6/+UgysZEKcXeTmJmr+pzJEzD8OpwBhGFnpeaULuem6NR
	DOESNBCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkfgs-0002Bk-CO; Sat, 19 Jan 2019 01:44:54 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkfgH-0001aY-GK
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 01:44:21 +0000
Received: by mail-pl1-x641.google.com with SMTP id u18so7095575plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 17:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=apzqr2DPBRKwMWYdw7mN2gcZix8iFxXQD+UIs2uAD/8=;
 b=PiMbxk9o8YY2tVjT3ff/E+/k0qmzfKhgGNsgDhImweyyi3d6rdLRJL2sTjMAjzFyx3
 kNoFWUkUmRpDfUJGqWEtwRE5WiItb8AOQRRnrGKmMgSG9N5WulWUt4ln5TA6zoeBlKxm
 2k3tLnjb+Cc5RyA8fu959FOaaWTwFmPK+7zWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=apzqr2DPBRKwMWYdw7mN2gcZix8iFxXQD+UIs2uAD/8=;
 b=rh/naMV/bq7O90d+0BZjxtEg6rujQSyyVGDo3vin1cPy9x6JIkA5jzZqcH3AB9cxRn
 1lRIrRWm49fpP1YO3wc3Z2ZuRG9gq3Y1iFX/l0aArLqwKOI4dqVB2TFzvwEecos4LPuy
 pFoLMTYUyPU65ucC8tYO6b3ERb7XeJMEovLL9vE/1X0X/3bVAWDJCTwOydYfenL+4SU/
 ckyXojcJd84Y39kP2viswo7eQI3msyVc2cAxzEgC+3oKhepsjjgQkjWaUbBdMapUrYux
 Bc/phbbSwKv9CFkUvDPRH/UqisWWwgdvWiMc8TRioOpnFP2AA8sXy1eoKXzovDYQnP/D
 gUPg==
X-Gm-Message-State: AJcUukcSqHGIjgC9YfAGF7jgJ2PVH2K26z+ebcuNc4QQpUZ+Ri8mOMwI
 GqkFUtlo6TmvrP3bQ9wRNlaeFw==
X-Google-Smtp-Source: ALg8bN7L0udZa+Jgulh1FhMV7DgtEu9RnqPT47+s4IM+f4moeb7hKUvS8qH7Oq64zzeIW9ntvKZfnA==
X-Received: by 2002:a17:902:2969:: with SMTP id
 g96mr21194637plb.295.1547862256537; 
 Fri, 18 Jan 2019 17:44:16 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com.
 [50.116.3.24])
 by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 17:44:15 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v6 3/8] perf cs-etm: Set sample flags for trace discontinuity
Date: Sat, 19 Jan 2019 09:43:42 +0800
Message-Id: <20190119014347.27441-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
References: <20190119014347.27441-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_174417_785912_A5914830 
X-CRM114-Status: GOOD (  13.61  )
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
