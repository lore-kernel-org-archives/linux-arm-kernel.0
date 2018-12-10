Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426C0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110842082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P98fHOQ2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxt7r7e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110842082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=mhYe5jz+OdbUgObL+7M7NaN+HbyX2rPlwAuYssX/GCo=; b=P98fHOQ2Vy1Lp1b8YTFEyCLfLk
	UNcBQj3iNtn49ze5sahwTBEdeftX4vLB5NQuzs/IQLFcSBlkGDoHfQP2BJXTEWgLR4eiyehrsFwqP
	iHkw5whYDH3o3j8WgaMMk6PHpMAxAVCCGsK7pJqnjjYeeEIEIpg3IpFFkb8o60rTVHKlapZXUA7t6
	K8L1htkDm/7joC7/jVkxzqsrEBw6qmfZ5cvOA4e+tlnkYJgJ6Ox/qGBThqlJCSaYncSJ5osMRu/mr
	NDHDM/+2Ox42nfoo4uuwEiqargplbl3txF/NSsRkg7u8KfqJ/M/rcSq04KS47Xl2Rsrx14WlgeJv/
	BXz2muXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHK0-000845-8n; Mon, 10 Dec 2018 08:53:48 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHJm-0007ng-Bu
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:53:39 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so9563358wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 00:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=39wBlDXGyPZlvdOM4v0qZ1Ghil7xJLHLF05MaMBQC4c=;
 b=bxt7r7e1AGI4295LFa3jazbFqPFJ32MDDhQyDn4+GuLOA0SEIMz9uk5rORpI2g3oZN
 qDMO3WpYTVfLKNe8SNjhp0YhRcwg2b6cjABzskwJK1WY2p+BK0xRMR3B0NehJEMpd2LE
 HL5EBnL+r1UUHKvB2FEbsUt2ojc/XuzWq95W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=39wBlDXGyPZlvdOM4v0qZ1Ghil7xJLHLF05MaMBQC4c=;
 b=CfPnHypINDMV7zgLNvY/SIW/+Sj3R/gRnHf/1WLT1eK31hkI7JamY4Udi2iBWIer/P
 fDmy0zF8epBBzQvOktaceWU14OalLT8Z+246w6X0dI+GwbiNBTFrZMe2glTixARFsOoZ
 aRD4dC+qo+IoqnAb1DmFUfMBpYIgbZP3IMNk9A4E+GeHO6jFuGUMexSGvEjF9TZG1OH/
 MgFBY4fsDA1ZIK4r2qDQ/r4so0laAlcYY9UbZAG6u4UKNtuqVwxSErPHKrIU4rWT4Vqu
 AGAVg3r+4m2ZMZ557q+DtQEBpSmXtWmOoyqvxKu62MGIuOah0nAKPqBKGMzhbfZ5cxXa
 LdlA==
X-Gm-Message-State: AA+aEWbTjJ1bn/77M6bREXJnHncPz6AhsoOHB2g8RhRytqzULg9f3z72
 ifTB7u7c2g6lV6ynfN9MZ5zlvQ==
X-Google-Smtp-Source: AFSGD/UCxOAAimwOtRz+m3ihM9FavjpRssg34v7WWRaeSby5HSzfleS40mAdMNyu1M2pfger1AN2sw==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr9403212wrh.267.1544432002659; 
 Mon, 10 Dec 2018 00:53:22 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id m4sm9097351wml.2.2018.12.10.00.53.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 00:53:21 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v2 1/6] perf cs-etm: Correct packets swapping in
 cs_etm__flush()
Date: Mon, 10 Dec 2018 16:52:56 +0800
Message-Id: <1544431981-24144-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_005334_770404_9CB56D5D 
X-CRM114-Status: GOOD (  17.41  )
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

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
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
