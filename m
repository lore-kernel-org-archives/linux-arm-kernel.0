Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D535C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:22:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6125120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oz9a7Kj9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYX1E+Qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6125120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GWK2nDMtxiFdrVgkHnnJ61d4rS0i7RMn1cxOwTpBEow=; b=Oz9a7Kj9VXnwr3Q4ELpoYzf4cn
	pYCw5xeZ44mq2LSKKVm4Vurn9bMIfQZO285Of82Fd/Tu+O0OuhBZyQGMhnuPo/6WlhaN+VxQXTBew
	Zr+/BjXtAah9ByhxHXh4YqiQHnMlQEPXxBnHpSem59uQ+ZpY75V09WmCNo3yj9/R+A59QsqWrx/fo
	ODoI7seydJH8QBN1brf3imCWgBN4NvABXjMa6kUeo2WAJa915OgQKXm5GKIZy39js7UbxZRUaqbaS
	4ZJraoci/4t3jeJgTthToUwzXuy0jkizZYPfPauSgEk43zMXlcyXb180Xlyg6FM0ivOQ6V7iUAXFc
	U9QKZvSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm0gz-0003dy-PR; Tue, 22 Jan 2019 18:22:33 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm0Wj-0004NY-Pi
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 18:12:03 +0000
Received: by mail-pl1-x643.google.com with SMTP id u18so11859727plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W+tcSbssL1cjoomd1/kZjJ7IjRwzQZIgCHeNiM3a0+8=;
 b=iYX1E+QkQtS+reozDRSNxJxAJ9t+crCH5YtMtbQ4hKqfNhGWIE6Oajd4RJIpXCTU2N
 JUI21kO42yJuv8h2ZyR1KtgfDrWQ88ir7AC0UbLF8NrzgjWKi715QVxMIgYfHMtgGM7x
 AdrigTyORi+AoTL5gf8Mvab/tfhrRU0HH3y6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=W+tcSbssL1cjoomd1/kZjJ7IjRwzQZIgCHeNiM3a0+8=;
 b=rSKDwApeZ4i7k/ODsTtdVEsKr++HtNoNNRrp/25C5mK5DqiUz4qnNdbMsrlKi6s/tP
 ItruZmc+KY5QAd272fLG1/pQ7dfMYuism+U8Lo4rU3ejmHDzvT9Fd24HK6T7+t3lkFtj
 iwYX7FYNQ/SQwzjM5YBGqxb2kiMosZA95GhPmrrDp5wybFrH8CrEIBkvyvsKPlwrysSp
 x587BuQYMgYaOEKT2Cf7PXPBIr4CUT/6ZUVSlWSqKN3IkmKmBwQ421xpiCxMYUxkmipR
 CPxAi2w13KRwqmrdJ9TCq2XIhOz6n63PHMbzBlFS0lA0ytWwWL65IB1ls63GnssC1DnQ
 maiQ==
X-Gm-Message-State: AJcUukcyQ2KAOTfnc6H1RHMVevuUcl9S7NGf/8Hf0yUtxZPnywQ1reGn
 dVhZuNFPheUNhUTcKVK/cIp0iw==
X-Google-Smtp-Source: ALg8bN6wxbGghhBavhc66500P1ObbbqDRCBN30ofvJI9xoWIhRiusoSZPhokath8yZI+3sutAiZi6w==
X-Received: by 2002:a17:902:2862:: with SMTP id
 e89mr35764673plb.158.1548180717330; 
 Tue, 22 Jan 2019 10:11:57 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id a18sm23489919pgj.30.2019.01.22.10.11.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 10:11:56 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org
Subject: [PATCH v2 6/7] perf tools: Removing CoreSight set_drv_config() API
Date: Tue, 22 Jan 2019 11:11:43 -0700
Message-Id: <20190122181144.26645-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122181144.26645-1-mathieu.poirier@linaro.org>
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_101158_399238_A79C52EB 
X-CRM114-Status: GOOD (  12.83  )
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
index 4aa6193dcb50..9a4a8153e4c2 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -26,9 +26,6 @@
 #include <stdlib.h>
 #include <sys/stat.h>
 
-#define ENABLE_SINK_MAX	128
-#define CS_BUS_DEVICE_PATH "/bus/coresight/devices/"
-
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
 	struct perf_pmu		*cs_etm_pmu;
@@ -638,54 +635,3 @@ struct auxtrace_record *cs_etm_record_init(int *err)
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
