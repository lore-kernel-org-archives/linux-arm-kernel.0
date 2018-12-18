Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF1CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFC321871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bMnnb7Lg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2atdPES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFC321871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yQWIHJ7lXUuxJxFn0EVoXFtmWHl4hm+PIerbOQIXWxM=; b=bMnnb7Lg8faCGrCZoyw4Fv6rEG
	8SOdS39Jqg41YxP/YQ41FSoKD2yhcW2EDS6KL50NIgj/eU95+4f0Q4HZvwLvdqeRrTu3UpCBd5Xbc
	VuL/FUO5LqynqXLa8mYuTgOYK/ERLCqRX6VFuNcdW+cL+7itXH3QW78JTYVtkqV1E9RmElbBuPpLq
	C4GzUEuHEERo5bXbcbtdcyjGPvSlzcS0gx1AOIPNILv8+XR8OuWlcz7w7l7Vp51o4uVmu/UUk5lf7
	QHqEykdUsDTCZV4Nik77jSasuTSzIZsGCdDTYGrVZ1UzsySVRwXJwNkV+Xj0cjU2WUeIPzKTmOtu9
	XwqlTMyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZMwN-0001vv-A6; Tue, 18 Dec 2018 21:30:11 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZMvb-0000jc-Rm
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 21:29:25 +0000
Received: by mail-wr1-x443.google.com with SMTP id t27so17416636wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 13:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Nqyu5M43GadzwCnPRoa+RxuMcREhWjlFWdJLqMc9jGQ=;
 b=j2atdPESHEFV/4g++6362Dn0lTQBNnxnzH4XmBQYNUrIb3mlUtWIFagD78R4S+HDSF
 LvkWqPFfyY4TNFGARRcyLqyLu4VHm09uBr9nQkBuef32lBBoIxl/D3vG5o+5pxKqYBjK
 Gv4gXvDQ7JBBdHUdPpE4uaB5t480jHwtYBrYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Nqyu5M43GadzwCnPRoa+RxuMcREhWjlFWdJLqMc9jGQ=;
 b=Gz/yiLxzSggDBJeukLMjb/WNh7iMsQ+LRhY8hw0VGy5D59/WXgT/X2swY2+1KclflZ
 MAFnXYbsicEGSUhNa5cCK9ciQbwA3peGoc7mqNcbTA9b9x1HCTsc7Ia9K+srzYtLT4dr
 2uuSDGsoeEDTn9N4Wqb2b9GZ5pqPMZsw4vBi5lOYOphindAZKIYmqXCfr/15hXAjwOgO
 IB4OYUcKspcU523KeyHhIB6mb6yy935xANeCIyDJFqG00f7clDlzxUyeJSGmd+nbisHu
 QRcTR99fY9TMSEyr+qjUTORch0opr0O7dlY5vy4rz44Ov0z9d1muoG9jK4CEAofnBFdi
 Cxjw==
X-Gm-Message-State: AA+aEWYqDzkBcLrR1mGPmcnLAUclcNwsmsAJNtfG1NYNaAswc29iM8Zs
 1vUnMZmZBcBPz4ZCuPwtZxWO9w==
X-Google-Smtp-Source: AFSGD/VTVpQlyDRypEE6IoC93q1oS0YV1w7aA+Dh85DQG1DNOzHkImV8DeoZAfxaewWylI2zHkEyog==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr15315181wrn.157.1545168551762; 
 Tue, 18 Dec 2018 13:29:11 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
 by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 13:29:11 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 02/25] clocksource/drivers/dbx500: Demote dbx500 PRCMU
 clocksource
Date: Tue, 18 Dec 2018 22:28:20 +0100
Message-Id: <20181218212844.30445-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_132923_896529_FEA6BA7F 
X-CRM114-Status: GOOD (  14.26  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 "moderated list:ARM/NOMADIK/U300/Ux500 ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>, Baolin Wang <baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Demote the DBx500 PRCMU clocksource to quality 100 and
mark it as NONSTOP so it will still be used for
timekeeping across suspend/resume.

The Nomadik MTU timer which has higher precision will
be used when the system is up and running, thanks to
the recent changes properly utilizing the suspend
clocksources.

This was discussed back in 2011 when the driver was
written, but the infrastructure was not available
upstream to use this timer properly. Now the
infrastructure is there, so let's finalize the work.

Cc: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/clksrc-dbx500-prcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index c1b96dc5f444..4054539fe066 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -46,10 +46,10 @@ static u64 notrace clksrc_dbx500_prcmu_read(struct clocksource *cs)
 
 static struct clocksource clocksource_dbx500_prcmu = {
 	.name		= "dbx500-prcmu-timer",
-	.rating		= 300,
+	.rating		= 100,
 	.read		= clksrc_dbx500_prcmu_read,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
