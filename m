Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BC7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:54:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305A62082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hD8tIPrS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiIUh07K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305A62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5J1miP4b9hHzcxU/DN8NSJLbxlx1qFc1h+/Wiwl2AmM=; b=hD8tIPrSCobwBUennA0iJ76Tkc
	QJnhCgOqM9V7NTbrx/kG/rTQC3PzSZk9cO/JsimVk2mWvruA7D6Rkmcp20k4BL5YENhIXlzpftnyY
	kulcDD6kyQ8havLjxz1ydgFVmQrV9OTy8m+XHEF5txeeFRhPchKlWZpo8m9Ap7uO6VwnJU6IdGqhj
	W34QJeFJjZs9Ped4zLec31qZS1jkAY3ICh567zdni2zuOaO+5IFzxt09mzz3tjJmJXX5DvsWAcKQb
	Zj9OO5q+C83Ls8CqCml/dFVEVuVSrv9Gf0RaekMRHcFS9OG/HiqZl6IXS5en6XxjMXFnV6pXJGrJJ
	f4pMLLiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHKu-0000P9-Rb; Mon, 10 Dec 2018 08:54:44 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHJz-0007sC-Ux
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:53:53 +0000
Received: by mail-wm1-x333.google.com with SMTP id a18so10323332wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 00:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WgMRTLtOLhYT8FlarRUnYgdidlPs5flIzaegKvjmyYI=;
 b=EiIUh07KJ15nJAm0JkYmA6j0bfQk4wTHlH9S3w0vtyejd92gNNVA5+lB0Eg1QJSXxS
 znaz8c/sHTTuS60A565mN+yxnk5kPhiU58zhjcfDiArb+dsolwlfdQ/COw1ppFfum8nb
 FiwC5dTXlXR6XSd/DmNcLcKosB7fM4xj0KPIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WgMRTLtOLhYT8FlarRUnYgdidlPs5flIzaegKvjmyYI=;
 b=CdfEQbwaWXYbcgPlM+9785ZWqoPPC8kub92BQLHQc9roPoyktCCrf5NaEwn+yiRhZ7
 5mBvLM3csASq97yqxfbj1Baus+UU2TZRYhNXJ5CV3pdJYxLgeSZ0TggsyQP7aZsrClfU
 J+wvzjN1MA9qYA/y/Ku+z3tkTcmAp/YrNajwkNv+dmBlb0wK8uLqq2b+LK8EGwFoAfeh
 82+GEOnv27d1Sk826z/RbE47HeEszRIByQgCgWgHE2DLMEZOAbmIbB5hB4RD1zsqLW5B
 og90NNdumoUB6KwVxuo8AI59DRbIGNHinfBfg8K8fcBAPbqgsh73gBwYAmb9ps1XobUn
 Z1wQ==
X-Gm-Message-State: AA+aEWZtJhm3bYxDzkUJ3Udz6192ZZJL8ayI1J0hj9cpGXK+l5TgcWvs
 0rH4zQChMPhFaxUfHV/j7n13JQ==
X-Google-Smtp-Source: AFSGD/WSXfc8yKKG9ujEQqfUTAEU+FQc1AK54t1aAmHlrcluJAloPpPjcl35cY6wEhgiunaE3kAnsA==
X-Received: by 2002:a1c:a485:: with SMTP id n127mr10064898wme.15.1544432016030; 
 Mon, 10 Dec 2018 00:53:36 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id m4sm9097351wml.2.2018.12.10.00.53.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 00:53:35 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v2 4/6] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Date: Mon, 10 Dec 2018 16:52:59 +0800
Message-Id: <1544431981-24144-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_005348_313452_F81E4DEF 
X-CRM114-Status: GOOD (  13.03  )
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

CoreSight tracer driver might insert barrier packet between different
buffers, thus the decoder can spot the boundaries based on the barrier
packet; the decoder is possible to hit a barrier packet and emit a
NO_SYNC element, then the decoder will find a periodic synchronisation
point inside that next trace block that starts trace again but does not
have the TRACE_ON element as indicator - usually because this block of
trace has wrapped the buffer so we have lost the original point that
trace was enabled.

In upper case, it results in the trace stream only inserts the
OCSD_GEN_TRC_ELEM_NO_SYNC element in the middle of tracing stream, but
we don't handle NO_SYNC element properly and at the end users miss to
see the info for trace discontinuity.

Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
output from the decoder, but both of them indicate the trace data is
discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as trace
discontinuity and generates CS_ETM_DISCONTINUITY packet for it, so
cs-etm can handle discontinuity for this case, finally it saves the last
trace data for previous trace block and restart samples for new block.

Credit to Mike Leach and Robert Walker who made me clear for underlying
mechanism for NO_SYNC element, Mike also shared with me for detailed
explanation for why we can treat NO_SYNC and TRACE_ON elements as the
same, so this commit log reused most of his explanation.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index a3994f1..46b67f1 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -411,6 +411,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
+		resp = cs_etm_decoder__buffer_discontinuity(decoder,
+							    trace_chan_id);
 		decoder->trace_on = false;
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
