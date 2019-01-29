Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC0BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:31:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004752083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DraXy3O5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHBeadn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004752083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cFyve0gO3mnbbs/W2x7+Dp090QJEZvv7ydTX4CR7bQU=; b=DraXy3O5MBKGwByYfrCYOC/xb9
	fOMw0QzHyDu5XYGrcRakco4sTR1Bu8DGlMVydonn3RCXYTOXS8lhYjzo/rw1xV3me4AZiWM0mYSIn
	4FyvmrC9KXgZrtLeExA0NjvyKgHk/MtLMM7UM3m4ZJ0VY5MapS6KHcq4CyISlFK4zwXN6m4oylcmC
	R1YKapzWROWjB4fvzaRI/wDY7DscmWykGSG2gMedZ9S3P08UaXdx7ojg1Ivqlxa12crBw9q9FlVEj
	CyQDWOgAnLtqH34sgyt2dfFvGPWtNdJnepL9FA6hiTu52U0PL52D3x4yIfHsGLnTWwYjidIHdaRjJ
	azLBHo8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goSXn-0007ql-3P; Tue, 29 Jan 2019 12:31:11 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goSWk-0005pY-7N
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 12:30:13 +0000
Received: by mail-pf1-x443.google.com with SMTP id r136so9592874pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 04:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3vgO5gz1slI+w2/pIHGVojFnCNFu6a/dztrTgaESmOQ=;
 b=ZHBeadn6EB+AZwhwS4obP3N25LhIylyiAzNql7x5WU5QCtUeXFlJHaO+CkZeifZK92
 B4jGrbFNVlvSC5Xh+3qBhDrUXe2KkutpVnU5u+aLkTwPvAZyhzXbRYLeFd4Hng7D+Dn1
 N0S4vtT1Ls7F8E7eeXL86z9hplzgteqRG/jU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3vgO5gz1slI+w2/pIHGVojFnCNFu6a/dztrTgaESmOQ=;
 b=cGEV7EmF+Etf5jaM6TLkri9Xr5SiTmlB+THiHKPi065US8bGgQfboDnSBiZVWDtMW6
 /wQh3cOUfpEF2hBaw098sVXGZ/Dzd/mJ01c+gvLoGYXCcDKyJ0N6G4Xc34qh7j77bSYi
 uTbJWQLjRFUviFlxjF/nFmXOQPYW/5qERJAuNLpCnkGOQIhEdNUPIob8ftQf3ky0KBh7
 OS+eAyMK7PraKvhxlPo3W8FGykFCPb2sRn0DTqSaLclEgEvC/k1/ifHa3jvVRq7RCA9e
 qe65LG6RnWCm5e3M9PFc2c46D1qMFkd3g903/VYziAdwTHHLb4NsNeF2lGAv66fTYzKk
 4rvg==
X-Gm-Message-State: AJcUuke58ezcWWaEQUbCFPC0uosDmLcDjVhzGRD8wO/6ahYaQ95Czzvx
 3GQPYa/j80NpW7PLMBnLQiUlhw==
X-Google-Smtp-Source: ALg8bN7HPtQ16aPzq6ZbWm6m3UMYmUpqmc9bg6nHaT36xUhSH0KTdeAIjIvLg3h27okO7ePDZ1rIGQ==
X-Received: by 2002:a63:ec4b:: with SMTP id r11mr22995464pgj.44.1548765005530; 
 Tue, 29 Jan 2019 04:30:05 -0800 (PST)
Received: from localhost.localdomain (li569-141.members.linode.com.
 [192.155.82.141])
 by smtp.gmail.com with ESMTPSA id h64sm59552502pfc.142.2019.01.29.04.30.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 04:30:04 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v7 4/8] perf cs-etm: Add exception number in exception packet
Date: Tue, 29 Jan 2019 20:28:38 +0800
Message-Id: <20190129122842.32041-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129122842.32041-1-leo.yan@linaro.org>
References: <20190129122842.32041-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_043006_844418_97812E55 
X-CRM114-Status: GOOD (  14.67  )
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

When an exception packet comes, it contains the information for
exception number; the exception number indicates the exception types,
so from it we can know if the exception is taken for interrupt,
system call or other traps, etc.

This patch simply adds a field in cs_etm_packet struct, it records
exception number for exception packet that will then be used to
properly identify exception types to the perf synthesize mechanic.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 +++++++++++++++----
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index e98ee49a1527..294efa76c9e3 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -294,6 +294,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].last_instr_subtype = 0;
 		decoder->packet_buffer[i].last_instr_cond = 0;
 		decoder->packet_buffer[i].flags = 0;
+		decoder->packet_buffer[i].exception_number = UINT32_MAX;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].last_instr_subtype = 0;
 	decoder->packet_buffer[et].last_instr_cond = 0;
 	decoder->packet_buffer[et].flags = 0;
+	decoder->packet_buffer[et].exception_number = UINT32_MAX;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
@@ -406,10 +408,20 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
+				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
-{
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_EXCEPTION);
+{	int ret = 0;
+	struct cs_etm_packet *packet;
+
+	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					    CS_ETM_EXCEPTION);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+	packet->exception_number = elem->exception_number;
+
+	return ret;
 }
 
 static ocsd_datapath_resp_t
@@ -443,7 +455,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(decoder,
+		resp = cs_etm_decoder__buffer_exception(decoder, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 23600e57a215..012b4728a46f 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -46,6 +46,7 @@ struct cs_etm_packet {
 	u32 last_instr_type;
 	u32 last_instr_subtype;
 	u32 flags;
+	u32 exception_number;
 	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
