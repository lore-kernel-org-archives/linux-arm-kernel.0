Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13644C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:32:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D314A2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZzzDv5KF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHGHp8jR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D314A2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zWKpmkdjv3Nb4CSzcr9hogqqQEXS+k/rzyho5d8VtCY=; b=ZzzDv5KFSd2L6NJFdFC+UJRui0
	kchchJrXD1DR594To02kP9JxsKge5CY2mppKhu5Tl0nFxCkCX8oA7agukaR/omvpqaswplFRWURUe
	wY9Pref2K024szLXg1L88ALCLqdO8BaiXYT1YxBDsQ0aFlv/YYwcauQT4WwdEP7OezGl2nhf8NXRk
	NYu3DF8PWxQNU1NWVM3DQbYzT2hkhE3968Z3Y4wIiny1QiNiMkNuXHYxsAU2jGmI/VbmAVVC47L9m
	x6PLL3NqzRmgYvLIiE2mOqMPgxcpi8HlTayP1IUNI0bq/UD54jgEB0CGOZWYouw0wJ82NIplhOQxy
	hU3gBimg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goSYp-0008Ph-0l; Tue, 29 Jan 2019 12:32:15 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goSWt-0006MJ-LU
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 12:30:23 +0000
Received: by mail-pf1-x441.google.com with SMTP id y126so9594636pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 04:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LDRQG3UQxntyoi7kv39dKKGog1UFkbBd0dWoL+G3ZRM=;
 b=eHGHp8jRAaV2wgbhIwcjRebSMqSMyg5DgX3bonjkii4dOULdoXvKBmMVhWht8D7sm5
 kFHsfDvgvkrWZUb7WHcFWcjsyo89XO3owhDeFlz/exocxsTJdIjmuFp9/Q1/d9G1TGKr
 Ktft7EuXXzo0VnJKyRvEc7MgaPw+sYIeLkHLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LDRQG3UQxntyoi7kv39dKKGog1UFkbBd0dWoL+G3ZRM=;
 b=bwrU2YsPGvf4nMCwHJc1TTVx9wjPGcx5BZFaHSq2slLcKofuEHr/jopN9oeNkOYAJq
 wy5zYJbeRMkcx15tgPwiZG7xBzBx5X4g+axiC3ePxr/+en8ZCy5PBu/ZYpNnrd77KO51
 IHZ92Uri4DuhlCkquGm+/RRiHCj7zGYTqHQlD1WPNMEPcjQA0Zxwky/LxO08hxtkK+62
 JAi95r1wcbp70TyRB9zOI8lEqLelu3KLWFm/ukEE+8ScxPu1VhVvrm2+PG2X0KJeuUd0
 N8Q8hLCeeWDiIoX6ATVyhaZHWd7XauGFuTpz6N1LFO9+y2MWUdfZKFLRXD2f8WtCswZ4
 g/tA==
X-Gm-Message-State: AJcUukfRdobPG5vfJCcSm8cpWbZ+waQyJkX0gFLlc3BIUZNJE7+zuQVM
 N+QaQEAkIFduSbDnEdeY1YWncQ==
X-Google-Smtp-Source: ALg8bN5M9hEaCXFh08ImUUli+TbqWwAfB21tD78s+oHZkSQ7jMZBUbR9nUnqtuFbeIBnpKljlbP1YQ==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr23992275pgc.25.1548765015042; 
 Tue, 29 Jan 2019 04:30:15 -0800 (PST)
Received: from localhost.localdomain (li569-141.members.linode.com.
 [192.155.82.141])
 by smtp.gmail.com with ESMTPSA id h64sm59552502pfc.142.2019.01.29.04.30.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 04:30:14 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v7 6/8] perf cs-etm: Add traceID in packet
Date: Tue, 29 Jan 2019 20:28:40 +0800
Message-Id: <20190129122842.32041-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129122842.32041-1-leo.yan@linaro.org>
References: <20190129122842.32041-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_043015_839157_F047F0F7 
X-CRM114-Status: GOOD (  11.82  )
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

Add traceID in packet, thus we can use traceID to retrieve metadata
pointer from traceID-metadata tuple.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index cdd38ffd10d2..ba4c623cd8de 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -295,6 +295,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].last_instr_cond = 0;
 		decoder->packet_buffer[i].flags = 0;
 		decoder->packet_buffer[i].exception_number = UINT32_MAX;
+		decoder->packet_buffer[i].trace_chan_id = UINT8_MAX;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].last_instr_cond = 0;
 	decoder->packet_buffer[et].flags = 0;
 	decoder->packet_buffer[et].exception_number = UINT32_MAX;
+	decoder->packet_buffer[et].trace_chan_id = trace_chan_id;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 012b4728a46f..7e6a8850be4a 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -50,6 +50,7 @@ struct cs_etm_packet {
 	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
+	u8 trace_chan_id;
 	int cpu;
 };
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
