Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9C9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:23:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2C62133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n8eqmdDl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBT0TGuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2C62133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XSJ1qAGHLKpXgAvQk5OAq19ew7VIdTLv7n2fkpJ6tKs=; b=n8eqmdDl+kb3Z1pI4rpG3U5Yrp
	nJ35f7CXteYaBHeUyym7iDazDg2gl2K2ZW8YcLQ+JwlVcz5LDS81POFuWCVatc3wa9XpvIshd8h4Y
	zeV6f9cfJShWeiDMtvHExWD1hPIZAnIaPru19lBBARtXWSeWK7gfYKgUs8pf7I5/sR4dk1Hk8yK9P
	6LMgi3yveAQPyYOg9ecoEbj9h7mi5J0BIQUns6bWtfjFoKRKZ1KGIHLEZx0VcFp7zAe05WJiuJrWT
	TBdhrPIDRl4/TGLa6KsLD8SYR5IhQGfSWC/55ofthjJad2j3U/U8TUuERs6oKbQPoDu9yK/GQaK1v
	Xr12EebA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYwcO-0005Dt-LB; Mon, 17 Dec 2018 17:23:48 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYwao-0003nG-GA
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 17:22:19 +0000
Received: by mail-pl1-x642.google.com with SMTP id b5so6444708plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3vpJNza9or+DqAPy2Ouz+IaFpD2uwWIrDBJByTZlu+A=;
 b=WBT0TGuzBRScvsuhIEQeJ4p5P/ED7pvZwMP1kvAA1n//d+x1KAuFV92CjrST4/Vzml
 25yzhLdHeKYAFk+jZaWo74/5nIrkljnJhwDC1jFUIYhUQ0fpKf/FUzzRyUGlPuGnpcSo
 WmX62nnHyUDu8zelXpQJOHbYsDzeBAAXBsq0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3vpJNza9or+DqAPy2Ouz+IaFpD2uwWIrDBJByTZlu+A=;
 b=fpBuL5Fjx1KhJvFQc7gRXBIxuMpU445LI/wOvLj0aXm3q8u4o3vsx/Rdg6zSi/OTH+
 8cJPEcWa75gbWeYW0dedM/VkQnGlHCXQBfbUsqCwrsexIiFd09+6VrjCfzrm4UyGDeHn
 vxFpl4DR7+Niw20Xv2TRB8NYfoFVkOwlK1A9hMBt3w46KrvHnGhzuR5KPxvA2cjDt+4J
 C+uGy2XS8YJtpYH1bsVI3FuZbu8zKRpFNcJGStCiuYlYAswR6M8hvJ/RoWIOMwB/Vj9D
 wAoFLnUy2nPgumYCk0YPGGrFPqnQjHQ7XzYPo01i0TSoV14OrRXdrbsFCB74hr0n+aaF
 N/gw==
X-Gm-Message-State: AA+aEWadZpImSvacEG9AU04S25rzm29qhRFDstPKjH835J+7hRqFMFmF
 m7hkQ9BmxVa6JkQjUvS2cGy1SQ==
X-Google-Smtp-Source: AFSGD/W3rAQeKcrlu6C2xJRjkJM0Wm+1HGgVskXUMBLHLFPSTZQCZlcMuiXSTGc7Vs8VZa+iY4DSlA==
X-Received: by 2002:a17:902:4681:: with SMTP id
 p1mr13799807pld.184.1545067319819; 
 Mon, 17 Dec 2018 09:21:59 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id j6sm20526648pfg.126.2018.12.17.09.21.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 09:21:59 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [RESEND PATCH v5 6/6] perf tools: Use ioctl function to send sink
 information to kernel
