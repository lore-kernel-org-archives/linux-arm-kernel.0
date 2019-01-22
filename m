Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D68C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:13:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE962084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wm1Z1WeJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXYfPlRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE962084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FK1NZUI4yWjm18DrbpNA8zS7ijUd3t1n3dIYMI4djwE=; b=Wm1Z1WeJf+7cSe/tS9DJpNB3yr
	47uFk9EJ2ztT1hIMfs+oCU+vVkPZRyyVwpxFQoEWGgmNFcSdTcbS0uqTncsUT9jTZ79xaaKKmTJZE
	Ftg8yWSpE4K1yrmpst6Y23WgwCgj9bsYUKzkafvJM1eK3uQdktRIq4+cyW72y/tm/zrKpbdMpC5am
	mwuQtbGNeyRCfqCVRDZaQjX/1k1eWPV4pqAWo1GmlixOUuiZBneF2MheP3Mj5Qccfbn7plKRuRF9V
	HIZGab7ddEJym0gJO4LTqmd1k0yxXFfI9qjwCgTSbcp4fNkjzELvA/guPSCoj8TL0zh4IkNR3in2H
	6Rw8VmMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm0YR-00069b-Fw; Tue, 22 Jan 2019 18:13:43 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm0Wi-0004LZ-6z
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 18:12:05 +0000
Received: by mail-pl1-x642.google.com with SMTP id g9so11869568plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 10:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=L7eckfF2Zrk2L2hw3XycylNkNnZH54URJARS3kpuRe8=;
 b=BXYfPlRL/9ULQcWr54dC4Mv2z/oOD8AjTw4ZdXGJQ1iEcfPruZ0t2Ee5oxI2xeqkKQ
 zZuB9nQGg/x3AhZO/WvtTANu86lPvz3/+BEeNFID5LoCybqLtWt0rGH6WMxNgJ+x+iqp
 f/Q3rrcN9wAp5j9rzoUfwSKYkgFALFWt9zIgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=L7eckfF2Zrk2L2hw3XycylNkNnZH54URJARS3kpuRe8=;
 b=JWrD4LR5JuyDreeS4D4QjFm43qIgUq8r+r/FY6+YFFhnGiwtXgJAK6IzNj4DnA6ZMS
 29xj2LaVMygsYysRpPHawur8PDEAxtNOfwdklSKjGQSrZdyzUHxV9mt3l+Zq+BZTG091
 4O4brnZWRJlMyp+fEUFysDSmmPUbv5X1f9YRnEwXtaRGnSPoFtoY06XsqbqY8kxnMK6D
 hm6SmLCeNKg8BUxvHefTkgLRPpYcGmNxeex2xS9G6+tx8Q6+AbzAIWL2jYIqi2/d3TZ/
 Nhr6+RCUgSiiXAysNAvkOFPnEXnfmBUDriGt8oVslkTvCHr3Lkw0s4/fP40q0ymlxn1U
 Om3A==
X-Gm-Message-State: AJcUukdpZnRxAzXC4t+USBAYfSBDIp2tQKDVjoU6z4mwrUCfz28hl5Ey
 YzETVi8bjvl4E/nrJsZ+rWHjXg==
X-Google-Smtp-Source: ALg8bN50K9CCQUy91XGFFBkpnYXAI21ijsQ/W0uSghpC2CpGuirb++J5orUtFwY/BMG+xSDj49+OJg==
X-Received: by 2002:a17:902:f091:: with SMTP id
 go17mr35959173plb.235.1548180715665; 
 Tue, 22 Jan 2019 10:11:55 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id a18sm23489919pgj.30.2019.01.22.10.11.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 10:11:55 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org
Subject: [PATCH v2 5/7] perf tools: Use event attributes to send sink
 information to kernel
Date: Tue, 22 Jan 2019 11:11:42 -0700
Message-Id: <20190122181144.26645-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122181144.26645-1-mathieu.poirier@linaro.org>
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_101156_624471_405693CE 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, suzuki.poulose@arm.com,
 alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, will.deacon@arm.com,
 ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org,
 hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 jolsa@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The communication of sink information for a trace session doesn't work when
more than one CPU is involved in the scenario due to the static nature of
sysfs.  As such communicate the sink information to each event by using the
perf_event::attr:config2 attribute.  The information sent to the kernel is
an hash of the sink's name, which is unique in a system.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2f595cd73da6..4aa6193dcb50 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -22,6 +22,7 @@
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 
+#include <errno.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 
@@ -60,10 +61,45 @@ static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
+				struct perf_evsel *evsel)
+{
+	char msg[BUFSIZ], path[PATH_MAX], *sink;
+	struct perf_evsel_config_term *term;
+	int ret = -EINVAL;
+	u32 hash;
+
+	list_for_each_entry(term, &evsel->config_terms, list) {
+		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
+			continue;
+
+		sink = term->val.drv_cfg;
+		snprintf(path, PATH_MAX, "sinks/%s", sink);
+
+		ret = perf_pmu__scan_file(pmu, path, "%x", &hash);
+		if (ret != 1) {
+			pr_err("failed to set sink \"%s\" on event %s with %d (%s)\n",
+			       sink, perf_evsel__name(evsel), errno,
+			       str_error_r(errno, msg, sizeof(msg)));
+			return ret;
+		}
+
+		evsel->attr.config2 = (u64)hash;
+		return 0;
+	}
+
+	/*
+	 * No sink was provided on the command line - for _now_ treat
+	 * this as an error.
+	 */
+	return ret;
+}
+
 static int cs_etm_recording_options(struct auxtrace_record *itr,
 				    struct perf_evlist *evlist,
 				    struct record_opts *opts)
 {
+	int ret;
 	struct cs_etm_recording *ptr =
 				container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
@@ -92,6 +128,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (!cs_etm_evsel)
 		return 0;
 
+	ret = cs_etm_set_sink_attr(cs_etm_pmu, cs_etm_evsel);
+	if (ret)
+		return ret;
+
 	if (opts->use_clockid) {
 		pr_err("Cannot use clockid (-k option) with %s\n",
 		       CORESIGHT_ETM_PMU_NAME);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
