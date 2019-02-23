Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C545CC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986BA20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NeQXUQge";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FweXRpwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986BA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=a3FPg5xaqTK7YvFjwSQ5zsXkYuFCCIc9QjldoGZLM0I=; b=NeQXUQgeMRY7DIkv4y56ZmLlFB
	Ci00mwIg6IXkXqIVItk5mBuRX5h4EEWGh5x11KqZEso2cX9vweTJbUPyLbOtjfaxizOB9eej8GbXQ
	zQ4fibYcHnzyI8pRvLLhcEoJxwNnNN64kru2td6HRad/XBJi61kv0e7v0mHM6jCxXG6fZvjXzoGq6
	rd7jfWOWpTcT3rRsS7LOTz8Ias/GHKdFYjtPWkqx2Fz+y9l7FTh968TLw5kgsZ7VD//XC1niaaroK
	P72+ar8qUJg/yTOIb61voi8WXac3nTN42aacV1Cq560kCcj5QcX+ADay+58u7aeNwHRd5Fa0EKdu3
	s9UiCn9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX2B-0001Hf-2Z; Sat, 23 Feb 2019 13:08:03 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX23-0001G2-Pq
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 13:08:00 +0000
Received: by mail-wm1-x342.google.com with SMTP id q187so4261814wme.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 05:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AKSyCQMNYBv5nWh/KBmSW8hTM6N2dO+8FV84ST3V3Mk=;
 b=FweXRpwO5ayiperaVHweKq29vXe1C65x4VoJdxMjwwWtiWIxgUPzCZSzW/8DqrMai2
 hSqP3E3K3ifNxd/Gge8QibnK+XGe5pOOfv6rSIwfhdIzMgxiKHeXGHgBQZD67QYnbf3T
 5AyEFpWFeSFb9IroZT//XYiQONOYhenc402TUug3Kwux0CPMkKHM7Ok/1DudjXLDOMoB
 JJGa2pFrr/icqFrcL/atpIBLOKxtWwg2LpQrIS5j9KWr+r2vmmO9iXOd2KbvoV3YbDsm
 ieFGVDuJm5mkrKNy57dTXf2e/gdauqaWwYdmLPBjZWjspQo9InxfgMSmMlisfgfN+EFX
 FesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AKSyCQMNYBv5nWh/KBmSW8hTM6N2dO+8FV84ST3V3Mk=;
 b=p7vaknMd7EBTr7b5HfKDmmLa58dGQSvPH9Q9UQ3g6VRz0rUZeCOvehdMPL0in3alpR
 St8qPGWLSs9zTsyPQKBeevnj0qSBWPbITaq3Tl8SileycKgIZcISuNZQCLhudIZqHZwM
 B6K73vPeadZWTzxRxLoalrH7RImIuiYF+N4g7MWC1hG8Hq35yDvzvJaEMp/X2Ci2nzIJ
 sEwpmewBQ96Dg6K8p6uhYg0wqBkmRwleXVP3m3G2R+PMh5eEJ4AyWb+czWIQJBtS2aaM
 llenpiCwOVAoCrWkpimx+Sj1GmjpTURN2TjyKHPzvdpaFKlTv/5k1p1Cy2r1vyOcsZ9J
 HRxg==
X-Gm-Message-State: AHQUAuYOgxrgbf3mG8CyVbSGzoZDFY7tuBuQEDEWeZEmZPUtJQ9IKktd
 659XvFv0fWKn0tZ1JF5ABLS2Rw==
X-Google-Smtp-Source: AHgI3IY+jcPSsKN69Gcm2EYvn3Rne57hr42so/SgmhoskLAweyRxnWBIC0/vmLnIlDCyk9AEoD6CaQ==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr5548250wmd.103.1550927273393; 
 Sat, 23 Feb 2019 05:07:53 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
 by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.07.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 05:07:52 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 01/18] clocksource/drivers/sun5i: Fail gracefully when clock
 rate is unavailable
Date: Sat, 23 Feb 2019 14:06:49 +0100
Message-Id: <20190223130707.16704-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_050759_484827_AA00C858 
X-CRM114-Status: GOOD (  14.74  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>

If the clock tree is not fully populated when the timer-sun5i init code
is called, attempts to get the clock rate for the timer would fail and
return 0.

Make the init code for both clock events and clocksource check the
returned clock rate and fail gracefully if the result is 0, instead of
causing a divide by 0 exception later on.

Fixes: 4a59058f0b09 ("clocksource/drivers/sun5i: Refactor the current code")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun5i.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 3b56ea3f52af..552c5254390c 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -202,6 +202,11 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 	}
 
 	rate = clk_get_rate(clk);
+	if (!rate) {
+		pr_err("Couldn't get parent clock rate\n");
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
 
 	cs->timer.base = base;
 	cs->timer.clk = clk;
@@ -275,6 +280,11 @@ static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem
 	}
 
 	rate = clk_get_rate(clk);
+	if (!rate) {
+		pr_err("Couldn't get parent clock rate\n");
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
 
 	ce->timer.base = base;
 	ce->timer.ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
