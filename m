Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3EF2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E4cmz/CY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eq1kM6kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3EF2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PTWT+sC5C1Vn35rEtPAgCRQXTXKQAekQmB9N6shE/n8=; b=E4cmz/CYDz32iKuTt1nCMvmURn
	z/OQB8QkCZeddOaTqI9Y0J01firased8qakMmJLhdwVfkT9g4DAWnG5Q9vQ0mOnGW84z5H3SkjVl5
	v64uNmdTg3Iy001LiSJHGmESqE9+kZ2y0LUK4UByozXG2quoIXl6AZorKtWWKnG5YWh6ia07ydb2X
	pq29wroSiam4Ebk8zSdm/UiIfbzNMfsvIC4p97Zxgnl1OfJxCdyX3a4muTpg3fWipeMfbf6va1ruz
	wHVE5MQU2TP0TQjMI6cCWXAnTsRtwgGuk4PwCnFVb8m9MGpp4c5EdVmE7syU4karR6Ki9T0/WbDnf
	W+OECzOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp836-00053i-PI; Thu, 31 Jan 2019 08:50:16 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp831-00051C-Fd
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:50:13 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190131085009euoutp016392ddf117e9757fd9a2fbeecaa12510~_4rnMgTTJ2234722347euoutp01g
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 08:50:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190131085009euoutp016392ddf117e9757fd9a2fbeecaa12510~_4rnMgTTJ2234722347euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548924609;
 bh=gAM5TRktEeGRdR7DfQ1QhDkjvwroBHzBH5M4lKDBh1Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eq1kM6kjwX3NI2/vmcw1895n+GZVTpS0bDBDqWLPb62r0QFdl5vYz5sDRBQCZ8M6d
 ksAfdBh3rXwklbqzQOmj1h8IcVYB37qcd4T5y6HYKtJg6uU7JAdG8GHp08wNeFqTlJ
 nvvKb9G+DM5sM+3x8DZCQaRk4OYqJsqbTOva5q7k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190131085008eucas1p2ba839b83132ff9ec44e10359baa62cfc~_4rmSVvQu1766917669eucas1p2Q;
 Thu, 31 Jan 2019 08:50:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 32.2C.04294.0C6B25C5; Thu, 31
 Jan 2019 08:50:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190131085007eucas1p2f16107042b8ce5638811840618bcf017~_4rlfbQr92508525085eucas1p2o;
 Thu, 31 Jan 2019 08:50:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190131085007eusmtrp2215325dae20568f3f1fe00cb1c4725a3~_4rlOzgi42341223412eusmtrp2b;
 Thu, 31 Jan 2019 08:50:07 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-9c-5c52b6c0c7b8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.7B.04128.FB6B25C5; Thu, 31
 Jan 2019 08:50:07 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190131085006eusmtip1d88b419e5223447199ba87ec5d9ab703~_4rkeoV8E1303413034eusmtip1G;
 Thu, 31 Jan 2019 08:50:06 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos 5422 SoC
