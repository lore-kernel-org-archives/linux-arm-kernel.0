Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A149C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A65A2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QIDsIS0I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iecUL2z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A65A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZG3f6aJDEtzYHxjxIjJHiJx8X24Y77El/KEUIQHt64A=; b=QIDsIS0I71u5hWN8cqfI3DAX43
	YVJKVvJ6o5sRonj/vWmzLCsUmVibPquKFPEWw2Oaa1EE4uZcGoiQymDLgIgqM7epnQENYOezs9HNK
	rmfBVvhbj1JhAo0hy4AqS/dISmHDFB8nN9YIMfy+U05hqcVzLfrIL0HbTr5KpDRG1n9mUlEMCkX8s
	HDliDG0FOOtzowg/1G2Ex4+0FCFdYPcPjzmRTw3G/uLe9zdbS+Uuc12KV9ssrr/p8iWl53wMnvFwg
	qPMqKyMe06+2JkXQaTfZGG3/5JXs1Q5SzAdvqoKDelqu0/ElBeUN0gOc8v6sEDPEbyEZ7euWhEOQa
	M2gRFv7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHTV-0006zx-B5; Tue, 04 Dec 2018 20:39:21 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHTR-0006xo-Nn
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:39:19 +0000
Received: by mail-pg1-x544.google.com with SMTP id d72so7897241pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 12:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7uXAOOMCbxu3NrD8kWXeIGqCAjNGZU3sGkuc69CifPM=;
 b=iecUL2z1/4wS3WhGPKUzl4IQnx1Ey/RZTh0iOlII1lWJjwffvCYN17q47rRfM4lh78
 k+d0YcBAYjjPqzYzpSVzj2Wm1VNazAuT4OBU9KN8HAdBn/GgM1vLjSkT8qXZGAUtb6s4
 jATqDhJlqMq0vNWEglGTG/DQc7I6+o7Q5piGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7uXAOOMCbxu3NrD8kWXeIGqCAjNGZU3sGkuc69CifPM=;
 b=H8Am+RpBK0zLqmO8fOV+hYrDHH7XyEJW9kjX5pwerdVH2ZT68TQOJThYnoxlqpD8/2
 J8y7Hmy0dUn4ZYS1lWc3VcGZfAejNVzZrIiC93i1enwdZ9XLU3udaC/0XpN28o3bf5c2
 CrS10CCHkDeYiMOlO72LYVeSwFJy5jODezsctQHniEUSZoShhYZL2Hro6F09my9tkN6o
 xlaltiQdipv1/LcYWg3IyLL4/sd+gWy7R51x2njgwjeuRGOMBtfKZm8heIa4RC6J3C+N
 JAJIkdZOpWZJw14G5zlduXBNxCvqJ3QC9gTKDzjSPYqU9tfc4T0DFU8KnPPgfd/yBZy+
 bqXA==
X-Gm-Message-State: AA+aEWbtvumOUjBuyX7m1iZV4/Km4PvhX0FpKAK2RaO55+9nthLgc0Oi
 VhQa2OP0xpjwo6rYZUdU4jrYSA==
X-Google-Smtp-Source: AFSGD/XgZWq2TbPpEL6JPbNpk3Apqv3jP7QRVczTizH6yRkZDS1Er+9Kq3zYJHSorfuH8ZXps6qX8w==
X-Received: by 2002:a63:e302:: with SMTP id f2mr18305424pgh.320.1543955948796; 
 Tue, 04 Dec 2018 12:39:08 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id r76sm29783274pfb.69.2018.12.04.12.39.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 04 Dec 2018 12:39:08 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH RESEND 2/3] perf tools: Add support for ETMv3 trace decoding
Date: Tue,  4 Dec 2018 13:39:03 -0700
Message-Id: <1543955944-10042-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543955944-10042-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543955944-10042-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_123917_771578_F9CD44B3 
X-CRM114-Status: GOOD (  12.76  )
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
Cc: peterz@infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
 mingo@redhat.com, namhyung@kernel.org, jolsa@redhat.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for the creation of packet printer and decoder for the ETMv3
trace architecture.  That way traces generated by tracers adhering to that
trace protocol can be handled properly by the perf infrastructure.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 938def6d0bb9..84a86d2f25c9 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -116,6 +116,19 @@ int cs_etm_decoder__get_packet(struct cs_etm_decoder *decoder,
 	return 1;
 }
 
+static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
+					    ocsd_etmv3_cfg *config)
+{
+	config->reg_idr = params->etmv3.reg_idr;
+	config->reg_ctrl = params->etmv3.reg_ctrl;
+	config->reg_ccer = params->etmv3.reg_ccer;
+	config->reg_trc_id = params->etmv3.reg_trc_id;
+	config->arch_ver = ARCH_V7;
+	config->core_prof = profile_CortexA;
+
+	return 0;
+}
+
 static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
 					     ocsd_etmv4_cfg *config)
 {
@@ -237,10 +250,16 @@ cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
 					  struct cs_etm_decoder *decoder)
 {
 	const char *decoder_name;
+	ocsd_etmv3_cfg config_etmv3;
 	ocsd_etmv4_cfg trace_config_etmv4;
 	void *trace_config;
 
 	switch (t_params->protocol) {
+	case CS_ETM_PROTO_ETMV3:
+		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
+		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		trace_config = &config_etmv3;
+		break;
 	case CS_ETM_PROTO_ETMV4i:
 		cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
 		decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
@@ -398,11 +417,17 @@ static int cs_etm_decoder__create_etm_packet_decoder(
 					struct cs_etm_decoder *decoder)
 {
 	const char *decoder_name;
+	ocsd_etmv3_cfg config_etmv3;
 	ocsd_etmv4_cfg trace_config_etmv4;
 	void *trace_config;
 	u8 csid;
 
 	switch (t_params->protocol) {
+	case CS_ETM_PROTO_ETMV3:
+		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
+		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		trace_config = &config_etmv3;
+		break;
 	case CS_ETM_PROTO_ETMV4i:
 		cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
 		decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
