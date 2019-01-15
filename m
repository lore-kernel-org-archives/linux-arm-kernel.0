Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99A1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:10:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C1A20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c7hxDSFK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqRrsVaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C1A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=qG14oFvgfZ4LJGnh3wmo0URbC68lwsjpXdGQmeMQK6E=; b=c7hxDSFK+Mg2L9+4OuNf9u4DX0
	qHK3EIIUyAlyo4II6MClDKHx0pdwWJwq7VznOY8qC/GP2W2jxi1egVGruXAmKkZtqWmDkregTJDhZ
	a5qhZ/B0vfe97bt7f1APjb5JAKs3Bkl24JdVKv32vvrFFQw7wWrfVcVkFhLwYdlz4cARDRTJPUMFa
	9pjM3BXYpX7L5XW80c4Y76evrCgonRHTTE/x7b6fXVjl3e0/3WjpiOWpPBDs7e9dXQ00FTSKdO8Mn
	8qiQjsLG5l4ubKlADm3lJqZlY40655IYvBgt7b0nRHtw/VcoSdlGdIx1kZPgBwh6j28mchTVmaXNY
	JTxUTk0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjXqG-0006mQ-RH; Tue, 15 Jan 2019 23:09:57 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXoK-00051X-I8
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 23:08:24 +0000
Received: by mail-pg1-f196.google.com with SMTP id w7so1869978pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 15:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gPrWMMpDRosRuuCKq7RVqqPV5xVc5OS0HdA7yr9gVbk=;
 b=QqRrsVaBJ7rICeZftdrm7Ke54BLqO4IpJ+ykpcY8TsczjNwJap13T56otWVRsJ2+6d
 HQIW4hI5sXRNBTbBG/FIL660lxD3zLbuIlWAXp0VjrpyFfrw5YhfqDp4DSvpo7XBtL+/
 qN5NlzimZrdkkaRSehkgJWGsM4F4jzcZMfrAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gPrWMMpDRosRuuCKq7RVqqPV5xVc5OS0HdA7yr9gVbk=;
 b=PRBm87MY4Qj2ElNA+i/EUkZs1z2kgPR/MzsCjV6e7854MOkHJyNtl7L7d7BDdu6SyL
 uF5rPcz6W3nqaXL3Bgou8cBd2dgJVheN4cEfB+YvmjMRlbmycW0FfYQqgytkDF4XmTNy
 V23NlzCA37T51OETEWCdQF/yJ+nfxzCFmz3cJzyOJeQ161Jv668Lg5ZWmPVnjlCu6nut
 /tTzmibHNKNEh6IvCzEB5VJNMdAvYxcRKXrUSMpMGrDCSZUXct9tVZxFBvcVirD+6hL/
 knT96yyEpQI2X8VIgLYRbwSJlrpDWGie4mY+0bdT0MJO97NgTl1JVo6696rtrvQ77t0q
 xbWg==
X-Gm-Message-State: AJcUukdiPNowsm4rRB6q5LdmrI2X4pkekQneMb1gBsMOqvW4JltYddcX
 yuvPAcvMP9yobzJslDgbft7jTQ==
X-Google-Smtp-Source: ALg8bN7d7naR6+z1U4DvgU8Htv0DbSptiG8r/8AUM4tBwI3+UrAiOCzopbH0dYKm9ks4/LdW332fhg==
X-Received: by 2002:a63:6cc:: with SMTP id 195mr5958903pgg.401.1547593675503; 
 Tue, 15 Jan 2019 15:07:55 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id h19sm4985928pfn.114.2019.01.15.15.07.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 15:07:54 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 5/7] perf tools: Use event attributes to send sink information
 to kernel
Date: Tue, 15 Jan 2019 16:07:40 -0700
Message-Id: <20190115230742.13730-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230742.13730-1-mathieu.poirier@linaro.org>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_150756_977273_177C202D 
X-CRM114-Status: GOOD (  15.91  )
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
 alexander.shishkin@linux.intel.com, will.deacon@arm.com,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ast@kernel.org,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com,
 schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 jolsa@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The communication of sink information for a trace session doesn't work when
more than on CPU is involved in the scenario due to the static nature of
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
