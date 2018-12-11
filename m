Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C72C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:42:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694AB2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="esPoNsGH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cp9KUPnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694AB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=+Y1MaZ61XUQw/VbJf/avcWJ4TiMdeC6rN647f62MWaE=; b=esPoNsGHcyi761aXglJtVma0Np
	dLei04zLUu6fMNhRrDwJ4yXHzAM+Ym9bGykGsQMS4pwkSJ0W8KUkOVaJVOCJSgPOjyOAgv9ggH7aP
	C1Yo18sBgfTzjbicGlvWJSIaNMYPFp9Bz9bfFENnYZzgl/YBdU8pmxe+gL9tt22hcW8g0hy5cxtXv
	UaW9mNnKFvjxasWcRZ9GGRtr+fJv4APDd/a3lhLm1lkc1t8st/+2jMef53Tx4hWHfosfYNwysBjqx
	vVJrc6QeAVolSgGblvKRtrLj37Ra+LVew/u1lM9G09fYPtHujdqiANeMNxaPl8F5yVhG/kiH+gVHK
	OZWv5OEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcgT-0000Wn-60; Tue, 11 Dec 2018 07:42:25 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcfE-0007cn-7p
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:41:24 +0000
Received: by mail-wr1-x444.google.com with SMTP id q18so12955725wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 23:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HqaxBZzT/ny60CVvOS0lgH0CrB/BIasRrsWm7IM5vG8=;
 b=Cp9KUPnhAQUAo/JG52hN0Hj6I5CbvZjECAnZPG+Sf1GU+t3GohIfKw+LUziR1KXtx6
 aMLkIqe1sEoANZKEduQIuphsllazBVrJpYfdlxczQEMm2Zsn64UoE/cToRV6x7AwB+6l
 kR96G57ANDDlB/OU0QQWA6ygrvwAkhKtdOrYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HqaxBZzT/ny60CVvOS0lgH0CrB/BIasRrsWm7IM5vG8=;
 b=rdZUow847yNAMM1oGbGxAnJTgiLiZcKv1f6mTQai8XHBzem2Jhw1DXj4+4lnIUkEdZ
 6OTahwemdHJbCeGMD5NbYhjoUe4/RD8Q9GNrbEpxswj/qeNxpPdbWyquA3k4XpD2VmOs
 XTNld9+myEd2MQSRPD0BBW8H/EouVoOoOx1w5HJ58hAIbvakWqUtrp9g4TZ8KKi0cif2
 X2RbuDfuSa2QWlGqk5h6madKd1t+1kO672rxBzKHaMhcTFFfjd25pHccA5SYAummRmP/
 Z8Iqgufbx4mNWN7G0GWZPiH7Jzw0qR5VRMTWo8p3hJ19u9BtRTaq8eaXuGhMU5GjGeyN
 bOFQ==
X-Gm-Message-State: AA+aEWZfvkNUy9YssQ5g/qESl4k3NDH6aXga8YcDdbr+3ZDCshwVrPqu
 RUQJxSWiruoOlA7X8WeD+9CGyw==
X-Google-Smtp-Source: AFSGD/V88XEhcCiMiRqFCj7p8GiJO5XjSLLUncVEsWc4jQ5tpKsBPOBawZz1yltxUZU7QR6eQy4PQw==
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr12847975wrt.264.1544514056667; 
 Mon, 10 Dec 2018 23:40:56 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 23:40:55 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v3 7/8] perf cs-etm: Treat EO_TRACE element as trace
 discontinuity
Date: Tue, 11 Dec 2018 15:38:27 +0800
Message-Id: <1544513908-16805-8-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_234109_193400_4B3849DA 
X-CRM114-Status: GOOD (  14.06  )
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

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index bee026e..cda6f07 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -409,6 +409,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	switch (elem->elem_type) {
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
+	case OCSD_GEN_TRC_ELEM_EO_TRACE:
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
 		resp = cs_etm_decoder__buffer_discontinuity(decoder,
@@ -425,7 +426,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
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