Date: Thu, 31 Jan 2019 09:49:49 +0100
Message-Id: <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRj229nZOYpHj0fJLzODkVBKmhH1gV0MKpYh2gWJMmrpYQ6v7XjJ
 tJrmdWiKUEpp+kPQlqIulTUv2SaK5mVieEktRWqlZoWjCG85z6p/z/dc3ud94SMx5hnuRspj
 E1hFrDRaLLITtnT/HtzX2XI+bL+mgEaNpfU4GjObcFTRNYijwrkFDA0NNRBoIGORQO+U7kgz
 N4qjH/nvcTSiKxOh5YIugEqHOgSormuaQMN9p9Bkeo0IGRZzcLQ+2igMcJJ8G88iJBp1nkjy
 ouqe5PVSm0DyoEkNJMsajxDRZbsjEWy0PIlV+B67bhfZ3roqjNcytxp0mYQSfHdUAVsS0gdh
 lumjUAXsSIauAbBW1QP4hxnAeUO3VVkGsLL3E64C5FbEaIrn+WoA+/srRf8SqpJpwmIS0T5Q
 q75pqXChU+HU2CvM4sFoJQa1GUVCi+BMB8OsX7MCi19Ie8KyNk8LTdGBUDtfQPDrecCJwTzM
 gm3ps7BKtYbxfAcBzT9xHp+Ea8ZqK+8M53uarFl3uPGyQsBjDg7kqkU8ToM5vVqrxx8aeoa3
 7sLovbBe56sCxCZ9ArYH8Mc6wPGvThYvtgmLW0ownqZgbjbDj9gDm/KN1pptsLr2kXW0BBaX
 F29VMvRTAMc6/IvArsf/myoBUANXNpGLkbHcgVg22YeTxnCJsTKf8LgYDdj8QG/We8xaoFu9
 oQc0CcT21EzduTAGlyZxKTF6AElM7EL5rQSHMVSENOU2q4i7pkiMZjk92EEKxa5Uqs3MFYaW
 SRPYKJaNZxV/VQFp66YE3p+nvkTqAwckq0m1FVTb5KFOZmEGKtcNWGeIMWS7FxU6dGluZqIj
 Sm56GOR9eilNrC6X3fVonn7iN6YevNMbburb2J3ukOzj6BWw2Jxhlgcdbh05XthvjLTJZnc2
 Jd7vzzxKrVz0g2c8oijD8w+erkZdyQUn+9DKWflb+mq3WMhFSv28MAUn/QPzdQXiPAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Xd3924JiDF40CFpsnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XHnnusFpd3zWGz+Nx7hNFixvl9TBZr
 j9xlt7h4ytXiduMKNovDb9pZLf5d28jiIOjx/kYru8emVZ1sHpuX1HscfLeHyaNvyypGj8+b
 5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy
 9u7+w1KwQ6hiw64W9gbGD/xdjBwcEgImEheeF3QxcnEICSxllJizax1TFyMnUFxMYtK+7ewQ
 trDEn2tdbBBFnxglWpovsoA0swnoSexYVQhSIyJQL9H/5hJYDbNAH7NE4/HFrCAJYQFfiaO/
 V7CD1LMIqErM2aMKEuYV8JLY8aoXar6cxM1zncwgNqeAt8SSrr9gthBQzY9/HxknMPItYGRY
 xSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERgZ24793LKDsetd8CFGAQ5GJR7eB2sDY4RYE8uK
 K3MPMUpwMCuJ8Br+9o8R4k1JrKxKLcqPLyrNSS0+xGgKdNNEZinR5Hxg1OaVxBuaGppbWBqa
 G5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamDc8krC3jr/htiOv9O8deT+hjqFTTop
 +bDvf8mJb7F3y6xz5l730vl4XCRv5VrZtf7Wk58efD334jO5vHDFxERm/5BLkrX1lnsq1PQq
 QtdPb8gJvLsnoj+v5nn3pj0Mwc0Nb0tjzpdN3ndVtqZVzL9+d5vKjVk68g8vyuee1jB84DO7
 x9T9NrsSS3FGoqEWc1FxIgBD/FAZogIAAA==
X-CMS-MailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
X-Msg-Generator: CA
X-RootMTR: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_005011_847653_8B325952 
X-CRM114-Status: GOOD (  12.34  )
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
Cc: b.zolnierkie@samsung.com, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, krzk@kernel.org,
 Lukasz Luba <l.luba@partner.samsung.com>, cw00.choi@samsung.com,
 kyungmin.park@samsung.com, kgene@kernel.org, myungjoo.ham@samsung.com,
 s.nawrocki@samsung.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
Controller frequencies for driver's DRAM timings.

CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-samsung-soc@vger.kernel.org
CC: linux-clk@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 3e87421..8bf9579 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1325,6 +1325,19 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
 	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
 };
 
+static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
+	PLL_35XX_RATE(24 * MHZ, 933000000, 311, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
+	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
+	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
+	PLL_35XX_RATE(24 * MHZ, 138000000, 184, 2, 4),
+};
+
 static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
 	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
 	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
@@ -1467,7 +1480,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
 		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
-		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
 	}
 
 	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
