Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27D2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:16:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A106620821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RxEkskty";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGd1q2Zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A106620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=nU7FmuCWyHbC3pT4NiBeCHOOFfpAO/TndI26v7yKwfw=; b=RxE
	ksktyeJcO3uUPad2EXWIs/BdqLc9plFxl0T+WXAqfQuFbRkEbvVbwIJZ9vdNXTk7NolntN1ACTOUQ
	fSspYf7VF/eFXKFZk37fhFnSf9IPH3QkQiczywWU4yeetv544AOLHYJyB37ilrRxUO8+tu5r9bV0s
	3jGajNfhaHh4/OPfJoenTCUcD1LzU+FBok95r78s8g7AoXf4Uv1ec0gI5Om2GSJMRNtZiWuqlnRTh
	j15hrhIEz/qxH5f8jdrr0NMcD2Yz6J6fYp4Fe48IYd9qaojzG35gt+soVPWOHypyhbqtsk+9/XPpl
	zAkCapQAZtToXzsIPwAIS1A1m6+7VAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh3QE-0001Yx-UH; Wed, 09 Jan 2019 02:16:46 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh3QB-0001YU-LY
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 02:16:45 +0000
Received: by mail-wr1-x443.google.com with SMTP id c14so6123369wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 18:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=WP9AW2JaG2LYFg4TVAG2uP0iTiVnN9sSaijovwmMgCA=;
 b=FGd1q2ZpBbRxqQ0wO1/P0y/CbKZc1qTxCyQzI1rgw11OxyFC23dTX3tQPoHuj6i/zT
 MD91x6bIGAOBTTJELUhElWEj+e0Wuled9B/dXM8oKU9OSYOyHrW7dCg5GMVwHpyYe/NI
 3HfgtCKlViuEDhPp3SjgiVNidqanC/i2vb1wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WP9AW2JaG2LYFg4TVAG2uP0iTiVnN9sSaijovwmMgCA=;
 b=Gt5we1I5XsoZJOTk8DSVPElTquW2g523sxRNS4/a9dPUWtQ3T4xGWrpb1eJEn9Sw9o
 S2uwVbH4bAO/5x8AYJQU7iq2ahLCWwg2bVxqMEr5AqO4mJlbWr7SczAnTvaGfQRyunSL
 jWeoab9oSFLvud7YD0IvH0UoIqeuHxns3VZi4DUO+45vIS1vyQf5QplBm5ruIWvGIhxw
 +U1jZQzIf7npUCYsQsG9LSleO1GuBOgvsMxuxJA7rcHvVfmqIiF7gKxhyqTxf4EV4cG1
 uUfVsLKg2hRasDGWvGsjPGIk7NEN0yqKlPtSfX4bFc7VbeAhmw7W7WDeBywN+EANude/
 51nA==
X-Gm-Message-State: AJcUukfoizphBTekfF9tAI+YvH0xHPbFlGm9ewhaw3/rqnu0mUs7EuqA
 Mo0DjrNJZmEAInR9B/kYIidWrQ==
X-Google-Smtp-Source: ALg8bN5cGvuXep07gNEPr8i3CgOuh0Op0TtjqX2nym7Dvuk+QpqQNOQMhjTSn7vNj4ZGHHzIaGTibw==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr3184118wrv.121.1547000201816; 
 Tue, 08 Jan 2019 18:16:41 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:99e2:bc56:9ad9:69c5])
 by smtp.gmail.com with ESMTPSA id w18sm48118868wru.54.2019.01.08.18.16.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 08 Jan 2019 18:16:41 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 rjw@rjwysocki.net, ulf.hansson@linaro.org, tony@atomide.com
Subject: [PATCH] PM/runtime: Fix autosuspend_delay on 32bits arch
Date: Wed,  9 Jan 2019 03:16:28 +0100
Message-Id: <1547000188-2732-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_181643_714925_4AA5C0C9 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cast autosuspend_delay in u64 to make sure that the full computation of
expires will be done in u64, even on 32bits arch.
Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
is used when moving delay from msec to nsec

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7062469..44c5c76 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 
 	last_busy = READ_ONCE(dev->power.last_busy);
 
-	expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
+	expires = last_busy + (u64)(autosuspend_delay) * NSEC_PER_MSEC;
 	if (expires <= now)
 		expires = 0;	/* Already expired. */
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
