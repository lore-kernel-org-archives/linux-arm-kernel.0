Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFE4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:49:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE644218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eO94/GtF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKYMv/vV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE644218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kS8y/twlaIMn5aMv/gSHKgrLBddeCW64TEtO1/SScVk=; b=eO94/GtFYi0lLpG2r4d+a9d7BU
	g5Wlgu2z4PlMhBo8YnSl8ZtEpzk+roXRVxZnlLDaWNn+XEEddjOtPuRc8RgsaivSXrKzu8BKwJzQs
	9od6NbyicHBjwLu5y5sWqq/85b7mh7IXGidwcyYJJmoCeEXdddhnwCa/mSGmFTSziRvNWDo79YP2J
	wYJ45tCYUV6ItvXdMS48nJA5o5EkvxzBpiAPIUFfjZsuffSYYGNYhwBw+RVbvd6vbg8ke+PVPeDrc
	GmU+sC9ofPV0SR4vHRj0auwli2P/PXfH8E1FbsAoi8iJglf43eZ5sf7nKNVgOPXB1mOE/AQxdP7cM
	6zYHPJkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpHOU-00046o-H4; Thu, 31 Jan 2019 18:48:58 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpHN0-0002vF-40
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 18:47:32 +0000
Received: by mail-pl1-x641.google.com with SMTP id u6so1864198plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 10:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bRWUwYnj28kBvbJLtyjNHTdBWqKDkbKXjpXnSK8ue0c=;
 b=dKYMv/vVYjuiSgre0jRV1GEM0M8C+cEcETL2BWXZTHSoZiQ2SEBsPqSDRsCr6Kw8i8
 2JqPlL+ehsAS6kHAuDvFUkBhGrI/ScPCk3OTLiTA7lA6IIn2SZcJrNcOvWrK7oqKNSoN
 aDTrlc5k9W6W1uUmX+BIemad6qq/WMVyMiTd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bRWUwYnj28kBvbJLtyjNHTdBWqKDkbKXjpXnSK8ue0c=;
 b=C0zPNF0KyaNdSU683K7r3ljebf/6EsUXeUg7rsH59siZFECnrsZ1S8kWhtSQzyoyUp
 +gz7p7Z43fbptp9kZJW6IDFPS02DBxLELg6kEiX1GOGj/Dn65XbDTEqakJSefzLW0uqM
 gK4KATSaKZuBZtqr+bzHCJRB9qHQ9vMRniqZkjaMJOJ+qdn4nP3fRdqyYhJFvNZdvaej
 zCp+m/XQl8xapCIW/r+bBvJ2IUcqqMb7TV3f3T4PNzd5Bl0530yfXxzGMPWCKvin1+3h
 qR5cbQn3UjL0EIYdm4RD72m6ny8mHjZzfAFrtmnP1bDE5E0V6RE1Xcy6mTW8gtClvh0R
 t0fA==
X-Gm-Message-State: AJcUukd6itX9RjDZaINHBJ9gxL0qHoKDd7/MND4wa4KQ3EdH3Dl9mo1r
 b1VTvmaVHkxr5lxMX1ctKAxh/w==
X-Google-Smtp-Source: ALg8bN5ux3i3o1Ncjpv7IAxd1hpYjqWCeNIVuq9Cr+oy1o1TGUZhLOBLArOVo9u0Y9xm8az1sVDyYA==
X-Received: by 2002:a17:902:28e6:: with SMTP id
 f93mr35604380plb.239.1548960445634; 
 Thu, 31 Jan 2019 10:47:25 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id o66sm6236234pgo.75.2019.01.31.10.47.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 10:47:24 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org
Subject: [PATCH v3 5/7] perf tools: Use event attributes to send sink
 information to kernel
Date: Thu, 31 Jan 2019 11:47:12 -0700
Message-Id: <20190131184714.20388-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131184714.20388-1-mathieu.poirier@linaro.org>
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_104726_620930_6C8523A6 
X-CRM114-Status: GOOD (  15.37  )
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
more than on CPU is involved in the scenario due to the static nature of
sysfs.  As such communicate the sink information to each event by using the
perf_event::attr:config2 attribute.  The information sent to the kernel is
an hash of the sink's name, which is unique in a system.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2f595cd73da6..4f31cf0d1e6d 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -5,6 +5,7 @@
  */
 
 #include <api/fs/fs.h>
+#include <linux/bits.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/coresight-pmu.h>
@@ -22,6 +23,7 @@
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 
+#include <errno.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 
@@ -60,10 +62,48 @@ static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
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
+	if (evsel->attr.config2 & GENMASK(31, 0))
+		return 0;
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
+		evsel->attr.config2 |= hash;
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
@@ -92,6 +132,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
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
