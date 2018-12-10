Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E00C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:54:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568CA2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OeeSR5eu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+7cjU7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568CA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bibbkdwspFrmJS09v+Zfo/qL3v91QXL1XgC0uUNez0c=; b=OeeSR5euAWbuTtmjA/LgZjDTu2
	6IhW/Q7/N0ETVOD4nISUUIE1A4Qs3rhXrmH/2/hx0yXQgdtxJTjF2n8GegcbdwTIQPfRfgc0bEiWd
	OPl1whOxraggyqK/LZXUvY2a/pFYJGXFDTuozleGEnMgPHE2oJcVRC4Yt1FEenn1h4nBT7FKZl2pz
	FqzSoob44JkHaRxegsBR+NDKTz9Xfl0Zn9wRpYM8kQzRZ5di5HYBQgoLSVa/nJ2ZYrVKAAi8Bo+0e
	0oNNZAiTuI/fZCIiP3jF9Wv2+0S2f7Iz8vsg42UUAK9w8BSHseoy2pRJ45whLSpOYtV4d/BjL20C/
	4/YvODgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHKG-0008J2-2F; Mon, 10 Dec 2018 08:54:04 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHJq-0007o2-NY
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:53:46 +0000
Received: by mail-wr1-x42c.google.com with SMTP id x10so9538876wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 00:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/Mqm5NLjImIYS16X8WHi66jKS9/dDWkoWlmg3vq+u2w=;
 b=E+7cjU7rX2G9g9Nq8/CJhtZLY5S59gQoL1eK7hZw1mzGeJ/Kky+rSwd5ze4gH8UGR9
 gp5ojQC+RiYTFeKxyQB1Y2hks+6DVXQy0ma9PODdhZ8Se1wtHiUfBevJZPAD6eK4K927
 yCW6LRV1J+mY/KgYBTorp3JtPy3kLev760zYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/Mqm5NLjImIYS16X8WHi66jKS9/dDWkoWlmg3vq+u2w=;
 b=Rfs6ZcJkrHqpdYVc/osPN6LWMbkCDat8bey3nvKILdW/Bg5fI9T0UsB/Nk+qYCWwrI
 dd/Wdc2/iNUmA9GTramFZB4Wbz77KhCqnxxEpy5s6I6zBYAWGB9RY37iPXXG6uB126xX
 kLM2eNz4KR2/LFiBxKmOPm1uWL3TLYImSZPZwJyjYVo5VtfW+Rsd0lDIn3JRMWr2ojG/
 mpOoR5SMaGiaujRnbQo6SAvEkUZv0pEs2PAz0S0gUKFcT7++iCdZY8v+Bs+viyRe0Ysj
 YUI1b6c5PcvhX+A9OkjWbluiNE03j2NjJMMD4gPPHkR9GbJ9XEDBnkaR+ykKJOG+4fLn
 GuYw==
X-Gm-Message-State: AA+aEWYJS0LgN0QWpMVE9jLwQ79iQLkAJYgKV4Jkm4BHvl8m1wcrK0E7
 se02pGUxic6PHwb5Oijok9PgPg==
X-Google-Smtp-Source: AFSGD/WPgXPGcjOT22vKEf7fhaElrgakgys59BHMqv1SZWyeJCkmuEYPB8VY8K1uPxjjFztAZsamRQ==
X-Received: by 2002:adf:d112:: with SMTP id a18mr9614787wri.17.1544432006964; 
 Mon, 10 Dec 2018 00:53:26 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id m4sm9097351wml.2.2018.12.10.00.53.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 00:53:26 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v2 2/6] perf cs-etm: Avoid stale branch samples when flush
 packet
Date: Mon, 10 Dec 2018 16:52:57 +0800
Message-Id: <1544431981-24144-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_005339_472474_CA1928A9 
X-CRM114-Status: GOOD (  21.03  )
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

At the end of trace buffer handling, function cs_etm__flush() is invoked
to flush any remaining branch stack entries.  As a side effect, it also
generates branch sample, because the 'etmq->packet' doesn't contains any
new coming packet but point to one stale packet after packets swapping,
so it wrongly makes synthesize branch samples with stale packet info.

We could review below detailed flow which causes issue:

  Packet1: start_addr=0xffff000008b1fbf0 end_addr=0xffff000008b1fbfc
  Packet2: start_addr=0xffff000008b1fb5c end_addr=0xffff000008b1fb6c

  step 1: cs_etm__sample():
	sample: ip=(0xffff000008b1fbfc-4) addr=0xffff000008b1fb5c

  step 2: flush packet in cs_etm__run_decoder():
	cs_etm__run_decoder()
	  `-> err = cs_etm__flush(etmq, false);
	sample: ip=(0xffff000008b1fb6c-4) addr=0xffff000008b1fbf0

Packet1 and packet2 are two continuous packets, when packet2 is the new
coming packet, cs_etm__sample() generates branch sample for these two
packets and use [packet1::end_addr - 4 => packet2::start_addr] as branch
jump flow, thus we can see the first generated branch sample in step 1.
At the end of cs_etm__sample() it swaps packets so 'etm->prev_packet'=
packet2 and 'etm->packet'=packet1, so far it's okay for branch sample.

If packet2 is the last one packet in trace buffer, even there have no
any new coming packet, cs_etm__run_decoder() invokes cs_etm__flush() to
flush branch stack entries as expected, but it also generates branch
samples by taking 'etm->packet' as a new coming packet, thus the branch
jump flow is as [packet2::end_addr - 4 =>  packet1::start_addr]; this
is the second sample which is generated in step 2.  So actually the
second sample is a stale sample and we should not generate it.

This patch introduces a new function cs_etm__end_block(), at the end of
trace block this function is invoked to only flush branch stack entries
and thus can avoid to generate branch sample for stale packet.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 789707b..ffc4fe5 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1055,6 +1055,39 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	return err;
 }
 
+static int cs_etm__end_block(struct cs_etm_queue *etmq)
+{
+	int err;
+
+	/*
+	 * It has no new packet coming and 'etmq->packet' contains the stale
+	 * packet which was set at the previous time with packets swapping;
+	 * so skip to generate branch sample to avoid stale packet.
+	 *
+	 * For this case only flush branch stack and generate a last branch
+	 * event for the branches left in the circular buffer at the end of
+	 * the trace.
+	 */
+	if (etmq->etm->synth_opts.last_branch &&
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
+		/*
+		 * Use the address of the end of the last reported execution
+		 * range.
+		 */
+		u64 addr = cs_etm__last_executed_instr(etmq->prev_packet);
+
+		err = cs_etm__synth_instruction_sample(
+			etmq, addr,
+			etmq->period_instructions);
+		if (err)
+			return err;
+
+		etmq->period_instructions = 0;
+	}
+
+	return 0;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -1137,7 +1170,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 		if (err == 0)
 			/* Flush any remaining branch stack entries */
-			err = cs_etm__flush(etmq);
+			err = cs_etm__end_block(etmq);
 	}
 
 	return err;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
