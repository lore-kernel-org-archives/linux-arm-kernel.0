Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F70C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:41:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83E12082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kzOmhBMq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMxLwRDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83E12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SagwJtZptFBvxOTnYg/66DT6OvRkls/RuX3dxhAJYEk=; b=kzOmhBMqx0om3d4rayFMP3zMF3
	VYnhudxBGH4Wfmo29JtHjkSQcMSfQdP4G7jyaGJEKF12DwrKfrNRH6F6oY9biI7mXJ0FguiSGin+f
	Lfyiv5LrfRLdhSvVde60yDwjEI4/GafMJwlKXq1ihhaTz9F4fn18dzgBCzmV6gdZopHqY3kdfcPgQ
	pSTWd3zapm1P5KAy7hSzFwnb5dh8wgnOg5P/FIfTMaGRI9xV8IjMsOzyJ2AysY6+hGqvpBRr1WvhW
	aZ8Gn1TJL5ZQBFN8B7SOwVliChUyMFGsbbhfRARTDVZHJLzVcmoVYDKG/DxDsIU5HPsVUStIqMEtG
	ynRqfZtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcfo-0008Go-BD; Tue, 11 Dec 2018 07:41:44 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcf0-0007MT-3g
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:40:58 +0000
Received: by mail-wr1-x442.google.com with SMTP id q18so12955115wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 23:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7KsG51IyxvMCicfAhv+X1OucWXiA4qhwMKrH6icak5k=;
 b=iMxLwRDg3PQZUIpt3OlWqvTuEZfmbgtvhqfN8lG6OI91R7LsqBjlMjaOJlM99vkOZx
 3exwV5HwXGH2rCT3nY9ZsH+wCRn4rwnfqZyO6w/n+FaUClJIikrQeQuipGq3cyDaJY4m
 PXc3GJxPvBDLcnD7eqIUO5uVdK3nwjoj2lRxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7KsG51IyxvMCicfAhv+X1OucWXiA4qhwMKrH6icak5k=;
 b=EJRCrymayFz0hyrjACcE4OtvrtZ5QEPcN/DmQxTMiWOi0swlh1fFiGGnXAbizrKUGR
 Uj/S8e+OcnhuejrVfg9hu+N9MJdkhWnNI/6yxdi1RFPkBwrBgLtiDs0Xpfx5By551RLE
 Hs0S3Q/UirZEDIql5ANh24l+WB3K6OqXmVYT6eLMYp/dyAfAsvqbedZ5VGt0RryJtHaA
 ggC6eaiDoRTshM19uNFMZcInMf3+8Sxb0yqksb/56hkdrAI7nCwKUaURRXx0Nm6cwHK+
 5ekAwzpZXO2IXBWjjF/xMg0CgUfATzQIZqQDFsIbagYbWQhHxmVzAywd/8yA3ff6Talq
 75cw==
X-Gm-Message-State: AA+aEWbmIoCDli6TR4BLTcSXuar7F/fF0FxL9lgomsDU5jM6WcDC2kOj
 zOIjQP9eBw69Nn6HAUQL43YRAw==
X-Google-Smtp-Source: AFSGD/XfIo07y8495X6aVdm9zWCklhb9vK6Qn3VdBHA45vVAikhvz/10EWh+h8hx4/BgaYk8tEpT2g==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr11886334wru.33.1544514042362; 
 Mon, 10 Dec 2018 23:40:42 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 23:40:41 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v3 4/8] perf cs-etm: Refactor enumeration cs_etm_sample_type
Date: Tue, 11 Dec 2018 15:38:24 +0800
Message-Id: <1544513908-16805-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_234054_663651_823A439F 
X-CRM114-Status: GOOD (  13.40  )
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
Cc: Robert Walker <robert.walker@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The values in enumeration cs_etm_sample_type are defined with setting
bit N for each packet type, this is not suggested in the usual case.

This patch refactor cs_etm_sample_type by converting from bit shifting
values to continuous numbers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index b295dd2..3819a04 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -23,9 +23,9 @@ struct cs_etm_buffer {
 };
 
 enum cs_etm_sample_type {
-	CS_ETM_EMPTY = 0,
-	CS_ETM_RANGE = 1 << 0,
-	CS_ETM_TRACE_ON = 1 << 1,
+	CS_ETM_EMPTY,
+	CS_ETM_RANGE,
+	CS_ETM_TRACE_ON,
 };
 
 enum cs_etm_isa {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
