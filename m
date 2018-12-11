Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B575C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7342084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R3uTysMN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pelw3oX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7342084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/j4BDMMYvkl2rDJ+NJSI3FHZPYGy4hXF/IzvAQcNdqI=; b=R3uTysMNItYKhGF3M/DOfARy7s
	pjdlX3A6GfSIqtUtGFXhUE7tfc9wJIc3hs6h04icvM5nOcYRu/3RM0ezpGmwBWWSIXCHqzzWqeDKD
	g6JzBQbLMFgtcYMWIBMKqE3FblzHawpy0S0lb84i9ZzabmmBZmCYy7UqPRO+yWEhxQAMoILhtM+IJ
	7mY3NK70ORmENX6Fh+19TdtgWsS0IdObYWXLCEa8GsRhsmnOabaSqiLQo+SET412JUBUYEvdwIX9O
	fRO8+8m+uz3yVxaUDRQsVw4wcmPMif04GvPFSNVpuEouc3ba8ml47uu8M/t2fAa1zGKs38qGdbO7z
	BFhxE3iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcey-0007Wu-VA; Tue, 11 Dec 2018 07:40:52 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcem-0007IU-Gh
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:40:44 +0000
Received: by mail-wr1-x444.google.com with SMTP id q18so12954513wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 23:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DdJei3MXkGiE0iSB4u2n/6IcLLnmeX4skh5tiKXlEYc=;
 b=Pelw3oX02t5Wn+zKQ4m+N8Q2Dtp048djj7lyuhalY/P2THi7fEdeG+Bdnq1t9DWCFK
 fqtZNs8ALDy2Mz2QZiMlVxvS6eXVEY+0sXKLexHhklfSFc8m8IGnjV8dgEgFf4Y9KJS8
 mN58fXhibOuSqg/6lEofkfd1OuiHWd5HpeJaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DdJei3MXkGiE0iSB4u2n/6IcLLnmeX4skh5tiKXlEYc=;
 b=YbJVCsl/FU26roL+tuI9CoiPPYl8/+D9+oSx69xqJGpY3RS64SOCE74mmYYVD0r9Nf
 C6VRmYGSWHM3JxWPuX8aLH/eJSMRO2CvNoDJ6YJCP9tQtWiYoUpT2R9NMbWwMjvKGqrb
 +R10xvThWQbXvQvWdoi9Xuc4952TGKeeYWXkvgEYqO1jh1kuMa8/+DuTKXYW6PfQn5eb
 HIh/y/yTEy13AMN6KRXQpo77eU8wjzq4dMJsOyUpgX1ax08+XJ/Qe9nic82ZhIjK137A
 WcEmjTS0hWTTIQ2tpx1QbJqLk9pgeehUB+0/rPBJLiGSiCazWFvu7v7+Wlj1UaSzIcXq
 unLw==
X-Gm-Message-State: AA+aEWb0Y38jCfLxseY93mDtRksUGKz5Kk5fVSRz3pACv36P1ffcT8kU
 MpymIIq8C4EzsbXQTIhnZWJNBQ==
X-Google-Smtp-Source: AFSGD/W2mksq10IWLPb0pBv7dqPRVjxnWNUITcg+FVVsRbtXlN1SN2ELeckglNbpt/iDIa9FweWUMg==
X-Received: by 2002:adf:efd1:: with SMTP id i17mr12066007wrp.200.1544514028756; 
 Mon, 10 Dec 2018 23:40:28 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 23:40:27 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v3 1/8] perf cs-etm: Correct packets swapping in
 cs_etm__flush()
Date: Tue, 11 Dec 2018 15:38:21 +0800
Message-Id: <1544513908-16805-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_234040_815521_B0E4A8D5 
X-CRM114-Status: GOOD (  16.88  )
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

The structure cs_etm_queue uses 'prev_packet' to point to previous
packet, this can be used to combine with new coming packet to generate
samples.

In function cs_etm__flush() it swaps packets only when the flag
'etm->synth_opts.last_branch' is true, this means that it will not
swap packets if without option '--itrace=il' to generate last branch
entries; thus for this case the 'prev_packet' doesn't point to the
correct previous packet and the stale packet still will be used to
generate sequential sample.  Thus if dump trace with 'perf script'
command we can see the incorrect flow with the stale packet's address
info.

This patch corrects packets swapping in cs_etm__flush(); except using
the flag 'etm->synth_opts.last_branch' it also checks the another flag
'etm->sample_branches', if any flag is true then it swaps packets so
can save correct content to 'prev_packet'.  Finally this can fix the
wrong program flow dumping issue.

The patch has a minor refactoring to use 'etm->synth_opts.last_branch'
instead of 'etmq->etm->synth_opts.last_branch' for condition checking,
this is consistent with that is done in cs_etm__sample().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 23159c33..789707b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1042,7 +1042,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	}
 
 swap_packet:
-	if (etmq->etm->synth_opts.last_branch) {
+	if (etm->sample_branches || etm->synth_opts.last_branch) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
