Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6480AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:41:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1712146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IHocth+U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jD/4E8Dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1712146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ymtW5LiHNbOe1VhJwavfGtEImAMBsJpChSZsqkFGK/o=; b=IHocth+UE5FiFc
	ztTDjwi4jDMSZ0CLYVunsxUQ66YjfAJs2QwMoQLpevNi79Fv2KAFeYxQA1KE5h5t0Feh1y25Rf3JS
	FV3cQDaWziq81YETp74eU1DHMl/oDepSVCuvWqkEn9JsmP2hDExn0fgv8roktcyWJPstBFwE5Vb3B
	JADkg3NgGdohyUVDY98UDZkV3L7LcVD8AQhYgXLvDB4L6XNqzcflvWOXeqUuLEH0FF8HoAwQLV/NG
	dA+JqdH/0djllHnYG9KOhpKCMejqN58YFowym5iRt2AH1utDXEqftzQ4aw+0T4yh6vF7yWE0nLXfY
	FdIusRQ7Li++syLWpuOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA8z-0004xN-IH; Fri, 08 Feb 2019 17:40:53 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3f-0007Fm-Ee
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:45 +0000
Received: by mail-wm1-x342.google.com with SMTP id a62so4350395wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5xoYgZeFd4jbYH06UIuAag4pMtuSlF7B4aVziE0WwaQ=;
 b=jD/4E8DdS2MTQvD0NBcKMnWK2cKwqopPRaKfl+aaNLGRhW7PWtdF2k1Z1UQdWaBdcL
 yGPJIo0MXD4BFBKDGSaI7YmYrG9t1a/dVcf1C9Q72VmPAl2syn9C8sN8jJST6Ns5AVdz
 tbi/gIiyWgU73u2KVyf41OU+MPK459C0fyZFxQ2qXFKAcps0zFlpcbkWA8Pc2oD/HVsE
 qB8FFdyV31z4mOeZzkoFU932QrlCLJvhe3NsOx67jklQPzgzoucVGgEyoB5tV5K45+eB
 2Aqw86m91Fvn9Kz6CvR3YIjdddRFMbLdlQyTdEh4q/7wYjMm3qhU0T/vr881qdyXi5wN
 x40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5xoYgZeFd4jbYH06UIuAag4pMtuSlF7B4aVziE0WwaQ=;
 b=LQEzMP3k1z1YC1CVLWFMJ4v8Wongrtej2acIoLPgrs5wXxzZOk1kQwbvy1SPWW88br
 tl9bKBiLqWwMamHDcW3nEBOMg0pXSmH+4pm3+amJ49H9IVrVu7rvKBFfkx02cNC79N7+
 oej9L7IiTscZUnZzdy3fik4LzOWKyDDhloJIfGnxRnmYRT8y9uYOonaiZjR33kJC9pRk
 1p1LWf5E6WZOmjuGxfS6N24w6eENK42DOuGl211BhMW7nWZiWjRn0rV5A9imgYSwSdWs
 uND6IsQIQIIedK6zpyW496QUXgcZ7+zaJierVkeSy5YQAwYNnJZmHEkR7JxDsE+1CGby
 qQ6A==
X-Gm-Message-State: AHQUAuYnOu6V+mtlU4BxaV3krUugFTvvx6jC46nAFFoLlwV8rFomaVP9
 YLqzWI5J/+z9OTa2V16pAGWZgA==
X-Google-Smtp-Source: AHgI3Ib4uwqzIycD76Vwm/WlgnnMKFLp1gyu030lqPxI4JxPluFuqGuye8gSeDMn5wJkdBjI8YI8AQ==
X-Received: by 2002:a1c:5fd7:: with SMTP id
 t206mr13143576wmb.145.1549647321932; 
 Fri, 08 Feb 2019 09:35:21 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:21 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 13/33] ARM: davinci: aintc: use readl/writel_relaxed()
Date: Fri,  8 Feb 2019 18:34:38 +0100
Message-Id: <20190208173458.4801-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093524_244552_5351AF09 
X-CRM114-Status: GOOD (  12.68  )
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

Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()
and writel_relaxed() respectively. It's safe to do as there's no
endianness conversion being done in the code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 148c23728bdb..6a7205a844e1 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -36,12 +36,12 @@ static struct irq_domain *davinci_aintc_irq_domain;
 
 static inline void davinci_aintc_writel(unsigned long value, int offset)
 {
-	__raw_writel(value, davinci_aintc_base + offset);
+	writel_relaxed(value, davinci_aintc_base + offset);
 }
 
 static inline unsigned long davinci_aintc_readl(int offset)
 {
-	return __raw_readl(davinci_aintc_base + offset);
+	return readl_relaxed(davinci_aintc_base + offset);
 }
 
 static __init void
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
