Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E086C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:23:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682B52133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KC+hEgue";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPgpo2wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682B52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Sv+iyWF2rUrODpOEt59AeXXS4ZLfFjwz1X85VVSzpsM=; b=KC+hEgueK5Y1sEe5sH79ODVASu
	K1BVOJyjNBreMkTSXtVcVI1owY1wOmxncjEoRNB9Xzu8KfA3skrERYZKrF9yxo4VJMZjfKHQS3PWj
	tqgfUhfc9okoMtcTOoL/p9CB955VtL1UGZWLVHTIpig1j9EHACcFx0m7XYLnVtLjSWFEflUqs6nPv
	GgxN3LGnymB2/xfp60dyr8pAtts/WzmAsPvZ9JAxh5Zm8ds4hcPiLCWQqFtx0c0BolZI7pbGbEWws
	fkPqTBLPjOBPcZqul/v56lFW9q9vzt2YBmz6xp4JEq+j1WU8ASrZZ9cKO6dHVxjytENyyLgno27Lq
	kN9lTpWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYwc8-00050K-Ly; Mon, 17 Dec 2018 17:23:32 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYwam-0003mu-LE
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 17:22:16 +0000
Received: by mail-pg1-x544.google.com with SMTP id m1so4793810pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 09:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OR+Emv/hXsuIpqoetjY/PmsPRuVeBGeNKk4nTUUJUzU=;
 b=dPgpo2waSyuc9a3TJA/V7dNAXshyYck6CqdnbQRgU5Z8zar4mMIWk+eTFg6ZmMowMJ
 N/bIULoBUbIuAso+anc3LL6Q/cNO7lU7KHqQv4YNR3XXy6mQ39XEDbAqytopUKvgrQ7B
 eIMoJAqVvSn1Ft50WIl077RWF3ZxDBIV6F5nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OR+Emv/hXsuIpqoetjY/PmsPRuVeBGeNKk4nTUUJUzU=;
 b=Em6EwEHGRSTvMUT8iPN+l3b77hkuzOlDlsgJP5FUECLp22NJo2+VlbkKWQteUr30de
 z0pmd5eOPUx/IDkpxhhY/fNX4DpNv1xaAafaOqNw1jH5JTiRtFD5CghFXa9GdvvJhrPA
 B3KsgLXmwgXdUmmyootQtpAnzm4plNnH5/+dbB0GAP1pZ6yyomyrwnfaSKav24fEHD26
 Hl/Xq8jDb2kGEJxcnrNooQ5h+mfiPJFIWe/zlVhgRQv+FbKq9XjOTtFzCGRgylBLIKQ3
 61DoIg2Vehfdmc1yBnBBodSyQ+m4btXBKzGQ6tv43WRXRpLZdlKOxnb57pjJHTBmKm0h
 e7+w==
X-Gm-Message-State: AA+aEWaJxrlwP95sVaCOpbUNh9L04Wh/dTVdbPp1hDcCbe4nHJe3nQjN
 oyLKv32AfUD9UvmxXVte20CY6g==
X-Google-Smtp-Source: AFSGD/WAWKc70PnSQzQaIOZ1xNTXeUObZSaclE2+xePqJ+024sbesNVNAUsByEhFpY7R9d4KcwH1yQ==
X-Received: by 2002:a63:f901:: with SMTP id h1mr12824226pgi.154.1545067318085; 
 Mon, 17 Dec 2018 09:21:58 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id j6sm20526648pfg.126.2018.12.17.09.21.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 09:21:57 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [RESEND PATCH v5 5/6] perf tools: Make perf_evsel accessible to PMU
 driver configuration code
Date: Mon, 17 Dec 2018 10:21:45 -0700
Message-Id: <1545067306-31687-6-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_092209_280698_801E14D1 
X-CRM114-Status: GOOD (  19.16  )
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

Make the perf_evsel available to the PMU driver configuration code.  That
way function perf_evsel__run_ioctl() can be used from there and
information pertaining to the perf_evsel_config_term is still available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 22 +++++++++++++++++++++-
 tools/perf/arch/arm/util/cs-etm.h |  3 ++-
 tools/perf/util/drv_configs.c     | 30 +++++++-----------------------
 tools/perf/util/pmu.h             |  3 ++-
 4 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2f595cd73da6..d8081c2e6d44 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -635,7 +635,7 @@ static int __printf(2, 3) cs_device__print_file(const char *name, const char *fm
 	return ret;
 }
 
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
+static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
 {
 	int ret;
 	char enable_sink[ENABLE_SINK_MAX];
@@ -649,3 +649,23 @@ int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
 
 	return 0;
 }
+
+int cs_etm_set_drv_config(struct perf_evsel *evsel,
+			  struct perf_evsel_config_term **err_term)
+{
+	int err = 0;
+	struct perf_evsel_config_term *term;
+
+	list_for_each_entry(term, &evsel->config_terms, list) {
+		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
+			continue;
+
+		err = cs_etm_set_drv_config_term(term);
+		if (err) {
+			*err_term = term;
+			break;
+		}
+	}
+
+	return err;
+}
diff --git a/tools/perf/arch/arm/util/cs-etm.h b/tools/perf/arch/arm/util/cs-etm.h
index 1a12e64f5127..a3f8dde6ccef 100644
--- a/tools/perf/arch/arm/util/cs-etm.h
+++ b/tools/perf/arch/arm/util/cs-etm.h
@@ -10,6 +10,7 @@
 #include "../../util/evsel.h"
 
 struct auxtrace_record *cs_etm_record_init(int *err);
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term);
+int cs_etm_set_drv_config(struct perf_evsel *evsel,
+			  struct perf_evsel_config_term **err_term);
 
 #endif
diff --git a/tools/perf/util/drv_configs.c b/tools/perf/util/drv_configs.c
index eec754243f4d..f7c1bcf08549 100644
--- a/tools/perf/util/drv_configs.c
+++ b/tools/perf/util/drv_configs.c
@@ -25,7 +25,6 @@ perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
 {
 	bool found = false;
 	int err = 0;
-	struct perf_evsel_config_term *term;
 	struct perf_pmu *pmu = NULL;
 
 	while ((pmu = perf_pmu__scan(pmu)) != NULL)
@@ -34,29 +33,14 @@ perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
 			break;
 		}
 
-	list_for_each_entry(term, &evsel->config_terms, list) {
-		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
-			continue;
+	/*
+	 * No need to continue if we didn't get a match or if there is no
+	 * driver configuration function for this PMU.
+	 */
+	if (!found || !pmu->set_drv_config)
+		return err;
 
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
+	return pmu->set_drv_config(evsel, err_term);
 }
 
 int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 76fecec7b3f9..47f44394042b 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -29,7 +29,8 @@ struct perf_pmu {
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head list;    /* ELEM */
-	int (*set_drv_config)	(struct perf_evsel_config_term *term);
+	int (*set_drv_config)	(struct perf_evsel *evsel,
+				 struct perf_evsel_config_term **err_term);
 };
 
 struct perf_pmu_info {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
