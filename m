Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527ABC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:40:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0E92081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="autV/7ON";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AK+x+9jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0E92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Rw3w5JxwSdXOXNFxp1T71hCQP9vEq8SfYwdoyaicZ/E=; b=autV/7ONp7jMZ8SkxGLA7P7l9q
	G/6BLH+gFCPfBtYhHo8geNiLrcHU7LKAhqrRkg49pOLLDrNrroNrmoe0erab5aMUIn7tQ5xfnFxVy
	Kiby/Qn8prA2FKRqYXOLQZTTM5TM7iikJ2UxbU2pqEUc1+Tx24SgGYOz52KTCdq98+IXrBW5yGRsP
	MHH/QPY2b5S/KVHSpvy7467OopRYQJy+tzvLZ586cc/CYhxXb+9AY6JEh8bFDKyluLPZWR9Ru9/m1
	jium3RsYOErF5BxCBcg8CE7QwGFFbKsMomnk77fSahTbT1tqZR+0/oiLyxmVYnIFhYGibh0F9pVVn
	U0cQrM9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHUA-0007iK-T7; Tue, 04 Dec 2018 20:40:02 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHTU-0006xp-ER
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:39:22 +0000
Received: by mail-pg1-x542.google.com with SMTP id 17so7916100pgg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UCYgcEEMVlbQk66yjR27lIkghRdtDEI1kbeQRCjG2MQ=;
 b=AK+x+9jTmPsXIh/RC5ghWxEZ2gyXXIfS05G+mFTDE4HejXnVWqehGX7uAgby+zfFpH
 ++mRLrYlRQTVvBWHTU+Wea4EjZ49z4uSRGrIgh03l/SctmubCoxIrWjdcrNe+67ltU8v
 KV8ZcWBAxLjobbEQXkaddg3J8wbDuQU5iEnrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UCYgcEEMVlbQk66yjR27lIkghRdtDEI1kbeQRCjG2MQ=;
 b=bynniXZO6UP5FRI9fW1XrV9kG1UNHD1ABFNNyRWCql/uA9oLPOzn9Rc1nhsKp9KJY+
 IAOphLM8VtTfBGaVLrvqbQ9CTms+U6/QSTXQ880NofqmJ7QU/Vej+27CoKatT3IYYHtI
 vU0LkvewH4lWZcKplLxAbw6IE7wLvsHjHBbrGJkUhpI81aY6+NwibEQJIiL1e6qx2Gpx
 1UsqVzGyyvGgUWSARhhjJ+1qmJmMBOMDDQW593jM6Of8MqpzIkH3fRadx+nhI3SOf194
 0akFlNJPZWy2KY7NwCDV6XBDhvCIHKU3HVWZpeDCZKg+BrT88d9mKGHpgPBSoj0zttLt
 ZBEw==
X-Gm-Message-State: AA+aEWZbJiV7DFzG2Z59GMYbB9eRTNkoG6s5FX8nSRccthS9Nhy594Jl
 86k0Xu3Qo67+97eGrq6ukyDu9FXMvJY=
X-Google-Smtp-Source: AFSGD/W0U2zDM9KsYsM2FxOyJ2/3efLEMSe9lwOWpuZt+YDdpcCDmCUNITnnlK+iokp41GRoXewEmA==
X-Received: by 2002:a63:4187:: with SMTP id
 o129mr16639663pga.370.1543955949940; 
 Tue, 04 Dec 2018 12:39:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id r76sm29783274pfb.69.2018.12.04.12.39.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 04 Dec 2018 12:39:09 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH RESEND 3/3] perf tools: Add support for PTMv1.1 decoding
Date: Tue,  4 Dec 2018 13:39:04 -0700
Message-Id: <1543955944-10042-4-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543955944-10042-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543955944-10042-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_123920_479249_F304588C 
X-CRM114-Status: GOOD (  15.81  )
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

This patch is re-using the mechanic set forth by ETMv3 to add support
for PTM decoding.  Configuration for both encoding protocol is similar
but the generated stream itself is very different, hence requiring
special handling.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        | 23 +++++++++++++++++++++--
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 84a86d2f25c9..de8d792bc49d 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -256,8 +256,11 @@ cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
 
 	switch (t_params->protocol) {
 	case CS_ETM_PROTO_ETMV3:
+	case CS_ETM_PROTO_PTM:
 		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
-		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
+							OCSD_BUILTIN_DCD_ETMV3 :
+							OCSD_BUILTIN_DCD_PTM;
 		trace_config = &config_etmv3;
 		break;
 	case CS_ETM_PROTO_ETMV4i:
@@ -424,8 +427,11 @@ static int cs_etm_decoder__create_etm_packet_decoder(
 
 	switch (t_params->protocol) {
 	case CS_ETM_PROTO_ETMV3:
+	case CS_ETM_PROTO_PTM:
 		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
-		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
+							OCSD_BUILTIN_DCD_ETMV3 :
+							OCSD_BUILTIN_DCD_PTM;
 		trace_config = &config_etmv3;
 		break;
 	case CS_ETM_PROTO_ETMV4i:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index c0c67c919093..029e66b968a6 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -86,6 +86,7 @@ enum {
 	CS_ETM_PROTO_ETMV3 = 1,
 	CS_ETM_PROTO_ETMV4i,
 	CS_ETM_PROTO_ETMV4d,
+	CS_ETM_PROTO_PTM,
 };
 
 enum {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 830e9136ad7c..2f1a176d55e8 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -91,6 +91,19 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid, u64 time_);
 
+/* PTMs ETMIDR [11:8] set to b0011 */
+#define ETMIDR_PTM_VERSION 0x00000300
+
+static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
+{
+	etmidr &= ETMIDR_PTM_VERSION;
+
+	if (etmidr == ETMIDR_PTM_VERSION)
+		return CS_ETM_PROTO_PTM;
+
+	return CS_ETM_PROTO_ETMV3;
+}
+
 static void cs_etm__packet_dump(const char *pkt_string)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -123,7 +136,10 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+
+			t_params[i].protocol =
+					cs_etm__get_v7_protocol_version(etmidr);
 			t_params[i].etmv3.reg_ctrl =
 					etm->metadata[i][CS_ETM_ETMCR];
 			t_params[i].etmv3.reg_trc_id =
@@ -374,7 +390,10 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+
+			t_params[i].protocol =
+					cs_etm__get_v7_protocol_version(etmidr);
 			t_params[i].etmv3.reg_ctrl =
 					etm->metadata[i][CS_ETM_ETMCR];
 			t_params[i].etmv3.reg_trc_id =
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
