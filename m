Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2BDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B336D2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gzo8hyFE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXuf8ZHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B336D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YM5IWwXw1Bgez7VKhix8/H1yqXXy6vEbvSdOS2qkaKs=; b=gzo8hyFEn0Eli592E4l5HaRrY5
	Mr3YzUXgORa6MFwR3VhznWIrhcqwJ5nPenXv/SmF8uxuYZFlIj6HqKH3PzMhQ/Kmzl01caMs4OxFn
	9d6dgT1PDyYlcAUJmk1M0Z+6bym4JhA5JUv/i8blSd1Iwb92k5vvsDJq3+hBHW5E1eRT+buVdtrvQ
	fhi09Pi0TMrm0KLPh5TGXc902yiFmmUfvqmOR/ERX6+8vaYoTHlZVnM6F0X2dzYZyOBgqrCuJWd1l
	tbeJ8IuZzGhZOP2Vu7N6ivFP/pVAAmD3IwbgWleBBGSDi5PyCxyVFQnFlltW0q8qNLBfCCNXUv4gh
	1Qu8DVtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHTx-0007Wq-4Y; Tue, 04 Dec 2018 20:39:49 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHTS-0006xm-Ab
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:39:20 +0000
Received: by mail-pg1-x543.google.com with SMTP id 80so7898623pge.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 12:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=n6NuaXTvDWIetVmFktrRRwuNkHydvvOOmRq+K+4VF1M=;
 b=WXuf8ZHgfXM8hFipNJqrnlBcTvAYQRbWJD2GjJ5MIM7fMqDI0QYHkKoH+/DcNC709E
 vhp/zGQPEQ3P1t9f/7s1dShvlZRqVS3pjoRceA3RG1w3NzympRlAmlFXd9MNmOnvnWwY
 yIAPJVMeSwKwxkv+GxVs22kvCaTfnuZ4kGtZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=n6NuaXTvDWIetVmFktrRRwuNkHydvvOOmRq+K+4VF1M=;
 b=M6HQBnzZxPpYr/QHSNvJ/MeLD9Ko9uKP2aKoL8ikkkB0Hosf2FIloKja3pRTJlFna5
 EDheRpCy8D+9SQKR0FkgDbmDSISe8ycDj4Uv1cSv1QEd6xad/nGpT6D0crj8p4ZeewoO
 A8wBXm3cM1FcYOO2o0/rieWXwy4jIoqNSS/4m9W2MQfF1U81lNRS/OSJymIkWKRj4kpn
 Fq830XdssNbUlxIB050nUklLD6lPDl6xS4vqUeKRW54Aw8pDN2hHWlucRkvHLuNV7saU
 5MaYXOz1uI4wOedEhtYDe5r2w4746SlA+e9d2pSsYvFVeZ3e4TWZJev9TKPMM68gG9/t
 /Nug==
X-Gm-Message-State: AA+aEWbM5P9li9RnDlS/mZcWJ9eukFWVhM2XB3A6IIpBLifrgvX7hUq+
 0bwyP+XqD/R5gVQxJBcXj3sZdg==
X-Google-Smtp-Source: AFSGD/XFPys51mL/FCvJyVYk1cmoDEkNiPZ+EhuGcwY1q70CTrvY3tjbExa/gGEjq32eV0QqEcdtog==
X-Received: by 2002:a62:8949:: with SMTP id v70mr20951469pfd.85.1543955947701; 
 Tue, 04 Dec 2018 12:39:07 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id r76sm29783274pfb.69.2018.12.04.12.39.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 04 Dec 2018 12:39:07 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Subject: [PATCH RESEND 1/3] perf tools: Add configuration for ETMv3 trace
 protocol
Date: Tue,  4 Dec 2018 13:39:02 -0700
Message-Id: <1543955944-10042-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543955944-10042-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543955944-10042-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_123918_361217_4D215DB4 
X-CRM114-Status: GOOD (  15.41  )
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
Cc: peterz@infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
 mingo@redhat.com, namhyung@kernel.org, jolsa@redhat.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch deals with the proper initialisation of configuration parameters
