Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91E4C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88952222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lcNg4alp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvD3sPQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88952222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RkHNr0Cbf1gLl1nWFQvLu72xIGyq4ZXhgShHMzXXy48=; b=lcNg4alpL/DxlpRyCdemgD8kMB
	rOZp+3FEmrwcD7rX65dkpAeCo/c1xRLxN1JSFxgoxVtFYRTuN/iY3Rlv8NiqoyzOcHgLFjCTP+LH7
	6EnBWCvL7RboeoSIyUNvqb5ZU/erWAxjWgNoN46l5BEAMhay9nlFKO664JSVK+ca5/9j0Tqy4Xtte
	wGNZiBfQnc6291KMqTcYBpVap1xjiiPiRsg+RreqhfkLnVuxZdzrEYOBoBZpSBqannOFsAsEW13r7
	6dwHbm2YM30y8hG+sRbqwTbHZ+tY9d+ge4FVlJseXeHJ5nAEq8hnfIoC13oqyk7hqIzkDHQTl9qNv
	DCnrKBJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtbgN-00026g-2Y; Tue, 12 Feb 2019 17:17:19 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbfU-0001I0-D1
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:16:25 +0000
Received: by mail-pl1-x644.google.com with SMTP id bj4so1596934plb.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/lnWMMCIsg4/tFUsl2j1cd75JRahCaG7A5ViWQnd0OY=;
 b=nvD3sPQVTmPup1RY7P6dkHQg3RQbopWaNl2R7n0ekAHhDAV5NE/q69+aIzpOmXe6XU
 IcwLyhmnoL2lS90lSvUSI/ta9vrDvlC1/Ub3O/uynQAv0zL3YY+dqzL2GZ3Yw8m49APy
 +OzEmV3koMukBg5tYr/x0HFN3dTnYQuSOy0JH9M2qBzjO9DMzqagpMDhG/GBa8f247iQ
 gAz0RJOK0D+R30EfucoL6waUOOzflugJpiWEJATPoMRo61FvUY8AnX9CnnQWTuAYsnN6
 SZfaOJBeasDCJpcvhKRJYeqCXl7sKm7S+utqmOCNtl5qcQqPoucR/aXS4Zu03+DOsAYY
 v19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/lnWMMCIsg4/tFUsl2j1cd75JRahCaG7A5ViWQnd0OY=;
 b=L1nH3e25JUtI9PJtoSyjhTsk01EnX1WJ05NV4uH2+833y43TaEQpBF2//bM3qPJcn1
 SCe5Yca1vzJLfSKB8pMqvMT+VEKHmYqqfgpowqk88byfAXJ+BF6ODFc8QfrwNnNmAUKd
 S/FC9dfuWI0Ut/qwmpSr8GVV6pPQqCPtqpBPrP+cA1ar8y9e+Ng8F04poloiWU8aaogw
 ve2uOXLbmeC+grO6mHWetc1ypVDn56v0smB0crnvb5HzDSMMgy5462vaPp1I85Gn1maI
 a0nF8/BFqYOprXH/adRDn1HxK12m7DCQ9enFHN0HYObPxbPFsn1Hm2kbX4oh/H0a7LDn
 hkYw==
X-Gm-Message-State: AHQUAuZYQ8RSm37M7TITPM3dKeTrshrNRlgSsxjzQKJYN3/Rb3zq/xO2
 awbDkUwNuSthER+iyUNmTvcdPA==
X-Google-Smtp-Source: AHgI3Ibg4yRTiwUB97N4T/Zowkzyk+Qz66rIKYI5nXP8LBvvnCG7LvRXo7CLmn5dSW1yFeu7OplNiQ==
X-Received: by 2002:a17:902:9884:: with SMTP id s4mr4777634plp.1.1549991783804; 
 Tue, 12 Feb 2019 09:16:23 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 09:16:23 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH 03/13] perf tools: Fix wrong return values in error path
Date: Tue, 12 Feb 2019 10:16:08 -0700
Message-Id: <20190212171618.25355-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_091624_436376_BEE802C8 
X-CRM114-Status: GOOD (  13.26  )
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

Function cs_etm__mem_access() is supposed to return a u32 but the error
path returns negative values at a couple of places, something that really
throws off the clients using it.  Fix the situation by return '0'.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1d9419a0cf0c..f396fee9bb95 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -324,7 +324,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	struct	 addr_location al;
 
 	if (!etmq)
-		return -1;
+		return 0;
 
 	machine = etmq->etm->machine;
 	cpumode = cs_etm__cpu_mode(etmq, address);
@@ -332,7 +332,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	thread = etmq->thread;
 	if (!thread) {
 		if (cpumode != PERF_RECORD_MISC_KERNEL)
-			return -EINVAL;
+			return 0;
 		thread = etmq->etm->unknown_thread;
 	}
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
