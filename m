Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F904C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E438A222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CWEtaFCW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNW+frnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E438A222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rloI18A1erfiyXcNK2BAfbNCd1Y1wYnnU+bHtWHQbUU=; b=CWEtaFCW2Q11Nxdn89zRqIV2SA
	Wnt02AOOUPKCjHmtAq24bkIgxUUM3kqORAZ096qZA7urqkvyPh7O8p9jAKuzey2tsFOi/qbAbB85W
	B4y6hWpdmdKd2cjDNjL9rDwxjZBU0O5g9oWIFWkqKzs55zZlh9IDiL2gea0GfzXJxd3a2jhR3Zf+6
	r8eieJg3JF7NmrPKRKK4uQThvv20GjYpQi0/5czbY6rrKqVdnOBNb+2NdCyZra6wUjkHsV/Hc1bCg
	YVLqvrn+boPpLnWWB9G2yLu0VkeqpLZCVj46v3VVpgxScj3BfbFBZFhnD7uDHawBmhd9yyIrWlDfv
	HB0EzQ5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbhA-0002sf-4k; Tue, 12 Feb 2019 17:18:08 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbfX-0001LP-Pw
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:16:36 +0000
Received: by mail-pf1-x443.google.com with SMTP id q1so1597430pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qBtfkm7Aoo/feOhhrqKL+o79kVL9oAED5/pempgClW0=;
 b=YNW+frnJ9THIpOHeaU5fgArgePOQEKFlNjaVyZRq0kxYox0+IOtEf1dCefvA8AmCe9
 5dKqrLcEfHG+PRAOLifcCHs3cwveSA61uCPiKajFcdbUVxtU1U5dAwbJv1+qZmPzvIBq
 6yc5gCOluL9Qxj3150ZCPfilXEHNoqEE2opjz/4ziZO1c9Ol6X+oNS34Fu6KguY7ueWh
 6j4ga0u9X6w3sPPPvg6dGIS2+CJu1755RNqQz3tVECFkRT8UwPIPb5WopG1ORVZDiIrt
 mxR74coqJuZcQjGMj3dTLjMfMaMRHc9eDwgaUawrTWU7qfHNBBHL+vUpPQzOOTvHGG1R
 LLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qBtfkm7Aoo/feOhhrqKL+o79kVL9oAED5/pempgClW0=;
 b=d7ei+EpsG8K7HZn5VVpTomDlfkEAjqrYCq2Ow5LMFws6yPpPxQCSB4E/I38e/hxQ16
 bkjrE1zkOezVREAlDWmRePBlIUdzuD1sY1x37IaD4Vg3hr+cWIKU9+vgT9uclzqBZMBZ
 j39BiyGRFXi7jKoh9KuBoPYOUKfMxszeKnrorXGl+JVFu4nm0AwcTwVFE1bOhmleNVlC
 51kUOFLeA78q5BCiAjMefYQEWDUPCGTQQD/V5EzoxixsITZ9WAbq8cc048afXnZmHjQi
 aaxRRIMPK+H+CQba8WwWVDClVUbOrDHs7p8MmstYzsobal45AHL3dnth8+gFzbb1lBpU
 Rozg==
X-Gm-Message-State: AHQUAuahQVqdgKGd1WrACEqr04NyXQUTIK50/v5OyBmL21owk4jcwn/X
 xwqZF03ObUX7RTihA5qjw3hFXA==
X-Google-Smtp-Source: AHgI3IZ2iCMUKqBh9euSozlCoP/28cyKZPgHzEI4Bhc+SNQoX3S7iJ7VSzExn2K9y6r58QZ8y3wqXg==
X-Received: by 2002:a62:7086:: with SMTP id l128mr4957980pfc.68.1549991787247; 
 Tue, 12 Feb 2019 09:16:27 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 09:16:26 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH 06/13] perf tools: Introducing function
 cs_etm__init_trace_params()
Date: Tue, 12 Feb 2019 10:16:11 -0700
Message-Id: <20190212171618.25355-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_091628_185426_7B159B05 
X-CRM114-Status: GOOD (  15.72  )
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

The trace parameter initialisation code is repeated in two different
places, something that bloats the file and can lead to errors.  This
is fixed by introducing a helper function and calling the right
protocol initialisation code when required.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 112 +++++++++++++++++++--------------------
 tools/perf/util/cs-etm.h |   4 +-
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index aac07f950074..f3a6dfaf3026 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -136,6 +136,57 @@ static void cs_etm__packet_dump(const char *pkt_string)
 	fflush(stdout);
 }
 