Date: Mon, 17 Dec 2018 10:21:46 -0700
Message-Id: <1545067306-31687-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_092211_372250_57AE101E 
X-CRM114-Status: GOOD (  18.12  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org,
 alexander.shishkin@linux.intel.com, will.deacon@arm.com,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ast@kernel.org,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com,
 schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 suzuki.poulosi@arm.com, jolsa@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The communication of sink information for a trace session doesn't work when
more than one CPU is involved in the scenario due to the static nature of
sysfs.  As such communicate the sink information to each event by using the
an ioctl command.  The information sent to the kernel is the component's HW
address, which is guaranteed to be unique on the CoreSight bus and known to
the kernel.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 66 +++++++++++++++++++++++++++++++++++++--
 tools/perf/util/evsel.c           |  6 ++++
 tools/perf/util/evsel.h           |  1 +
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d8081c2e6d44..41e394806707 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -22,11 +22,13 @@
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 
 #define ENABLE_SINK_MAX	128
 #define CS_BUS_DEVICE_PATH "/bus/coresight/devices/"
+#define AMBA_BUS_DEVICE_PATH "/bus/amba/devices/"
 
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
@@ -619,6 +621,41 @@ static FILE *cs_device__open_file(const char *name)
 
 }
 
+static int cs_etm_check_drv_config_term(const char *name, u64 *addr)
+{
+	char path[PATH_MAX];
+	const char *sysfs;
+	int err;
+	FILE *file;
+	u64 start;
+
+	/* CS devices are all found under sysFS */
+	sysfs = sysfs__mountpoint();
+	if (!sysfs)
+		return -EINVAL;
+
+	/* The resource file contains the HW start address of this component */
+	snprintf(path, PATH_MAX,
+		 "%s" AMBA_BUS_DEVICE_PATH "%s" "/resource", sysfs, name);
+
+	file = fopen(path, "r");
+	if (!file) {
+		pr_debug("Unable to open file: %s\n", path);
+		return -EINVAL;
+	}
+
+	/* We just need the first value */
+	err = fscanf(file, "%016lx", &start);
+	if (err != 1) {
+		pr_debug("Unable to get resource start value for: %s\n", path);
+		return -EINVAL;
+	}
+
+	*addr = start;
+
+	return 0;
+}
+
 static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
 {
 	va_list args;
@@ -635,7 +672,7 @@ static int __printf(2, 3) cs_device__print_file(const char *name, const char *fm
 	return ret;
 }
 
-static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
+static int cs_etm_set_drv_config_term_sysfs(struct perf_evsel_config_term *term)
 {
 	int ret;
 	char enable_sink[ENABLE_SINK_MAX];
@@ -650,6 +687,21 @@ static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
 	return 0;
 }
 
+static int cs_etm_set_drv_config_term_ioctl(struct perf_evsel *evsel,
+					    struct perf_evsel_config_term *term)
+{
+	u64 addr;
+	int ret;
+
+	/* First check the input */
+	ret = cs_etm_check_drv_config_term(term->val.drv_cfg, &addr);
+	if (ret)
+		return ret;
+
+	/* All good, apply configuration */
+	return perf_evsel__apply_drv_config(evsel, addr);
+}
+
 int cs_etm_set_drv_config(struct perf_evsel *evsel,
 			  struct perf_evsel_config_term **err_term)
 {
@@ -660,7 +712,17 @@ int cs_etm_set_drv_config(struct perf_evsel *evsel,
 		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
 			continue;
 
-		err = cs_etm_set_drv_config_term(term);
+		/* First try the new interface, i.e ioctl() */
+		err = cs_etm_set_drv_config_term_ioctl(evsel, term);
+		if (!err)
+			continue;
+
+		/*
+		 * Something went wrong, we are probably working with an older
+		 * kernel.  As such use the sysFS interface, which will only
+		 * work for per-thread scenarios.
+		 */
+		err = cs_etm_set_drv_config_term_sysfs(term);
 		if (err) {
 			*err_term = term;
 			break;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d187059a373..8aa2b79c3314 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1195,6 +1195,12 @@ static int perf_evsel__append_filter(struct perf_evsel *evsel,
 	return -1;
 }
 
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, u64 addr)
+{
+	return perf_evsel__run_ioctl(evsel,
+				     PERF_EVENT_IOC_SET_DRV_CONFIG, &addr);
+}
+
 int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter)
 {
 	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3147ca76c6fc..6be7560bc986 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -276,6 +276,7 @@ int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
 				   const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, u64 addr);
 int perf_evsel__enable(struct perf_evsel *evsel);
 int perf_evsel__disable(struct perf_evsel *evsel);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