for the ETMv3 trace protocol in order to properly handle packets generated
by tracers following this specification.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  8 ++++
 tools/perf/util/cs-etm.c                        | 54 ++++++++++++++++++-------
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 612b5755f742..c0c67c919093 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -43,6 +43,13 @@ struct cs_etm_queue;
 typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u64,
 				  size_t, u8 *);
 
+struct cs_etmv3_trace_params {
+	u32 reg_ctrl;
+	u32 reg_trc_id;
+	u32 reg_ccer;
+	u32 reg_idr;
+};
+
 struct cs_etmv4_trace_params {
 	u32 reg_idr0;
 	u32 reg_idr1;
@@ -55,6 +62,7 @@ struct cs_etmv4_trace_params {
 struct cs_etm_trace_params {
 	int protocol;
 	union {
+		struct cs_etmv3_trace_params etmv3;
 		struct cs_etmv4_trace_params etmv4;
 	};
 };
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 73430b73570d..830e9136ad7c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -122,15 +122,28 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 	for (i = 0; i < etm->num_cpu; i++) {
-		t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-		t_params[i].etmv4.reg_idr0 = etm->metadata[i][CS_ETMV4_TRCIDR0];
-		t_params[i].etmv4.reg_idr1 = etm->metadata[i][CS_ETMV4_TRCIDR1];
-		t_params[i].etmv4.reg_idr2 = etm->metadata[i][CS_ETMV4_TRCIDR2];
-		t_params[i].etmv4.reg_idr8 = etm->metadata[i][CS_ETMV4_TRCIDR8];
-		t_params[i].etmv4.reg_configr =
+		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			t_params[i].etmv3.reg_ctrl =
+					etm->metadata[i][CS_ETM_ETMCR];
+			t_params[i].etmv3.reg_trc_id =
+					etm->metadata[i][CS_ETM_ETMTRACEIDR];
+		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
+						      __perf_cs_etmv4_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
+			t_params[i].etmv4.reg_idr0 =
+					etm->metadata[i][CS_ETMV4_TRCIDR0];
+			t_params[i].etmv4.reg_idr1 =
+					etm->metadata[i][CS_ETMV4_TRCIDR1];
+			t_params[i].etmv4.reg_idr2 =
+					etm->metadata[i][CS_ETMV4_TRCIDR2];
+			t_params[i].etmv4.reg_idr8 =
+					etm->metadata[i][CS_ETMV4_TRCIDR8];
+			t_params[i].etmv4.reg_configr =
 					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-		t_params[i].etmv4.reg_traceidr =
+			t_params[i].etmv4.reg_traceidr =
 					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
+		}
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
@@ -360,15 +373,28 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 		goto out_free;
 
 	for (i = 0; i < etm->num_cpu; i++) {
-		t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-		t_params[i].etmv4.reg_idr0 = etm->metadata[i][CS_ETMV4_TRCIDR0];
-		t_params[i].etmv4.reg_idr1 = etm->metadata[i][CS_ETMV4_TRCIDR1];
-		t_params[i].etmv4.reg_idr2 = etm->metadata[i][CS_ETMV4_TRCIDR2];
-		t_params[i].etmv4.reg_idr8 = etm->metadata[i][CS_ETMV4_TRCIDR8];
-		t_params[i].etmv4.reg_configr =
+		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			t_params[i].etmv3.reg_ctrl =
+					etm->metadata[i][CS_ETM_ETMCR];
+			t_params[i].etmv3.reg_trc_id =
+					etm->metadata[i][CS_ETM_ETMTRACEIDR];
+		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
+							__perf_cs_etmv4_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
+			t_params[i].etmv4.reg_idr0 =
+					etm->metadata[i][CS_ETMV4_TRCIDR0];
+			t_params[i].etmv4.reg_idr1 =
+					etm->metadata[i][CS_ETMV4_TRCIDR1];
+			t_params[i].etmv4.reg_idr2 =
+					etm->metadata[i][CS_ETMV4_TRCIDR2];
+			t_params[i].etmv4.reg_idr8 =
+					etm->metadata[i][CS_ETMV4_TRCIDR8];
+			t_params[i].etmv4.reg_configr =
 					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-		t_params[i].etmv4.reg_traceidr =
+			t_params[i].etmv4.reg_traceidr =
 					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
+		}
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
