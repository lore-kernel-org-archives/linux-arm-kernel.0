Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3361C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:41:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989702082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bzTPzH3L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Apj1oepu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989702082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=iqeJ1N9hOV2o4Wtg+EqJXO7ZMcTJrnoAqMjWHyo4exs=; b=bzTPzH3L72FOqaYZThYlFzgehq
	8aRHfhaLNTyFSwajArGWbBAzucBbV2gwSfLTaJA9XPRH9eaAC08LwkQbhQMDt+Gfc2J7rAvc5qrDL
	8pKxRNjt9cVohnuZTaxjVTNEIcGzv8HfpjxJYLLDsCs2feqq2uecTVNJupcSR++3CqRlyZOV1jBU8
	k93taNbUqsyaatvXtauFGYx4aqFyGpVBT00mkPUmS/p2JfRUq8iD0aQSI9dRPqQp/AFeu08m5KNAT
	6CeXL+y/eD5JLjd0OuQppYtVAudxG6b9Ss7JLT1OaKDS0KzfU98Ir6WOA8MqOBDJsAzztj2MJXS4u
	xnyZGlAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcfb-00086A-MT; Tue, 11 Dec 2018 07:41:31 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcev-0007JS-Ie
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:40:52 +0000
Received: by mail-wm1-x341.google.com with SMTP id c126so1096375wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 23:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QhESnTtb4oxO4oqXaTFof3KV9a2FuHSEH5X1fFwTnNc=;
 b=Apj1oepuxBiwwnLA8c5LR5Jik9SIHfQZ8dkw0tuhXTFNOxPc5d056h+3dFcSglG/HH
 VZHec2p1IFf+JHPTK24iw/CLhr0WYHCm+Znz6hqURz6vWScBUmPalXhdRsNwASY1/EjI
 v1wrrs//QbCvT24ResV8UxDGKMDcptWXWoX0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QhESnTtb4oxO4oqXaTFof3KV9a2FuHSEH5X1fFwTnNc=;
 b=cgAR+FI79xWtqVsJhNr7PoVi1QvChygy0oXEFGTjvsFr1XaKypti3ggtUZfQEfG4cI
 Xvt1flZEpRyf7YAUmGnuX3CFG/hh8bN3J5rBHbZGhHlRMMlcQa/VLFadbMyV55G4YRYd
 4QoCGNRPvvGyXCfpVF+3GY2HdxquTHmFJoJFnOivAbxbLQuBR0O2bCdswE74KMalw8fI
 uVab+YlQLX3Jhb92Ol/43VbzEA38rbXecYrpMCkgAUVSn95lCxiUEC0HXnZBrqnKlckx
 wXC9Ee9iJeieKfuZVNeBn689T+fmSAIM0d19qD8Q1/oHsSoMQUO1UOISlDm0q/+zWXS0
 lS2w==
X-Gm-Message-State: AA+aEWZKMFMUg8M5WE4l70Jdhwjwqe6ff+m9P8jwlX812YnTzTf6DfEG
 iAaTjaQ5Lvexa6LHH6h/IC+oZQ==
X-Google-Smtp-Source: AFSGD/U24Tc5IovTleKguehoLu7e3cZQIrcRkVkbj98Zj9rm1T7colAgToZ/TpZjyduaCb4Z4NhULQ==
X-Received: by 2002:a1c:1112:: with SMTP id 18mr1367049wmr.30.1544514037870;
 Mon, 10 Dec 2018 23:40:37 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 23:40:37 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v3 3/8] perf cs-etm: Remove unused 'trace_on' in cs_etm_decoder
Date: Tue, 11 Dec 2018 15:38:23 +0800
Message-Id: <1544513908-16805-4-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_234049_757692_94AD23F1 
X-CRM114-Status: GOOD (  11.77  )
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

cs_etm_decoder::trace_on is being assigned when TRACE_ON or NO_SYNC
element is coming, but it is never used hence it is redundant and can
be removed.

So let's remove 'trace_on' field from cs_etm_decoder struct.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 0b4c862..97b39b1 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -36,7 +36,6 @@
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg);
-	bool trace_on;
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
 	ocsd_datapath_resp_t prev_return;
@@ -411,12 +410,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
-		decoder->trace_on = false;
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
 		resp = cs_etm_decoder__buffer_trace_on(decoder,
 						       trace_chan_id);
-		decoder->trace_on = true;
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
 		resp = cs_etm_decoder__buffer_range(decoder, elem,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