+static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_params,
+					  struct cs_etm_auxtrace *etm, int idx,
+					  u32 etmidr)
+{
+	u64 **metadata = etm->metadata;
+
+	t_params[idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
+	t_params[idx].etmv3.reg_ctrl = metadata[idx][CS_ETM_ETMCR];
+	t_params[idx].etmv3.reg_trc_id = metadata[idx][CS_ETM_ETMTRACEIDR];
+}
+
+static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
+					  struct cs_etm_auxtrace *etm, int idx)
+{
+	u64 **metadata = etm->metadata;
+
+	t_params[idx].protocol = CS_ETM_PROTO_ETMV4i;
+	t_params[idx].etmv4.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
+	t_params[idx].etmv4.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
+	t_params[idx].etmv4.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
+	t_params[idx].etmv4.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
+	t_params[idx].etmv4.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
+	t_params[idx].etmv4.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
+}
+
+static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
+				     struct cs_etm_auxtrace *etm)
+{
+	int i;
+	u32 etmidr;
+	u64 architecture;
+
+	for (i = 0; i < etm->num_cpu; i++) {
+		architecture = etm->metadata[i][CS_ETM_MAGIC];
+
+		switch (architecture) {
+		case __perf_cs_etmv3_magic:
+			etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+			cs_etm__set_trace_param_etmv3(t_params, etm, i, etmidr);
+			break;
+		case __perf_cs_etmv4_magic:
+			cs_etm__set_trace_param_etmv4(t_params, etm, i);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 				       struct cs_etm_queue *etmq,
 				       enum cs_etm_decoder_operation mode)
@@ -161,7 +212,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_buffer *buffer)
 {
-	int i, ret;
+	int ret;
 	const char *color = PERF_COLOR_BLUE;
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params *t_params;
@@ -179,33 +230,8 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	if (!t_params)
 		return;
 
-	for (i = 0; i < etm->num_cpu; i++) {
-		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
-
-			t_params[i].protocol =
-					cs_etm__get_v7_protocol_version(etmidr);
-			t_params[i].etmv3.reg_ctrl =
-					etm->metadata[i][CS_ETM_ETMCR];
-			t_params[i].etmv3.reg_trc_id =
-					etm->metadata[i][CS_ETM_ETMTRACEIDR];
-		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
-						      __perf_cs_etmv4_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-			t_params[i].etmv4.reg_idr0 =
-					etm->metadata[i][CS_ETMV4_TRCIDR0];
-			t_params[i].etmv4.reg_idr1 =
-					etm->metadata[i][CS_ETMV4_TRCIDR1];
-			t_params[i].etmv4.reg_idr2 =
-					etm->metadata[i][CS_ETMV4_TRCIDR2];
-			t_params[i].etmv4.reg_idr8 =
-					etm->metadata[i][CS_ETMV4_TRCIDR8];
-			t_params[i].etmv4.reg_configr =
-					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-			t_params[i].etmv4.reg_traceidr =
-					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
-		}
-	}
+	if (cs_etm__init_trace_params(t_params, etm))
+		goto out_free;
 
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, NULL,
@@ -382,7 +408,6 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 						unsigned int queue_nr)
 {
-	int i;
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params = NULL;
 	struct cs_etm_queue *etmq;
@@ -431,33 +456,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (!t_params)
 		goto out_free;
 
-	for (i = 0; i < etm->num_cpu; i++) {
-		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
-
-			t_params[i].protocol =
-					cs_etm__get_v7_protocol_version(etmidr);
-			t_params[i].etmv3.reg_ctrl =
-					etm->metadata[i][CS_ETM_ETMCR];
-			t_params[i].etmv3.reg_trc_id =
-					etm->metadata[i][CS_ETM_ETMTRACEIDR];
-		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
-							__perf_cs_etmv4_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-			t_params[i].etmv4.reg_idr0 =
-					etm->metadata[i][CS_ETMV4_TRCIDR0];
-			t_params[i].etmv4.reg_idr1 =
-					etm->metadata[i][CS_ETMV4_TRCIDR1];
-			t_params[i].etmv4.reg_idr2 =
-					etm->metadata[i][CS_ETMV4_TRCIDR2];
-			t_params[i].etmv4.reg_idr8 =
-					etm->metadata[i][CS_ETMV4_TRCIDR8];
-			t_params[i].etmv4.reg_configr =
-					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-			t_params[i].etmv4.reg_traceidr =
-					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
-		}
-	}
+	if (cs_etm__init_trace_params(t_params, etm))
+		goto out_free;
 
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, etmq,
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index d76126e0e3d0..0e97c196147a 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -105,8 +105,8 @@ struct intlist *traceid_list;
 
 #define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
 
-static const u64 __perf_cs_etmv3_magic   = 0x3030303030303030ULL;
-static const u64 __perf_cs_etmv4_magic   = 0x4040404040404040ULL;
+#define __perf_cs_etmv3_magic 0x3030303030303030ULL
+#define __perf_cs_etmv4_magic 0x4040404040404040ULL
 #define CS_ETMV3_PRIV_SIZE (CS_ETM_PRIV_MAX * sizeof(u64))
 #define CS_ETMV4_PRIV_SIZE (CS_ETMV4_PRIV_MAX * sizeof(u64))
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
