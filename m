Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03475C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57842083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p3TrV1AG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmZuOKV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57842083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HLFIYsbkIy6EJPBxV8bMe4ftMtVrhONykGIovj095EQ=; b=p3TrV1AG9K7OkqnAmrnHNoVMIc
	7QzLGb0DWJ7+B1z0gs66+f1Kd6QxlNuSYoYPGoWK1Nh8qv0vD74OIhQbcNJxX3bhOrTdYYl8tawxA
	vxaK/GF/W/M4k/XpR6w2lx8rzgi19m8rqfyPm0ZQRdsvK8ajLStHymUymautgBPlmjoWlzQmBXxQ3
	4scyhThv15D385jjOe0ZuZvKVC2SLKfztzRcrT+c5azUhdQC6XpkiCVLTQhzL/Sk5ZMwsjY/cTF0Y
	hvRNTGgkwCZduezLUXncXEP5/ROQ+CIDfSvqtCrM2RFSLl5nQsr/zKi7646N7u0eexq4poXqJT3Ru
	HGtE8DOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqh4W-0000Yx-Fi; Mon, 04 Feb 2019 16:26:12 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqh4K-0000My-6b
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:26:01 +0000
Received: by mail-wr1-x442.google.com with SMTP id s12so494922wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uh0mWn8UrzjjJpP8IvQQtBqJhS8PhQJ/5HnUmOlZIks=;
 b=gmZuOKV+QFRNuw7Xiq01qUxU2MZBcpwkazl6G5C+h5WY9pAGCiz91/y7DoyN/0jhFY
 DZ8i3Vafab444Z0m63eLyReMXiadyi2xz0C+aOngk/lRbyG81BWpa+kBRlKmiLkPSDct
 YfqFD1w+6asWT2k4jairtsCwvVi474zCNUtO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uh0mWn8UrzjjJpP8IvQQtBqJhS8PhQJ/5HnUmOlZIks=;
 b=U515ppHf5M+H88BXRezSb/Oj0j92vDk9rfQn0BjEqCQYSWSC+cRjL3yGOTMVIRZDIo
 tQZNm03W0+hLbXwEuWMdkEAK7eiFSLdG/LCFJs2OTI5jEDm975l+f+WnyL0Y1wfF5DrW
 wkxTBXep5XU19TCgx4ktfNRaX64Mb7s/dQ94YufXeb1KfYmngAbiiSGgVVLQHoeQl9Jh
 wneWunPSEIqIjVY85dY6ub8jEyxojWejhcCRex4m86pT6N7CDJL0CUC3nXZ2+537gcv9
 75hVOVBqmo6QB6IjFDqP5vXVbR7wWv5h/D1nFwMZTZhUT+TQbHHasuk/9n28O0nvoCx6
 Vy9g==
X-Gm-Message-State: AHQUAualDJCkYGuN1QsqxXi7mrmjgx2FfnnaR6tmqFPL67kb/+AKZgTT
 6tWL8Q27XYmdU+G2oBe3YRAzWw==
X-Google-Smtp-Source: AHgI3IbIksHA+DShAzSt1p3DgS3JyqNTcMkRaDm5sNHqKr9m4slS51ApzahFGlivX+nk/RtPLDUzrg==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr148455wrw.310.1549297558732; 
 Mon, 04 Feb 2019 08:25:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70b6:b9c6:89e2:36a])
 by smtp.gmail.com with ESMTPSA id a4sm1251992wrt.37.2019.02.04.08.25.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 04 Feb 2019 08:25:57 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 ulf.hansson@linaro.org, biju.das@bp.renesas.com
Subject: [PATCH 1/2] PM-runtime: move runtime accounting on
 ktime_get_mono_fast_ns()
Date: Mon,  4 Feb 2019 17:25:52 +0100
Message-Id: <1549297553-17647-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_082600_236772_4DD0F786 
X-CRM114-Status: GOOD (  14.04  )
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

Similarly to what happened whith autosuspend, a deadlock has been raised
with runtime accounting in the sequence:

change_clocksource
    ...
    write_seqcount_begin
    ...
    timekeeping_update
        ...
        sh_cmt_clocksource_enable
            ...
            rpm_resume
                update_pm_runtime_accounting
                    ktime_get
                        do
                            read_seqcount_begin
                        while read_seqcount_retry
    ....
    write_seqcount_end

Move runtime accounting on ktime_get_mono_fast_ns()
With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
monotonic across an update of timekeeping and as a result time can goes
backward. Add a test to skip accounting for such situation which should
stay exceptional.

Fixes: a08c2a5a3194 ("PM-runtime: Replace jiffies-based accounting with ktime-based accounting")
Reported-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 1caa394..50740da 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,13 +66,22 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = ktime_get_mono_fast_ns();
+	u64 last = dev->power.accounting_timestamp;
 	u64 delta;
 
-	delta = now - dev->power.accounting_timestamp;
-
 	dev->power.accounting_timestamp = now;
 
+	/*
+	 * Because ktime_get_mono_fast_ns() is not monotonic during
+	 * timekeeping update, we must ensure that now is after the last saved
+	 * timesptamp
+	 */
+	if (now < last)
+		return;
+
+	delta = now - last;
+
 	if (dev->power.disable_depth > 0)
 		return;
 
@@ -1312,7 +1321,7 @@ void pm_runtime_enable(struct device *dev)
 
 		/* About to enable runtime pm, set accounting_timestamp to now */
 		if (!dev->power.disable_depth)
-			dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
+			dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
 	} else {
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
 	}
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
