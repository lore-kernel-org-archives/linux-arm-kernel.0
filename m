Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D28CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:49:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55582218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W89+JB5L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEitRYvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55582218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=D5lllTDlBVtx+fp+jxVsZxQLsn5WRUmEaBNs4twWC14=; b=W89+JB5LxJJkoHxTTI8Z7T+Qlr
	299EDJPgATPQlYbEHoykyTe0iVkjD7Urd4AzZSxydQtRWio9EGjH+M/Nww2oU51WSKSU/UddP4ea7
	aExvnFDeQ03rg6uEQnF52IRCjbhkNLyBt+zJuypRS6Aykijll4VVsty7zdWC8jVE9PkJeD6M7Fymn
	meXDtvJozB5WbA+8Vw7C1nCQyNSBZ+viPlF9fzYZIkDer2NQWhMggPKcKinYOs4Q+2PwsFK4/I/RO
	dE9SZwDZp+R4crEvKfvKDmOtPQ00BtiNIkn7UUjm0hOEM0KdyhS00VYRhIXgU+bxQdZEqLEZWAo6K
	GlgaRSjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpHOm-0004No-CQ; Thu, 31 Jan 2019 18:49:16 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpHN2-0002xI-3j
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 18:47:37 +0000
Received: by mail-pf1-x442.google.com with SMTP id u6so1867884pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tgDBy5pU4TSH5DxOCpIvkhjQNbxctYyd7XLZVLAf0nI=;
 b=OEitRYvbdt7M0rQEZwQ0hu+ke2w8T89lMjjsZruG8ofpjewHOgcDS5hxPEAP+vX1sO
 d/YF2ewC8ZGswcUekRvxuUhYkaj7difJ/dM9j1X0+lxgL2AC0QAFahUvWVLvkxJt0JXV
 ZGDf0aPWW6bIapvpzabnJQq4r7GTT8D8bPMNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tgDBy5pU4TSH5DxOCpIvkhjQNbxctYyd7XLZVLAf0nI=;
 b=etyCeI8FwktZ+UMFl/FwXlPewBZwnDq6dMNWUvzzhqOPrlvq7fevtC69WZ+W/XDZJc
 dxBq6Nr98v+3qc3Y+r/88kuiwExtq52Akap4An+oHYZs5lGmLEtkTMzCNfyARUtszOp5
 wfYLYtM2XaG5b7v+rekQZN+vrzUkBFOY2vpvezcpgVhLh5L7s/wNuo4XFrN2appj5O/B
 9C1HMufO8psmkv8HNgCkGlfqjwd8qWK7DZNyYbP/Mfk10nK2o8k3IlSvc0T4NSlBKXij
 5Fwcc9DUpL6XVYsTxc8yhQ1pEfsWLm0bC3bME1LktyDdBF0RmY3S31zWh41H22KJ+y/b
 tJoA==
X-Gm-Message-State: AJcUukcfQ1cX1s3SoO96YNHNWPF0kV/m01jDBJH9gGrrh+P0rNgYjUyP
 XnL5hwKvX+yXKVi4ENy9A3zgmQ==
X-Google-Smtp-Source: ALg8bN5zCSvaw0TDn5aCH92YZ1sv62Z9CwcBzL5+6SWWfyCH0sDj8EUnOb0JFFBnpbtmsfRdB1Ph7Q==
X-Received: by 2002:a63:2f86:: with SMTP id
 v128mr31458623pgv.407.1548960447382; 
 Thu, 31 Jan 2019 10:47:27 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id o66sm6236234pgo.75.2019.01.31.10.47.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 10:47:26 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org
Subject: [PATCH v3 6/7] perf tools: Removing CoreSight set_drv_config() API
Date: Thu, 31 Jan 2019 11:47:13 -0700
Message-Id: <20190131184714.20388-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131184714.20388-1-mathieu.poirier@linaro.org>
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_104728_671344_D28112F9 
X-CRM114-Status: GOOD (  13.16  )
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

Now that event's config2 attribute is used to communicate sink selection
to the kernel, remove the old set_drv_config() implementation since it
is no longer needed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 54 -------------------------------
 tools/perf/arch/arm/util/cs-etm.h |  3 --
 tools/perf/arch/arm/util/pmu.c    |  2 --
 3 files changed, 59 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 4f31cf0d1e6d..911426721170 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -27,9 +27,6 @@
 #include <stdlib.h>
 #include <sys/stat.h>
 
-#define ENABLE_SINK_MAX	128
-#define CS_BUS_DEVICE_PATH "/bus/coresight/devices/"
-
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
 	struct perf_pmu		*cs_etm_pmu;
@@ -642,54 +639,3 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 out:
 	return NULL;
 }
-
-static FILE *cs_device__open_file(const char *name)
-{
-	struct stat st;
-	char path[PATH_MAX];
-	const char *sysfs;
-
-	sysfs = sysfs__mountpoint();
-	if (!sysfs)
-		return NULL;
-
-	snprintf(path, PATH_MAX,
-		 "%s" CS_BUS_DEVICE_PATH "%s", sysfs, name);
-
-	if (stat(path, &st) < 0)
-		return NULL;
-
-	return fopen(path, "w");
-
-}
-
-static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
-{
-	va_list args;
-	FILE *file;
-	int ret = -EINVAL;
-
-	va_start(args, fmt);
-	file = cs_device__open_file(name);
-	if (file) {
-		ret = vfprintf(file, fmt, args);
-		fclose(file);
-	}
-	va_end(args);
-	return ret;
-}
-
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
-{
-	int ret;
-	char enable_sink[ENABLE_SINK_MAX];
-
-	snprintf(enable_sink, ENABLE_SINK_MAX, "%s/%s",
-		 term->val.drv_cfg, "enable_sink");
-
-	ret = cs_device__print_file(enable_sink, "%d", 1);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
diff --git a/tools/perf/arch/arm/util/cs-etm.h b/tools/perf/arch/arm/util/cs-etm.h
index 1a12e64f5127..a3354bda4fe8 100644
--- a/tools/perf/arch/arm/util/cs-etm.h
+++ b/tools/perf/arch/arm/util/cs-etm.h
@@ -7,9 +7,6 @@
 #ifndef INCLUDE__PERF_CS_ETM_H__
 #define INCLUDE__PERF_CS_ETM_H__
 
-#include "../../util/evsel.h"
-
 struct auxtrace_record *cs_etm_record_init(int *err);
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term);
 
 #endif
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index e047571e6080..e4619f2fe7ce 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -8,7 +8,6 @@
 #include <linux/coresight-pmu.h>
 #include <linux/perf_event.h>
 
-#include "cs-etm.h"
 #include "arm-spe.h"
 #include "../../util/pmu.h"
 
@@ -19,7 +18,6 @@ struct perf_event_attr
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
 		pmu->selectable = true;
-		pmu->set_drv_config = cs_etm_set_drv_config;
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
 		return arm_spe_pmu_default_config(pmu);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
