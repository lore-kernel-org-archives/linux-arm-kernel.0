Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6120DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:42:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C692082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i+B2Sy5C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+dbz6iU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C692082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xcegT0CPp4hskFCDrVRVswXmkqTCqh0EtanxNPIxBIU=; b=i+B2Sy5C+46g+K/HRNEiK8elrx
	DkvwS3YZFNDvEuhOUWew1HHUSwHJvOGlHok7JQeGGVe1dIJiFQi9jdmOX132DVA85MOwWciV5Rqq0
	byGakWKSeEW52uxiBgio+oJIKZBmvEPnZOwgloiDNVgRnyPSomaf5Pu9bM1qKVElsMgAuJiP1jqbl
	XFjBHsHU0E6w+4q6PPdPp6ZR1oK11RL62awD2wDfNPujN80CbCuT3gF7R5Kog1bTj37n2Mw9yMmsd
	+PnioHjWOyEZOSgr1bthSRuR6GUvmd75fx2ttXFs5BBSnZxm6wHqhB1obGS+H8gvdfdr/dlKIfGSr
	eqR3pyYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcgF-0000HP-Oy; Tue, 11 Dec 2018 07:42:11 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcf9-0007Wi-7d
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:41:11 +0000
Received: by mail-wr1-x441.google.com with SMTP id 96so12986695wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 23:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=s6aboUTCwaj4TA/VXlzMLvpQGBMMzsatHH0Kix/jICo=;
 b=J+dbz6iU8ewWu0saYvBbMMYJmMeQuz/VHbn5m1CTalri8JzMCpqLROwpq1G3yGAVEO
 l5kxfqbZMF8o4TnNe04jEiR1zruc+MyFPibD5YXTW22GzWPgSsJJQ7UYp/KOWP8A5MlS
 Oi++7stK9UD7kswvx/7HRXrnxdmGTa6aousv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=s6aboUTCwaj4TA/VXlzMLvpQGBMMzsatHH0Kix/jICo=;
 b=VZ2PTILeWnZ9Mr61O3XlVn+8jGzXMgMSw9Zg9Bq1VePRg+jYfYqL6bl8wjqJPZ7K8e
 QEehQbO2UnbV9tHwxCRwOU5+nHoCaV6rAERykCrvgW22VMgcrMJzuuY7Eun1jIB1lNJ6
 FXjlyfMaBnAyusoHGqMRr0OFywtTivkwfd9ZhKCIA3E3YaoRdcM0T28nXPpve6Cs2Fyz
 /YbeeATh9tQMTpI4iJ+l2e3CRcHbhBN9QIIFrc9MD8FpNtewAoG5EkXoNg3vRK26oFau
 YJSd1mu4As3nIl3SkqeDvNfF2xIl16FKLNIdSeES3jBUJzAD9KbbSpj9PMvmxE0gq5aN
 mC7Q==
X-Gm-Message-State: AA+aEWbR/h6yTNrg7k7yr1nVS1mPN9eWTupCEZj5LZwdjlDWETNQphGb
 WDuk9ikBTOS/guWtnRBvao3VMA==
X-Google-Smtp-Source: AFSGD/VRBEwILLZAC4QOSgQ9/7OLPWBsrOEDNOzaXyNMwPmAO8U8CHi4WocLQpfrlGM+2erTp/VfCA==
X-Received: by 2002:adf:f308:: with SMTP id i8mr11822984wro.219.1544514051589; 
 Mon, 10 Dec 2018 23:40:51 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 23:40:50 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v3 6/8] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Date: Tue, 11 Dec 2018 15:38:26 +0800
Message-Id: <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_234103_820500_F9888224 
X-CRM114-Status: GOOD (  13.20  )
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

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 1039f364..bee026e 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -410,7 +410,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
-		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
 		resp = cs_etm_decoder__buffer_discontinuity(decoder,
 							    trace_chan_id);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
