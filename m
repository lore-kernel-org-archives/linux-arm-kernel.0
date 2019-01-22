Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0FCC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:22:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C5021019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JuQ11fPt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7ZvJSuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C5021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7PTKTztt8nRYhyJwBen6nDzqR9Pw76W9yMwkO0tkskQ=; b=JuQ11fPt7l3fJ031W+3Fj0I8sB
	k0JiGASa5gDk6COfl71c3qa8EdRzaiBw90Pxc1C17O4i2fjMEV+Wr9EWWCe1gaDO99U4yFqrTs3Gf
	SFbRyIF/qwxxo2sCx5OMNuPluEU5SC2ASBBv+pFOle6XwQPdnm8KuHdqsOm6agOigOhIaNQ+JsbMn
	Cc9r6w5jP9v9EC2RmqUih218KYJQrpChPSn0BfLFjMUaQJ0mOUiJ6+j39XMXEJrn6s59gPqFWuBn6
	ImFCgT/1Ogh22dq9BDk2gukMEzVP3Qh0hA+KnsRTPypxNQmwjNZ2xz9w+F2gTB+1FQhDygV820nqr
	gESJr7Kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm0h0-0003ed-Vw; Tue, 22 Jan 2019 18:22:34 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm0Wl-0004Py-TC
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 18:12:05 +0000
Received: by mail-pg1-x541.google.com with SMTP id s198so11424414pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W6/A2tfSYGw9pTsmVq4n41iTRg138j1rlpbipIKTLNs=;
 b=K7ZvJSujgUfGxnCrede2OGo/ax6P3FNh6L3H192OJa8ot97BuR3wzx9K8SDLBeOkTe
 4S3o9LR6UwV8HDoFSAR8Vq/3h8CRshuYiWFFmE6Wq2K1oNunLsPmHYFkR9NARbWi/9yK
 N6zEp3DoqJPXqPfYO90XrmuSlklLeIAfDcn9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=W6/A2tfSYGw9pTsmVq4n41iTRg138j1rlpbipIKTLNs=;
 b=t+YYa++4Mm9OxewViC46F48K0tz48kiZxiEQQiiSMakyjCrvqBsjW1Gss14FxO9AGS
 PCP9r+SbTYHm3gG35kXq8vdGXAqEhUJwDQMYJ+QbnxhbEzIL5uN5Oy2F2U3klZvmpM2n
 lI9YYHxOmR7Mp9qElilcuo+M3C1hC5gEbLne20ACT4UHBzcQFp9eIaDBFM3SYC6xsi4i
 fboBxxZHmajC39IrsYvXfqyVNwrULvldszMlSef23Ecl1hm/Igqd616HMOogPJuNZfxo
 GmoBykMJj/lYLz/iQyr440t/d/iZIHqOa7h8yYCJIUWefRLQmLs5kVvdpTwE/qbWSqSv
 01rA==
X-Gm-Message-State: AJcUukf95JAbi0YbwvWToO00nREgX2Om0KCfC/ZgwB0nWJnHe+ydF48q
 n+7l91W+8YtJRWVBqSFSBbNUdg==
X-Google-Smtp-Source: ALg8bN4KOUN8xvSnGVqbaii1u68MNliActBhE/OlLVltBkwCV5ctGm9yLnMMrCAf5pUjKjZE7MkNcw==
X-Received: by 2002:a65:6684:: with SMTP id b4mr33005880pgw.55.1548180719155; 
 Tue, 22 Jan 2019 10:11:59 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id a18sm23489919pgj.30.2019.01.22.10.11.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 10:11:58 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org
Subject: [PATCH v2 7/7] perf tools: Remove PMU::set_drv_config API
Date: Tue, 22 Jan 2019 11:11:44 -0700
Message-Id: <20190122181144.26645-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122181144.26645-1-mathieu.poirier@linaro.org>
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_101200_791781_CFB0D331 
X-CRM114-Status: GOOD (  21.09  )
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

