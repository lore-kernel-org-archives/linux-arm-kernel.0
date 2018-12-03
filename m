Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74913C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:56:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48398214E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JK9spqZE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKui9vrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48398214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XSJ1qAGHLKpXgAvQk5OAq19ew7VIdTLv7n2fkpJ6tKs=; b=JK9spqZEEly20EBTX6xh/TY9LE
	AMqlK9SGXvSgrA61Hx1IxQS8JHhC2haXoqJjU548PB0rk+AtZEVgbvltlEhZczpmLwsmqqMoSQ4Yx
	wMCR9eu5vWHU5AYlRR9QW0tx+nXQh+XOYj/TFHL9CoHc0CHEaO1GiCFTBgLHFcKzsHYqLJM5ZSRIr
	1PxTIj0IijlYe4hrfugn1o9a7Yybggr2n4uEE3Hs9HIzSHZQICCalYxNcXaIR4YQOssnoy3/bGOi7
	95uX7rox3izqn1A/+rOTse/mrK+PtJEEEWlupVIbZ+DoqyHGHK1dnQqv+wSH44xy1215po/veF8dC
	WTXFrwqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTx88-0003lX-Fq; Mon, 03 Dec 2018 22:55:56 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTx7Q-0002RD-4g
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:55:13 +0000
Received: by mail-pf1-x444.google.com with SMTP id c123so7143242pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 14:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3vpJNza9or+DqAPy2Ouz+IaFpD2uwWIrDBJByTZlu+A=;
 b=dKui9vrQfBjN7EW8N937VokmclZqajH1JGzyoa16yHvUwKfx6Al5KjESQQs9Ro9+2P
 0u5Q5IECHU3Oe8W2VZ3NlpD5cVMTOuoRtXXB7xacHUkJ7Xd0eM1m5cTJtRoS5bQexVb3
 uDZslqp9Y9n/UVkr+tYme+8Uq+hgQNAolvrcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3vpJNza9or+DqAPy2Ouz+IaFpD2uwWIrDBJByTZlu+A=;
 b=T16fXxGdsklwkfav2otOKeZat4N9hC64aF7BE6Z9TNmgESOm/FTQEBb+PEf5L/nveS
 v3yXVa3hMhMaVKdD92X9eApTHTCV9gyFzSeBTGYkZpcZAi2bQuzhVv+c5sC9+DDz5q+b
 qqbzRLnXt/c67HU2Tw1btGkwwReOLrdkbgv/r5Y4DwhgNn6B/zTX6oGy+FecCL6U0+6c
 dkwBZYlie2jOQcyFGkxXsQ/tOyQeotOEWYKfGGKEc87B19baErw2+PPVKScun++vEbDV
 DI8o9tRXqB3QMNYS4mKsI8v21+qyOnfQf6XABQ295NKuCet+gNWoSolfwXr8wDkMJXd6
 yUrA==
X-Gm-Message-State: AA+aEWbDplj5S7WTokum4NJnJ2lN4cLLXd1WmPqHz9qeh9uOhlWPUvgO
 160Hi31g0yobw3M6yayYMaRuIQ==
X-Google-Smtp-Source: AFSGD/WCfhAVS3Rr85zZIWf8gp40TUyaehMWbcaUuyPjoNpPjcEmmex7H1rJs/U2prA0VSMkg5r5Vw==
X-Received: by 2002:a63:e754:: with SMTP id j20mr14307610pgk.228.1543877709046; 
 Mon, 03 Dec 2018 14:55:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id v9sm20933057pfg.144.2018.12.03.14.55.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 03 Dec 2018 14:55:08 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v5 6/6] perf tools: Use ioctl function to send sink
 information to kernel
Date: Mon,  3 Dec 2018 15:54:56 -0700
Message-Id: <1543877696-17174-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_145512_291311_84848BA6 
X-CRM114-Status: GOOD (  18.51  )
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
