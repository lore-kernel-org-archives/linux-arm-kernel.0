Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83F5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:55:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1582082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KEjnql1J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P83Jx93Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1582082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FLP25p/Jj6iuAH4W7d1dBAhsxYWFUbyCOQffRcIT6mg=; b=KEjnql1JpA4X12k5Q6qsO1KZjO
	ozTZePPF9cvtnjNaN0oWw9I3Pc0AsVFlvHlH2+KfIr3ophqW8db7BLVjsSZ8LIND1rXhwqXQt+m8J
	hzXQqZ8mVkaz28BkgEfzBMf3+D8QflpxADlvXbtnBstFX7D/XJuN4+jVKlVCAqTJ95CnamC1heqAE
	PHxWekNE9jyVhykxLKrkDVFST1firaotPsvnWUCTkJju5nL+MRxeNpnvXNft9hspLTWSGm9yJwyle
	yplc9p9MUlvf0RfILSJ6M8ye4K4h3tKc4Nrsi7WldWlsRRyLn8gC7SFzYa80xyz2YzZoyiXEiVBKl
	p+QrOc1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHLB-0000bn-8a; Mon, 10 Dec 2018 08:55:01 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHK4-0007wz-2J
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:53:58 +0000
Received: by mail-wr1-x435.google.com with SMTP id j10so9560546wru.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 00:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vUyooLcyJUYiK6jffhRtzW6QvVrGY41s8t/va8y//+E=;
 b=P83Jx93Qf7l7qBaSRaK1K3yR6IZ6RtW2bu5lW7VjGrBx2KuWrCUeSsAe+V50Mc8w95
 fhfDgA24iPzUWSoJgyngux5eN41dgd+rs2+8ZriiBvbRa/m7z8eYzxa0QirGPZ5i2EHg
 rKZ4jbQe2VFiiOxqjde3BE6J4nMBy+j6pXJ4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vUyooLcyJUYiK6jffhRtzW6QvVrGY41s8t/va8y//+E=;
 b=UIm7Wc60i7eDIk6PrvVkOlta5DpfuLfwl884TbKNKrvtcXiV77pjG2Lu3zhHrBQXaF
 WLSD/T48Z+SzFYdM6evS34O0rQL+RSP8Xeacmqh8YCgACPc1ycoo1tcxG/HQ8881IiJN
 zQ/npoCJo/60866lGH01cLmcOSl52gtVq/wAa8a71bN8r2LJtKPom7Yevu4Hd50h4sjq
 bLhVi4GgoyF847u8FqNcQFGLx5I6JcjwnjSfgX2fnYZFKDVui79ciYr0q0/FSn1KhAkK
 rm+lPr8m7yo2rhI5k0bJFEpcCuZn/KiMxEPkF8xhoLW5GjfNMAASEEAk5y/t9wbTVeSi
 Ux2w==
X-Gm-Message-State: AA+aEWYu0Eo8LjwcbGZ96tka3i6golxkwl+hf4Vy8vRGYPGNDTfCab5P
 vUXBv4oKEOLfppkXZf2lxj8MKA==
X-Google-Smtp-Source: AFSGD/Ut3JQ0s/myU2ZSrcpxk9vzKTFREh4QW++BB6w4HOnQlYlHHdg3rubPwVtlvMXm1OXVegATzg==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr9543064wrn.27.1544432020389; 
 Mon, 10 Dec 2018 00:53:40 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id m4sm9097351wml.2.2018.12.10.00.53.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 00:53:39 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v2 5/6] perf cs-etm: Treat EO_TRACE element as trace
 discontinuity
Date: Mon, 10 Dec 2018 16:53:00 +0800
Message-Id: <1544431981-24144-6-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_005352_749040_9D2C86A3 
X-CRM114-Status: GOOD (  14.49  )
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

If decoder outputs EO_TRACE element, it means the end of the trace
buffer; this is a discontinuity and in this case the end of trace data
needs to be saved.

This patch generates CS_ETM_DISCONTINUITY packet for EO_TRACE element
hereby flushing the end of trace data in cs-etm.c.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 46b67f1..bcb5c98 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -411,6 +411,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
+	case OCSD_GEN_TRC_ELEM_EO_TRACE:
 		resp = cs_etm_decoder__buffer_discontinuity(decoder,
 							    trace_chan_id);
 		decoder->trace_on = false;
@@ -431,7 +432,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		decoder->packet_buffer[decoder->tail].exc_ret = true;
 		break;
 	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
-	case OCSD_GEN_TRC_ELEM_EO_TRACE:
 	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
 	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
 	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
