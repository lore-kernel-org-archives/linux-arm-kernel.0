Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ABCC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:48:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECE0218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vv4Utd/6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="glf4ziPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECE0218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cU+03IVWGo9ZVWLv7xJ9fT/sCf5YThR3lPzNGBDJH+4=; b=Vv4Utd/6Pof6ctwLSMT6HcGlxd
	N2vgO85q4MHPf70fIoGX7f5ARNa/g7FjaZQGgJO0lJZ5/cveMuRLnpv8dTsq5dHmrIHwh6xidp3e5
	GApq3Z6IvEu8NHIus1N0XphkH2w3PQm085nJl/86eP5WSZ5jd0GbELtlVkeoqfo9/PnjkmMatJv8H
	2awF+d9PIa7ZGkbuZMFlCOR3Mdu95febHg0GC+UedO4zABpi9KpYMs8XJ+OduFe3fDcOmpgq64HTa
	C6KSm0tIs93sd4fdnlxQyPljRQ6FXQH2DOE4OL0ZMqYQiW7VXBgV0TvfPyoODp0Zsgt9t+hjc/xsE
	b89eGyyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpHOD-0003tY-9R; Thu, 31 Jan 2019 18:48:41 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpHMy-0002tX-BB
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 18:47:27 +0000
Received: by mail-pl1-x641.google.com with SMTP id 101so1873251pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 10:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7joT+FiIVI2um+Bj5G0r88fPyUv6XsFU9OyCfcSTWlE=;
 b=glf4ziPBQoTzLutgeF+Kepcv2UOvFNic2vzeLLP4nCNWMQCM3Rv0B0ZJe75bW3cncy
 +IhWEsfjSWk/9bisvLFqOIqzZPTjpQRv3nK1CktyUcZKc4wGG8r0BoZ9PtaFc04J0Lqo
 gIb04R7fqjNSJVnxqReFJF5V73z+BFLi0okJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7joT+FiIVI2um+Bj5G0r88fPyUv6XsFU9OyCfcSTWlE=;
 b=Ag6CfZG3NmXmOcyoLnQMl+Ok5c3HAceKol3EyhIOn0FkPKKTJprCXeRhZDfAC+Fmqd
 /hjaC+at4YzLa4uXOC3jzfXhnRM8dlIKon0SXZDbxPSVSQTTP/Zn9CaPpvPWWkujA+WX
 zfX4Z2whtz/dYC18UiJa81OHg/p9USdPygQ98Yrj3xa0iPfC9ajMEs2KlBC8AzaYl3xT
 zBTvt4GOacL1cHGFBfASQS0mdgDW4yDrVZfiD6/LyUgeDDrJ2+88jhPsDPmmTF55vGS0
 JNww6bRQSz3un1Nwiz2mGFPpfAe2Mgl5ldqbCYwk1ec/lwr2kC8zdRVDItmxkANnqrXn
 gn0Q==
X-Gm-Message-State: AJcUukeHBzI0Tfryzxw03HCjsNE/vx6sZ7+HiIt21PFY33n5B3Y/WUER
 pHGEaJIl5mJC9ZmPqzcDOzh8AA==
X-Google-Smtp-Source: ALg8bN6nLnb3VX5nWFOBEDhC2QRl2u6YbdJ3hyz4n1FuiGrrdmOerDQIXatwGc+oQ/suKXAX/pEziw==
X-Received: by 2002:a17:902:2b8a:: with SMTP id
 l10mr33947349plb.70.1548960443889; 
 Thu, 31 Jan 2019 10:47:23 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id o66sm6236234pgo.75.2019.01.31.10.47.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 10:47:23 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org
Subject: [PATCH v3 4/7] perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU
 header file
Date: Thu, 31 Jan 2019 11:47:11 -0700
Message-Id: <20190131184714.20388-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131184714.20388-1-mathieu.poirier@linaro.org>
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_104724_395621_11AB5EA0 
X-CRM114-Status: GOOD (  12.09  )
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

Moving definition of EVENT_SOURCE_DEVICE_PATH to pmu.h so that it can be
used by other files than pmu.c

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 tools/perf/util/pmu.c | 2 --
 tools/perf/util/pmu.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 11a234740632..51d437f55d18 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -29,8 +29,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
-
 int perf_pmu_parse(struct list_head *list, char *name);
 extern FILE *perf_pmu_in;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 76fecec7b3f9..350c54e0bd3d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -16,6 +16,7 @@ enum {
 };
 
 #define PERF_PMU_FORMAT_BITS 64
+#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
 
 struct perf_event_attr;
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
