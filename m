Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A727C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DDB21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SAMlVPRM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBLJFBXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DDB21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MyRnSHBOhiYZmgNwl04sCYwXwcL7Ir4yxHDwhqjp+8U=; b=SAMlVPRMD6mVzMun8Oeog2bRZb
	iguFD6HNUyCkN8fim1S4PLCe1qFgVo1ePVr17+AmdJ4NpbbiQlK11Om7aELmJR9ag7EZRKhz/zhSt
	FJ9QBxwUe9Da50U2WY8TfDxtpq80HdcmUIaVGlpsJFYtWoRL1gE/XyGHw43Zq1uHHmXjFa4/Ow31M
	LQfiZWnwTjHDF7zIzT/jHwbP4UYq0MwEBO6GoBj2SyhdrPzaiK5nK02D8o/zWZN6Qe7nZ4vtaI7MD
	woX8AyTcoCtk7POuvOhNe/UDjrpN/4DgyPA9ZuHM/xOiSUjQEYJmErMw/gsZaUQCd5ome7Lc0FCVE
	DsVWcM0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZMvd-0000vk-Q4; Tue, 18 Dec 2018 21:29:25 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZMva-0000ht-BC
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 21:29:23 +0000
Received: by mail-wm1-x344.google.com with SMTP id n190so4107712wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 13:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ilQ0qqZNQydQTJlGafIg3unftBFJ87HWUKycWJC64gY=;
 b=kBLJFBXyQU5bWk4V+BjSeU8IefqrlHUiDLqB9fl8eOgGnEahZO7lxt36z444jjE4Rm
 Yh7VLWa+yv4HGZJrd5tZsGRnmin7hTkLNwis8Ru+amXwF3f7MSaNg0B1EKd+QsuHB2sx
 FkbYZ1eyhGEwb7tyezhHvDRZUwH6tKm3A2/Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ilQ0qqZNQydQTJlGafIg3unftBFJ87HWUKycWJC64gY=;
 b=EJdVEVnlNvZAtJ2myDeshoP5aT8/Dhq4dFgjw+M0dIEHtsuJk7OxEodYzB/drOOe8J
 QaUg2jiff11QK+RsDI4+6usZrS9JbL6kJmevf09dQx6n0M1UXVxrFYeUNO8FQiUQXqvu
 KV4AvVQm3vngKFBxFixYo+Lpmi/nnrs0W6N58v05O5TSL3gZf0LaJEtgBUj/5CNdM2K7
 iST0VlNObsBDt7MrsplzdNasYzvZZ48w4SsGAkwU30g82EDFrNcm3sSjnTr2eusKW54F
 qq5vQpBMlVjxPfa5Y19dG0VGNAkqSeQY9LLI/dOwOT9Iai4tFa/2ukLJlCCM5bWjqsv8
 5wsg==
X-Gm-Message-State: AA+aEWb18wgjUASggZLkUbWRtOSeUTCHSmkbb+I8y7PWpkVqr+r3kyNm
 zbhFbvomab85lKmHDnkDsvqj5g==
X-Google-Smtp-Source: AFSGD/WNmmVnTdmTIv0ywBPCnkhuJv7po4peI6vkBXGMUaUCxURw95jcE2ojoY769Gavaj9AYcrz1w==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr4525681wma.91.1545168550254;
 Tue, 18 Dec 2018 13:29:10 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
 by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 13:29:09 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 01/25] clocksource/drivers/timer-vt8500: Remove duplicate
 function name
Date: Tue, 18 Dec 2018 22:28:19 +0100
Message-Id: <20181218212844.30445-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_132922_451517_1A5BD3A9 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: Tony Prisk <linux@prisktech.co.nz>, linux-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>,
 "moderated list:ARM/VT8500 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Dan Carpenter <dan.carpenter@oracle.com>

We print the function name twice in a row in the error message so I've
removed one.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vt8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-vt8500.c b/drivers/clocksource/timer-vt8500.c
index e0f7489cfc8e..c3aff1a8f7d5 100644
--- a/drivers/clocksource/timer-vt8500.c
+++ b/drivers/clocksource/timer-vt8500.c
@@ -145,7 +145,7 @@ static int __init vt8500_timer_init(struct device_node *np)
 
 	ret = clocksource_register_hz(&clocksource, VT8500_TIMER_HZ);
 	if (ret) {
-		pr_err("%s: vt8500_timer_init: clocksource_register failed for %s\n",
+		pr_err("%s: clocksource_register failed for %s\n",
 		       __func__, clocksource.name);
 		return ret;
 	}
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
