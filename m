Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68830C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CA220661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B0fhB1ux";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mn8OH9P9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CA220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2FEl+9RgBO8vHHGy2kQolpI2ELbyZfsk6VY/qnQIDjE=; b=B0fhB1uxRMs/YRiMebRC7OVcYb
	F0Xg62QnIMXyQ+5vVcU+74jUyRMYuAc6zIHfevhHaW7RJy15cT3R/lMunP2fEOUK710HyXqYHbnLW
	4zxEYJ1TT4DBJIcQFLuEEj1ylK4+zvTrFFtjA4YGz7ZDlg4q66M1DqNw2M7oePMoOc3Zq5HZ2NSU2
	MtE0sm5D3lMUKOPy/BWkiOBEvaJnq+4VUKw4K49lbai8TnvDBdle3AssqLJl4xjAVJG7imWDckvG+
	iE+QBuBwQV1HU4Pa5Efna7ksPTnipZRCWW6V1jPIIc1rtYsqJgzP7+ZF6S/8jgHSZFHsLE7aIDSPN
	wxzAyydg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX35-0002KH-2M; Sat, 23 Feb 2019 13:08:59 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX2G-0001NS-EC
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 13:08:17 +0000
Received: by mail-wr1-x443.google.com with SMTP id d17so5163606wre.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 05:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X/dC9KlJ2HFYdYmnw3hP+wmPZpOjWjCgiVR8KWlL9Mw=;
 b=mn8OH9P9jFUIYYwT9kiZtDMLsfnnQog8op/FqCeDhCxl6cce6Vdd7Wdw0vWCXytVew
 hQeeJLFOnoeZCo8i2xzI+sz5g1qnpuMF+XI/9+zCUPrmBLZtbCwkPLkHSVUq8rFdeGIK
 cl3vcKrLW0+SABVcEQV2OQXJvISPjid22tkKM8zpoemfCNLcg3OUzjwvKgDH0SM+4yhh
 vmqo+WCEMY9XWvavr4uBlUrV86W0LyHBRRN2RRHpT0HrgyBnE9rRaPGbsF20BIf7e35z
 0EI9Cpc6sz27ZX98jLWYmEF2uFvI1l2JdY1ljjyAVPGKcU3BKI+PmuCmndRPYDbxn7Qm
 RYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=X/dC9KlJ2HFYdYmnw3hP+wmPZpOjWjCgiVR8KWlL9Mw=;
 b=NnfNUv6l+sAemM7s+trLBkhpmAbUXn4+gzXgS9oZhhAflJcZ5VnB5+JjHRTUujg8DJ
 WalMSbAcGrzNkZCzHN+tDmMJYeihFl5sxcvuMDFqm0oty8T8rksfGJYf8mAs4ZM05/nH
 gLE91XxCotgAbqsHdM1+tVCfrn619ugnw8975V8A1vfNiUvXjnVkzl+T14K1ObffeKcq
 yB6x3BP7o/k5BfOdimlgkbgvFaVffV8dLTyvPKoRT7Jx504ND3aTAp78jIq64LhyfZkt
 qjJSuPL8pO4mfV29smkhAbnkSo2IgTAgKJ5Nv450FrZ1bDAwU1//lEBzeg/04poy3V6Z
 0A0g==
X-Gm-Message-State: AHQUAuZR1n4nu4av0zRY8eVeO25Fyqhwm14sxVrjPnepVrs5hA8pEIJz
 If1man784DLjxLpZTjgg1gteFw==
X-Google-Smtp-Source: AHgI3IYrtIY9J9dmnkdasoQHFpCzIooEdynI8zgiDvf+ZmHsNPrBbuzx6F/oElnuqwV3ijzRVwBF5g==
X-Received: by 2002:adf:f845:: with SMTP id d5mr6886036wrq.113.1550927286421; 
 Sat, 23 Feb 2019 05:08:06 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
 by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 05:08:05 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 08/18] clocksource/drivers/exynos_mct: Remove dead code
Date: Sat, 23 Feb 2019 14:06:56 +0100
Message-Id: <20190223130707.16704-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_050808_840174_ADFBDA08 
X-CRM114-Status: GOOD (  13.18  )
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
Cc: "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Exynos Multi-Core Timer driver is used only on device-tree based
systems, so remove non-dt related code. In case of !CONFIG_OF
the code is anyway equal because of_irq_count() has a stub
returning 0. Device node pointer is always provided when driver
has been probed from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index d55c30f6981d..647ea9fc752f 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -508,13 +508,12 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	int err, cpu;
 	struct clk *mct_clk, *tick_clk;
 
-	tick_clk = np ? of_clk_get_by_name(np, "fin_pll") :
-				clk_get(NULL, "fin_pll");
+	tick_clk = of_clk_get_by_name(np, "fin_pll");
 	if (IS_ERR(tick_clk))
 		panic("%s: unable to determine tick clock rate\n", __func__);
 	clk_rate = clk_get_rate(tick_clk);
 
-	mct_clk = np ? of_clk_get_by_name(np, "mct") : clk_get(NULL, "mct");
+	mct_clk = of_clk_get_by_name(np, "mct");
 	if (IS_ERR(mct_clk))
 		panic("%s: unable to retrieve mct clock instance\n", __func__);
 	clk_prepare_enable(mct_clk);
@@ -582,11 +581,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	 * timer irqs are specified after the four global timer
 	 * irqs are specified.
 	 */
-#ifdef CONFIG_OF
 	nr_irqs = of_irq_count(np);
-#else
-	nr_irqs = 0;
-#endif
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
