Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF77EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EF720842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LQ1YMfGe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoJJZ7j9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EF720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZyFbSf0Rvdy7Uyl2gCIy3zhWvbmyqVdS7+GJ28GsfJ4=; b=LQ1YMfGeAdGKz3
	qLtZTLBbx90VgRmj45UAkrHQudHHqQ5QlgiQgMb5nrZhabC51JpLF+xjHv2oU8tjC1A+Bjy3ffyPe
	38EHmmYrVOCL2KGH3pKCHzpHg9Q9cK3a8tCTQk6bJ6qP3bdjodt/lmbwFdnpZbrZJPKEPdoVOhibc
	Y6YTLIOb2HFu25BWiUemgieWqkcfJQjW0xPmW6vF0t/M+OZ3JdK5eqAuso7v/8gqdq4Ts1uUOEvJ2
	Znc8CfO7DRZc5xKTN+nNH8XQWhOY7YmE4w1LJorNymfCbCfx2cgpo0p8bbGh7xezSn+WejO5BPRuO
	qXUhbf7ol/w7v3eCKD2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtcDn-0007Qk-32; Tue, 12 Feb 2019 17:51:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtcDA-0006qD-C5
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:51:16 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C6C0D20842;
 Tue, 12 Feb 2019 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549993871;
 bh=wdBGAn6LPu5DlmekMMQ2Nmm/ROb3O2h/2jhToyeSOKc=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=YoJJZ7j9E6vl6bXUz40FkjJ0rwcMHQGYrPIDLW/paTc4mzcTi7ru5RwQ2JW14en4h
 8d04k0q3ML+pWl7UQP5dJtR7DAdpbLe9MkOzjx93dZnU+/po8vjWP0QvJFRyF6YsxB
 oG34Ao2YPWCBKwJQjv5M2TjkzdN0xnch7I/scaPg=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 3/4] clk: samsung: exynos5410: Add gate clock for ADC
Date: Tue, 12 Feb 2019 18:50:51 +0100
Message-Id: <20190212175052.6310-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212175052.6310-1-krzk@kernel.org>
References: <20190212175052.6310-1-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_095113_190244_16D84C0E 
X-CRM114-Status: GOOD (  10.92  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the gate clock for ADC block on Exynos5410.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos5410.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index 0a0b09591e6f..b2da2c8fa0c7 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -209,6 +209,7 @@ static const struct samsung_gate_clock exynos5410_gate_clks[] __initconst = {
 	GATE(CLK_USI1, "usi1", "aclk66", GATE_IP_PERIC, 11, 0, 0),
 	GATE(CLK_USI2, "usi2", "aclk66", GATE_IP_PERIC, 12, 0, 0),
 	GATE(CLK_USI3, "usi3", "aclk66", GATE_IP_PERIC, 13, 0, 0),
+	GATE(CLK_TSADC, "tsadc", "aclk66", GATE_IP_PERIC, 15, 0, 0),
 	GATE(CLK_PWM, "pwm", "aclk66", GATE_IP_PERIC, 24, 0, 0),
 
 	GATE(CLK_SCLK_UART0, "sclk_uart0", "div_uart0",
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
