Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA42C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:13:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00BA2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nIOo11d7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z60QHjIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00BA2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BqbNcYYrynGddWeQxQNMn8sPaBQ+1MTXHL6xQVF6228=; b=nIOo11d75aNNdqrI+4ehVlCKAM
	pYdHdS04oXI8jmS+/6xmauTnk1JciIi+mlOQOaFTMVu5edZoDxAuAclBTvhEFCeZCR8UGnXw1fniB
	WOa6oS6uLV5welgpUypOfiOjn58OrgD7AtFggugGkxvHS9mYkRz0C3V+QGAiJ38RcpBMHgwp7Chr8
	/e+20hMBO1gAVnrahYQhlbCzBFIpDAS11NZvBpC3WRIhXkkB58C+366IA64SVhSID+Z2uTMuIK38o
	dCGJZCJ5D2QGPfNAbBGNuQtWShIP/ohiRwv22Hd7iZ3bxEpK33eWEqJJTDzOH5zv4LjCUhT1Uh/Nn
	+FJOLKmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm0YF-0005x7-78; Tue, 22 Jan 2019 18:13:31 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm0Wg-0004Jk-Lz
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 18:12:04 +0000
Received: by mail-pl1-x643.google.com with SMTP id a14so11840196plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 10:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SuxrcXTgi5Kz7buMh5CGnWQq0L/rwu8Ex3hQZBJw2VY=;
 b=Z60QHjIenHT4OyqBsheQMaxF6RYqBiV7QP2VycQw72Lnz8H7lTUiNzU5XFIvjxZMOd
 R2bV27OuAJFwleSNM7Dop+yv5TW+2A9PK6f1u1wfz8Ud6uRN3Xd2seGCMo1x9AveRPOQ
 lZiMeIWyeAYYBpcSzW4mn9GspNtVMVJWn3qKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SuxrcXTgi5Kz7buMh5CGnWQq0L/rwu8Ex3hQZBJw2VY=;
 b=rqzkqP248LzezpTc7vfK9sh7JugUIBuIcL94wU2l3UIEq3j+/oZHGCeltW9kCyhPZy
 kKNUG/xnNmy/MJdW3AuajcUlMPk7Al9CxwMA56mNuz31/bPaz7mbbqMFyd4LJDcW5nJM
 vYN4arCeicPwbd+WZxbSId837gNYaQLnziGC8llI04hPrbKFU0QwKXwNtjfHIZXanOkf
 ED84PfXBb9UdSpH64yUnjP29y6BeQWC4UjGVwe9WbfTLTRLcioZOHdXegTtR084Cjh4/
 kDPMy4ekkbSeaqr7xPFB/AgXTExcwRmxYbaC2Jc6ocfzfYrXl7GM8Ny4Bsyx1udJyNop
 OveQ==
X-Gm-Message-State: AJcUukeUL+CM7BKulQ4KfB1HUkl+fUA03QQQKTka0GxodffVdDz7ZSMc
 i3rYtvCIN0pB2LDE9HbhPA+BKw==
X-Google-Smtp-Source: ALg8bN7w1+C3JWypkidqgF5L1s2LTAFioRI25vFKpCa3K33OcsF5051Z5O2eu90i7xRGJOr/hcWmyA==
X-Received: by 2002:a17:902:bf03:: with SMTP id
 bi3mr35275336plb.83.1548180714066; 
 Tue, 22 Jan 2019 10:11:54 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id a18sm23489919pgj.30.2019.01.22.10.11.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 10:11:53 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org
Subject: [PATCH v2 4/7] perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU
 header file
Date: Tue, 22 Jan 2019 11:11:41 -0700
Message-Id: <20190122181144.26645-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122181144.26645-1-mathieu.poirier@linaro.org>
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_101155_070227_C7BE8F28 
X-CRM114-Status: GOOD (  11.87  )
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
