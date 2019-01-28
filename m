Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42806C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:36:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1313D20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hKsly8S4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSm1rIGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1313D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kZME7IU33N4gQ/+RVxril12M/OYaN9+XzT8peLFtGvE=; b=hKsly8S4orgDflcOVw9ul/Y4Wi
	VlakhVSeZ1hV3n4ydQw4uDZHC3iIju/yKpPgYDiykhQDrmkI/k1dAGSW2KqP7uoVl7Qj7imlymSI5
	hkXcVT0i/qoH/k/8bASuZ4VufdC37oEj8ouRN1N+/DpmQ1NLbtnHrjfAnPkNhEdWN/lqYs4O9oVjw
	duw256LGLxZ2LPp9u6uA+e+y71nlCPJxNl1iOHY2GIyP6aXlO44glsP1WRduf4ivA8e2mAM4E9DbJ
	QqZvMdtGp4c/yxdxxiacGbP3JkzfNulFlbO1/gBXzQVZeHH2q0sQsEvlIg6HwvuBjdJc+vdPOCSI7
	NZ7iuxpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBlG-0000dd-9V; Mon, 28 Jan 2019 18:35:58 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBiu-0005k0-F6
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:33:37 +0000
Received: by mail-wr1-x442.google.com with SMTP id r10so19194933wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+HV8Nby8D/Sn6SAvkoxC802zTo0ynRqZ7bbip7gTvlU=;
 b=jSm1rIGlQyTPja2+ldYbXDr+A1YqBNWmTeaDsPGMl7TadS2uye65vk+lYjGr8Yox3F
 80uPZnH1mldfRsnbu+xQwdKYVWUR16/oHBEGlzc1Ck4LcODmicjYbz0BPrPxx7pAYW7i
 UdjwgF9oGxKzZb573jtPHKtsEE2WYnR1uGpxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+HV8Nby8D/Sn6SAvkoxC802zTo0ynRqZ7bbip7gTvlU=;
 b=ODoQ6X3kzFVl6Wv62mzE62Px+83TSoIuw4/z8nvXFgUYxpFtRvAqLT6Qe8Bv/Dt4PQ
 dCigD6UjZ7UtSTA7CJnKOUm9Hounrf0JNIYnGEQ6DFAqBS9i1SPTKQVX2ypbcYRS5GBD
 pEs2OHUKZlACfr44gBJyZtVWf9+jNs+MdB0qiP/baQDoYQ6k1qJLSKEn6EclYe+F9kVH
 MFJRs3r/Dr/L8Z4t5dw3/eDKBIhc579xsDxUtk29h8PuSAy1+3odvhyJdJjSl+cIkeT4
 HeRg39tXlII8sK1kKPBiq849O46DZKldKcR6kDf1XOjplrImUG7OOpg94xnECrmbOBVV
 Gy5A==
X-Gm-Message-State: AJcUukc5q/Hrl9g9C70AZBZLRFbAhoHnheG14S7cWHYMmuSyFJGIt4z0
 VNcPrCjw2UKozaLWrURT9GhSzQ==
X-Google-Smtp-Source: ALg8bN56Btc4EmKhRmzfolsJuEPhFqCUgA9Tle2qQgKO/izjpdp9h32ZsM+121WwJEPOwl4jYwVVBQ==
X-Received: by 2002:a5d:6808:: with SMTP id w8mr22035898wru.270.1548700410592; 
 Mon, 28 Jan 2019 10:33:30 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 10:33:29 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
 bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org,
 jassisinghbrar@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com, arnd@arndb.de,
 horms+renesas@verge.net.au, heiko@sntech.de, sibis@codeaurora.org,
 enric.balletbo@collabora.com, jagan@amarulasolutions.com, olof@lixom.net
Subject: [PATCH v2 08/14] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Date: Mon, 28 Jan 2019 19:32:55 +0100
Message-Id: <1548700381-22376-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103332_746533_896DBB94 
X-CRM114-Status: GOOD (  15.91  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 niklas.cassel@linaro.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
to keep the software model of the clock in line with reality, the
framework transverses the clock tree and disables those clocks that
were enabled by the firmware but have not been enabled by any device
driver.

If CPUFREQ is enabled, early during the system boot, it might attempt
to change the CPU frequency ("set_rate"). If the HFPLL is selected as
a provider, it will then change the rate for this clock.

As boot continues, clk_disable_unused_subtree will run. Since it wont
find a valid counter (enable_count) for a clock that is actually
enabled it will attempt to disable it which will cause the CPU to
stop. Notice that in this driver, calls to check whether the clock is
enabled are routed via the is_enabled callback which queries the
hardware.

The following commit, rather than marking the clock critical and
forcing the clock to be always enabled, addresses the above scenario
making sure the clock is not disabled but it continues to rely on the
firmware to enable the clock.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/hfpll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index 0ffed0d..9d92f5d 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -58,6 +58,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
 		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
 	};
 
 	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
