Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25711C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92BC217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I9RurnEM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uKwTXy3G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w09Km95r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92BC217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BFYSgku/BJLuD5GTwW2zwEk8q4/wGXEhkd7/eGjW/Fs=; b=I9RurnEMP4fw+J
	2x5m8ivF2jMHjV3fMEWsx7ZC6OHYM2KOvVbEKJd6IoOS9lbsiVXvp2VOwA0n48N6+9kmrTVvFyyaO
	Cz9zcVfzHUF/hYl9ZnhXfw3Fbofiz6c4k1ctyo80QkhaluULtPFDom3pMWcl2l6B67phl7ZqMz3i5
	UMH3XgZGvUE5C7deX3q/ezq2/VeV/AWpr5g9XBPri5l2MXanRVnes3Ni5ACUFtXQiG+7O4C6W7JLo
	OTSkeDbS5KSV2jJ+kCfxpbUe+fXGXO04sJtdreXkZKc6XdkpiofeMt7WNsCvb1SRL6D5R30DSYPBV
	rM3JnyHMO73a9IuR0zQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybXX-0002WQ-6x; Tue, 26 Feb 2019 12:08:51 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybWP-0001aR-BU
 for linux-arm-kernel@bombadil.infradead.org; Tue, 26 Feb 2019 12:07:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CeUg0tzZvzF6i3vRIOyMy0PwSMiSVM4hJM4cSQ/yY34=; b=uKwTXy3G0QkDicse84dKMhfvys
 kJn2LGG/ndD2rMHJDMoxYGNFXlsVHfcbpC8yGc7ziLpFKpA+z4/VY16qzzOk6OlSv8WO+iu2TSvdQ
 ZWzD/o3I6IjQze3TX9PLftv2/UhmjifiMg2eGFggMQGF380MP+SRq/vHOd3nNq4oGzhBK8980BNlg
 2o4Lmr1edJsMLfT3maJP0Gc4QcCF8B6czIVsCBcyESRirFsYMII4XKFES4RWpe9lpCcFcsX5ipIFR
 s20a+OSPvlMNSVj7LWUQtggnarIaqgYW4r7dnHeXqQgiP4KL0uTfSubg6rxqeaajHH7RrdcRmLIkb
 Ud3GkxqQ==;
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybWL-0005Kv-P1
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:07:39 +0000
Received: by mail-wm1-x343.google.com with SMTP id q187so2140713wme.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CeUg0tzZvzF6i3vRIOyMy0PwSMiSVM4hJM4cSQ/yY34=;
 b=w09Km95rIIuBHcmQIqgGOzaNfxWLXY3eRUPutALA3ZtbMlEqSPL7bJxajrVqkBC+tr
 GwvB4vuFrJyL/thjd377MtomBwlI8HKEfr/8J/mQsx2ZQvqwcIkePtjGJCHb7HrJTGl0
 f8b9KLG5YnkznrNDXBB3hwE3MRw+xE6JeW2wPa3Qi2zZV6Ek4yV1z0trFOrTqyYkq/XR
 aqjJ5MxPDbkaSTExBatNjP/1m26Y23ZCPJPL1nbXL7qpQL/nBJwO2/ecYRjXljvd6PbX
 vihAm7dxf4zjaNKOlFbX1e18/hcSvD/UTo7fmrVA17PKAuh9f9N+a4+6bPRKUTIvhRvP
 b9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CeUg0tzZvzF6i3vRIOyMy0PwSMiSVM4hJM4cSQ/yY34=;
 b=WjRlpdqwmseX0kYPCv16MJ9bQon/RixIA6DbQ2WYwe9esIduV2LjCAYNX3t84YCTFz
 S2iEt0bRZ9WCQH0QgtAZPhfEUahb8yWuQq2Xw1Xcp+6qWaFZhsLwJWYtekjR9hwZB4Cy
 FIldJwlBsWjFElxUj32lFMdzxAbHBr4HoYkpNFgz/Wc3NoEdGadLP1n9Gm835g9pHT0m
 Hm0wK0gE+Gduesc9eg/DrvkyuUkHnwXIKMsljGRTN/TOY86CNUD1fwJMrrr5ZWkb5V9x
 /0Qo6cRQTHvLAYGcTRWuwbN3TO91K7zhTyJLWX6vpRriZ1VtxB+uC+2Tg4Gc39VpM2x1
 L8Aw==
X-Gm-Message-State: AHQUAuYXjclVkkovBnONfwnSQJoPRRFDpXJfr8WuEQrb0NP+mR98LdYF
 FOvY2yj7eQ/52Hn34nnmy0hEFA==
X-Google-Smtp-Source: AHgI3Ibnwo6rPlFREbjDwz0cEHeEKLi+LVTeWIhki2cnxRgP6ToMS3x5yVUXJ15aNN6g3VF1okK6Rw==
X-Received: by 2002:a1c:b783:: with SMTP id h125mr2315471wmf.119.1551182853533; 
 Tue, 26 Feb 2019 04:07:33 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 04:07:32 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 03/11] ARM: davinci: WARN_ON() if clk_get() fails
Date: Tue, 26 Feb 2019 13:06:25 +0100
Message-Id: <20190226120633.18200-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_070737_930683_8BAD6747 
X-CRM114-Status: GOOD (  13.74  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails. Apply this to all davinci platforms.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c  | 4 ++++
 arch/arm/mach-davinci/da850.c  | 4 ++++
 arch/arm/mach-davinci/dm355.c  | 4 ++++
 arch/arm/mach-davinci/dm365.c  | 4 ++++
 arch/arm/mach-davinci/dm644x.c | 4 ++++
 arch/arm/mach-davinci/dm646x.c | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 63511f638ce4..d242ce06f7e5 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -750,6 +750,10 @@ void __init da830_init_time(void)
 	da830_pll_init(NULL, pll, NULL);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 67ab71ba3ad3..72d64d39d42a 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -680,6 +680,10 @@ void __init da850_init_time(void)
 	da850_pll0_init(NULL, pll0, cfgchip);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 4a482445b9a2..57c5a660758e 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -742,6 +742,10 @@ void __init dm355_init_time(void)
 	dm355_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 8e0a77315add..1d82bb630d11 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -783,6 +783,10 @@ void __init dm365_init_time(void)
 	dm365_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index cecc7ceb8d34..2b0e921aa755 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -678,6 +678,10 @@ void __init dm644x_init_time(void)
 	dm644x_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index f33392f77a03..7e5af984ed9f 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -662,6 +662,10 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	dm646x_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
