Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9260DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:20:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658E72080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rNhzlFKS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SWdroQFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658E72080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=It1zDjnuJoAqEgaW1UGzNcgvQCQxSgKR5nAChDRfpcw=; b=rNhzlFKSbgfFoY
	oLtB+lvHsAoeoCZWj+wfF+AucErSs3sq/0qgn/Nr+LgrdJDAyjWilOgPi7hh16HnaASNuv07QRa+a
	3Ah9QauIsf6nh+sqG9NJ9B7rdw5dn2mEbKreOj2lsbGVo/N+TH5SPAzV1spgUojRi3wShyPjy6pOR
	70s9yikzAib3S9nTHgsSXCCy2lBqLcrC14EE+gZb17n45jHXYoytC7YajXjutUzxeEz2Rfzx/cxlV
	FrdmZsYfN/8Yt2HXGacHwH179oAQs5rSGU88sW71X1fkpiORFg4nUsOI0UHVf7re27WHtmk1C8qAT
	eajeFjvRVKTk/hQRvAyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhug-0001nk-9Y; Mon, 04 Feb 2019 17:20:06 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhss-0008U4-59
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:18:21 +0000
Received: by mail-wr1-x442.google.com with SMTP id p4so673151wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uiGnEol1xb8eg2WyQOwKJAR2Kls/0Ww5rrtoxvIkC3A=;
 b=SWdroQFzRrdFrWEhLuoSnZU37ILREFByTnNCmuTdI91viuSwP0ux0aMkZyVOgeDUFd
 JMlzkiZGfC9hDqjo5ase58BXG2GMhnKKvXuokBFG+ngtVxq6CMf/4W0Jfq3KMNN9ItIy
 5cRA1dyWrHZz6tLW9jMFHUJcdJhpqv8A28TPg3qSjWNfbTDq6almeq3PMoqr3GWiCn/9
 GJjE8elcAgUseOWa9Saw1k2ilqLj96CqwBcDJh28eh8EYbW079wmXTVq3d0vlZBWpKg5
 0o3AwPt+KyYCwQGn9glsDsQFDmdvYtd1j/MnusV+9o8uQCumgKM++yfCpxljYrw0m5DC
 YLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uiGnEol1xb8eg2WyQOwKJAR2Kls/0Ww5rrtoxvIkC3A=;
 b=ZeAEfk48kdwURH3Ka+rNz+O96kArEbxFjkxwAOmcX1nX1n78GJKYwmr2oONk5xEqQZ
 TPVohQRW7AITHPHgr06qYrUGDh7H3jHF9kF6cSyj21bE23mLZwAgcFaSHszMu4HvSGQA
 cCt8v05XNXlwSZdPQCaC4Rop0VIGPZb7Iof2LTp9QD59LXq7CkUbfir5iQFFzRa6f2Tk
 m1NzWnNsx8tY3S3/bpF2220wsOjdKpNVKp3lYeTlpYtzCMW1AT+UJnZW0rrhS9B+Y7Zh
 W2Erml/z6I6Q382GFYeHrF5LBg8q54eBPPojhJ4v20j1UhrlDneJ8iomJHWKZuxDseRW
 D76Q==
X-Gm-Message-State: AHQUAuZuo7YxcPq6np0e2q7/z1UWtWoRNLO3z3iKsskeXUf8U03/j0rr
 IT2qJz3gL4xcMNhHQawFj5PskQ==
X-Google-Smtp-Source: AHgI3IaxbiiCbJFakSEwrSn2g9Qq4eD8OgPeV53MZ3TiftCz12J1VpDKn3shDSrq9/tGU/uPJMUfDQ==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr332239wrg.230.1549300691717; 
 Mon, 04 Feb 2019 09:18:11 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
 by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 09:18:11 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 04/12] ARM: davinci: WARN_ON() if clk_get() fails
Date: Mon,  4 Feb 2019 18:17:49 +0100
Message-Id: <20190204171757.32073-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_091814_649684_53A26635 
X-CRM114-Status: GOOD (  13.46  )
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
index 2cc9fe4c3a91..9a4b749cbb6b 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -834,6 +834,10 @@ void __init da830_init_time(void)
 	da830_pll_init(NULL, pll, NULL);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e7b78df2bfef..beb34ee42e3a 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -774,6 +774,10 @@ void __init da850_init_time(void)
 	da850_pll0_init(NULL, pll0, cfgchip);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 4c6e0bef4509..2a523fa7c716 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -745,6 +745,10 @@ void __init dm355_init_time(void)
 	dm355_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 01fb2b0c82de..68bd78dac293 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -786,6 +786,10 @@ void __init dm365_init_time(void)
 	dm365_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 38f92b7d413e..070660cfd93a 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -681,6 +681,10 @@ void __init dm644x_init_time(void)
 	dm644x_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 7dc54b2a610f..73a0f0226017 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -665,6 +665,10 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
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
