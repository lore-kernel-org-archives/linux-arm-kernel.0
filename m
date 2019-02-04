Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A918C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF612083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ljU77Gi2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVSLiJos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF612083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=seeTPMeHCDhguSgH+2KfD5fcACp77+WxVsXXNQZNpIE=; b=ljU77Gi2VfpvIJhWSsZPJXQUlD
	WzvXb35t0c0+iDYJo1EKy+WQqRBFWMs6km3ljDkzjx07gVkZWLrd/fjjaM55YwqBX5HPPLOkm4AwL
	FfiMAg7o06GdbIC+7Xt9GUDeoczblIlytqrAc5gXSpkCcyFVOO5qRvk8RLC0ytQ0jBtFxTXcq+f9l
	4PIAMdkMCrL9ibMEU1f1m91cS6cmWev4/AU03lrnBjfSCPBSKeVdDHMvethX3NS2ZBLhEuWWPdi1G
	2l/OnyF5stnPwLbKMm6dkKxHTA6F1tzXxLGWO4RaDeDXhWvNKA0Oq2dCE1au++h2zWYFaQHjbsJ9J
	lzB2vvog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqh4k-0000qC-Uw; Mon, 04 Feb 2019 16:26:26 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqh4L-0000NM-P5
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:26:05 +0000
Received: by mail-wm1-x344.google.com with SMTP id f188so520162wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 08:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9lKepzvlFqSdyTmpHqFOS3txG3e1Qlnve7EeoiMfLO0=;
 b=aVSLiJosF7nsn2YlMbkWjfe/sQt+HQvDzUEKw4RhgQWgOVm70k9HPSiS5kbBVP/nE1
 uxICapIcLqWzWM7keOzeU4tTM3C0LF+hWtIqKxl8GXPDB84dVtX59Ewhs+KjNoSXstgm
 a7axZ2Vk2Aky3bhhwgyM5lpXXxhrlCVDzQPX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9lKepzvlFqSdyTmpHqFOS3txG3e1Qlnve7EeoiMfLO0=;
 b=Xy30z5kqGLIQhIWPsIostegbKlR1soxcjBgJfi27d0FzGafyyPB2kAMg5tFKfU2Cm1
 GFEYYiSV4zTZ4pnypioqk43kF/Gnje5U2BcaOIxrHRDlDf186gtvmvYa+irdKyvp3nL9
 wbv1zo/N7RDYeYizv0qtNdVHcy5xw+pA6aP9aWqHBuwzTj3Wd09e9qMtuLJFVxQzxAL4
 dA3PGPzwIjEdZfzwmBXHEyYSk7Y5ex08Fwg7mU2FhBFzcs2CK3rZSDUzU8YnVvsY7f0F
 w5tSChHkgqrHsw3NpiPrAxEqw1ckG/xQPt5wCVksC2RQFoIzIa6ItwjS0tWBAdP3ccZZ
 GEhg==
X-Gm-Message-State: AHQUAuZrb7/BYF/FtKt8TlMfg5LBNvtSCZhcadYY+QgKURCqqu+EU9m8
 SiNbFX8CM2crRTJLLhV2SUmYzg==
X-Google-Smtp-Source: AHgI3IZ7M0ze84wTX8DLxUv882QQUfhGHmbTLyFg1PCjFq7A45aNiEqTtsmhl2YBtsRd3HsDJdr2vw==
X-Received: by 2002:a1c:b456:: with SMTP id d83mr127459wmf.115.1549297559980; 
 Mon, 04 Feb 2019 08:25:59 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70b6:b9c6:89e2:36a])
 by smtp.gmail.com with ESMTPSA id a4sm1251992wrt.37.2019.02.04.08.25.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 04 Feb 2019 08:25:59 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 ulf.hansson@linaro.org, biju.das@bp.renesas.com
Subject: [PATCH 2/2] PM-runtime: update time accounting only when enabled
Date: Mon,  4 Feb 2019 17:25:53 +0100
Message-Id: <1549297553-17647-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_082602_123827_2E241630 
X-CRM114-Status: GOOD (  14.78  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, geert@linux-m68k.org,
 thara.gopinath@linaro.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Update accounting_timestamp field only when PM runtime is enable
and don't forget to account the last state before disabling it.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 50740da..ed62cca 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,11 +66,14 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	u64 now = ktime_get_mono_fast_ns();
-	u64 last = dev->power.accounting_timestamp;
-	u64 delta;
+	u64 now, last, delta;
 
-	dev->power.accounting_timestamp = now;
+	if (dev->power.disable_depth > 0)
+		return;
+
+	last = dev->power.accounting_timestamp;
+
+	dev->power.accounting_timestamp = now = ktime_get_mono_fast_ns();
 
 	/*
 	 * Because ktime_get_mono_fast_ns() is not monotonic during
@@ -82,9 +85,6 @@ void update_pm_runtime_accounting(struct device *dev)
 
 	delta = now - last;
 
-	if (dev->power.disable_depth > 0)
-		return;
-
 	if (dev->power.runtime_status == RPM_SUSPENDED)
 		dev->power.suspended_time += delta;
 	else
@@ -1298,6 +1298,9 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
 		pm_runtime_put_noidle(dev);
 	}
 
+	/* Update time accounting before disabling pm runtime */
+	update_pm_runtime_accounting(dev);
+
 	if (!dev->power.disable_depth++)
 		__pm_runtime_barrier(dev);
 
@@ -1521,7 +1524,6 @@ void pm_runtime_init(struct device *dev)
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
-	dev->power.accounting_timestamp = 0;
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