CoreSight was the only client of the PMU's set_drv_config() API.  Now
that it is no longer needed by CoreSight remove it from the code base.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/builtin-record.c   | 10 -----
 tools/perf/builtin-stat.c     |  9 ----
 tools/perf/builtin-top.c      | 13 ------
 tools/perf/util/Build         |  1 -
 tools/perf/util/drv_configs.c | 78 -----------------------------------
 tools/perf/util/drv_configs.h | 26 ------------
 tools/perf/util/pmu.h         |  1 -
 7 files changed, 138 deletions(-)
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 882285fb9f64..b637c37b8479 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -23,7 +23,6 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/debug.h"
-#include "util/drv_configs.h"
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/symbol.h"
@@ -566,7 +565,6 @@ static int record__open(struct record *rec)
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
-	struct perf_evsel_config_term *err_term;
 	int rc = 0;
 
 	/*
@@ -619,14 +617,6 @@ static int record__open(struct record *rec)
 		goto out;
 	}
 
-	if (perf_evlist__apply_drv_configs(evlist, &pos, &err_term)) {
-		pr_err("failed to set config \"%s\" on event %s with %d (%s)\n",
-		      err_term->val.drv_cfg, perf_evsel__name(pos), errno,
-		      str_error_r(errno, msg, sizeof(msg)));
-		rc = -1;
-		goto out;
-	}
-
 	rc = record__mmap(rec);
 	if (rc)
 		goto out;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 63a3afc7f32b..9c5b3b94bb38 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -52,7 +52,6 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/debug.h"
-#include "util/drv_configs.h"
 #include "util/color.h"
 #include "util/stat.h"
 #include "util/header.h"
@@ -418,7 +417,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
-	struct perf_evsel_config_term *err_term;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -515,13 +513,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		return -1;
 	}
 
-	if (perf_evlist__apply_drv_configs(evsel_list, &counter, &err_term)) {
-		pr_err("failed to set config \"%s\" on event %s with %d (%s)\n",
-		      err_term->val.drv_cfg, perf_evsel__name(counter), errno,
-		      str_error_r(errno, msg, sizeof(msg)));
-		return -1;
-	}
-
 	if (STAT_RECORD) {
 		int err, fd = perf_data__fd(&perf_stat.data);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f64e312db787..33e448f702b6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -24,7 +24,6 @@
 #include "util/annotate.h"
 #include "util/config.h"
 #include "util/color.h"
-#include "util/drv_configs.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/event.h"
@@ -1184,10 +1183,6 @@ static void init_process_thread(struct perf_top *top)
 
 static int __cmd_top(struct perf_top *top)
 {
-	char msg[512];
-	struct perf_evsel *pos;
-	struct perf_evsel_config_term *err_term;
-	struct perf_evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
 	pthread_t thread, thread_process;
 	int ret;
@@ -1232,14 +1227,6 @@ static int __cmd_top(struct perf_top *top)
 	if (ret)
 		goto out_delete;
 
-	ret = perf_evlist__apply_drv_configs(evlist, &pos, &err_term);
-	if (ret) {
-		pr_err("failed to set config \"%s\" on event %s with %d (%s)\n",
-			err_term->val.drv_cfg, perf_evsel__name(pos), errno,
-			str_error_r(errno, msg, sizeof(msg)));
-		goto out_delete;
-	}
-
 	top->session->evlist = top->evlist;
 	perf_session__set_id_hdr_size(top->session);
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index af72be7f5b3b..71e697e7df2d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -104,7 +104,6 @@ libperf-y += term.o
 libperf-y += help-unknown-cmd.o
 libperf-y += mem-events.o
 libperf-y += vsprintf.o
-libperf-y += drv_configs.o
 libperf-y += units.o
 libperf-y += time-utils.o
 libperf-y += expr-bison.o
diff --git a/tools/perf/util/drv_configs.c b/tools/perf/util/drv_configs.c
deleted file mode 100644
index eec754243f4d..000000000000
--- a/tools/perf/util/drv_configs.c
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * drv_configs.h: Interface to apply PMU specific configuration
- * Copyright (c) 2016-2018, Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- */
-
-#include "drv_configs.h"
-#include "evlist.h"
-#include "evsel.h"
-#include "pmu.h"
-#include <errno.h>
-
-static int
-perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
-			      struct perf_evsel_config_term **err_term)
-{
-	bool found = false;
-	int err = 0;
-	struct perf_evsel_config_term *term;
-	struct perf_pmu *pmu = NULL;
-
-	while ((pmu = perf_pmu__scan(pmu)) != NULL)
-		if (pmu->type == evsel->attr.type) {
-			found = true;
-			break;
-		}
-
-	list_for_each_entry(term, &evsel->config_terms, list) {
-		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
-			continue;
-
-		/*
-		 * We have a configuration term, report an error if we
-		 * can't find the PMU or if the PMU driver doesn't support
-		 * cmd line driver configuration.
-		 */
-		if (!found || !pmu->set_drv_config) {
-			err = -EINVAL;
-			*err_term = term;
-			break;
-		}
-
-		err = pmu->set_drv_config(term);
-		if (err) {
-			*err_term = term;
-			break;
-		}
-	}
-
-	return err;
-}
-
-int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
-				   struct perf_evsel **err_evsel,
-				   struct perf_evsel_config_term **err_term)
-{
-	struct perf_evsel *evsel;
-	int err = 0;
-
-	evlist__for_each_entry(evlist, evsel) {
-		err = perf_evsel__apply_drv_configs(evsel, err_term);
-		if (err) {
-			*err_evsel = evsel;
-			break;
-		}
-	}
-
-	return err;
-}
diff --git a/tools/perf/util/drv_configs.h b/tools/perf/util/drv_configs.h
deleted file mode 100644
index 32bc9babc2e0..000000000000
--- a/tools/perf/util/drv_configs.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * drv_configs.h: Interface to apply PMU specific configuration
- * Copyright (c) 2016-2018, Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- */
-
-#ifndef __PERF_DRV_CONFIGS_H
-#define __PERF_DRV_CONFIGS_H
-
-#include "drv_configs.h"
-#include "evlist.h"
-#include "evsel.h"
-
-int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
-				   struct perf_evsel **err_evsel,
-				   struct perf_evsel_config_term **term);
-#endif
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 350c54e0bd3d..569a6cbffd5a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -30,7 +30,6 @@ struct perf_pmu {
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head list;    /* ELEM */
-	int (*set_drv_config)	(struct perf_evsel_config_term *term);
 };
 
 struct perf_pmu_info {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
