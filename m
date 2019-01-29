Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101C5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:56:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D517F2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OliFTjIg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bEzq6B3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D517F2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PTWT+sC5C1Vn35rEtPAgCRQXTXKQAekQmB9N6shE/n8=; b=OliFTjIg7AL5SEfr6nuXPXfGEr
	By9bj7DIYN8kFLpKdNdtsHzMeu+aowjurZNzwCbQyltdSf8dmjo8YP2qUlLcDcBZs5gaX6Ke41FvT
	jDyPM5P8ZLAE2ThB4r+GCFKzEAIq4sRXjh6ed6Fz3Kmzv2SJDDxTxCfnL9x98UBzp6vmos0K/+gQo
	6qJ466V7dyyQdhgY3c3JIqh1nBY8zADhOV0jWCueAdwULNuwOGKrZSlrL9oCdZxls77YQ+kDSYfLz
	52T1TSJg1T1T99egzixukDjNCQ6vCybjTJzZ0L/rCdv8pUSbV1mJ4w7gHO+ovb1SO03NCroSdKYED
	n/fhxbAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXcE-0006PM-IM; Tue, 29 Jan 2019 17:56:06 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXbb-0005q8-Tq
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:55:31 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190129175526euoutp0233900603b17c18fdbb53ff0343e1a3de~_Y1IpdFXR2978229782euoutp02k
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 17:55:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190129175526euoutp0233900603b17c18fdbb53ff0343e1a3de~_Y1IpdFXR2978229782euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548784526;
 bh=gAM5TRktEeGRdR7DfQ1QhDkjvwroBHzBH5M4lKDBh1Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bEzq6B3DmqMsZEnRRl7lguHVZlTesLuoR6aefyjzNzBPXHcqtAWkR+JVMQuw3N7Zs
 A4tscuZqM36hiiyC5XlfAvlL+WXe4rCgpZZFJVV03DG5tlpQfy6AiDdYL+8zxiYcY2
 3WxycELe37dPBcrMaRbw6Bju4rK4BQRjFpIjlnQM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190129175525eucas1p289d4501ce42aa2c37b6a93ec07a0d52c~_Y1IGlY7s2879728797eucas1p2p;
 Tue, 29 Jan 2019 17:55:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 99.44.04806.D83905C5; Tue, 29
 Jan 2019 17:55:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190129175524eucas1p1ead98a852f002461984b9b99c5b5b7e4~_Y1HRQhfr2162921629eucas1p1s;
 Tue, 29 Jan 2019 17:55:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190129175524eusmtrp28592a47ced23435297f3449e94bf5e52~_Y1HCT9Y60424104241eusmtrp2Y;
 Tue, 29 Jan 2019 17:55:24 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-2b-5c50938db44e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F5.EE.04128.C83905C5; Tue, 29
 Jan 2019 17:55:24 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190129175523eusmtip198cda2cb230269cc0b4d2d7659406751~_Y1GUpRX52139021390eusmtip1G;
 Tue, 29 Jan 2019 17:55:23 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 3/8] clk: samsung: add BPLL rate table for Exynos 5422 SoC
Date: Tue, 29 Jan 2019 18:55:09 +0100
Message-Id: <1548784514-26649-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRj22zlnOw6Xx2n5eUlhFF7AqUzoA0UKioZCDu2XCXbKg4pu2o6X
 vEAqlbo0rShNRUsDZWTqElve8r4snIrLWxallJJahkqEpjnPrH/P91ze5+XlIzHxM8KZjFel
 MGoVnSjhC/G2od9Gn+J7iii/6jIJailvItDUxiKBagaMBCpZWMbQ6GizAI3krQjQbI4r0i1M
 Euhn0UcCTbRX8dF68QBA5aPdPNQ48EGAxt+cQe9zG/iofyWfQDuTLfhJO/mP6RsCuU5byJc/
 f3JN3vu9kye/3aoF8nWdm4IfKQyKYRLj0xi1b/BFYVxXxzaerBdfbW6/LsgBa7YaYE1CKgAO
 P+zCNUBIiqkGAA26aoJ7bAD4or/SoqwDuLR4Bz+IDOY3W4R6AKcrNfi/SN/jDb4GkCSfkkK9
 9oo54EBlwbmpV5jZg1E5GNTnle5PsqfC4LvdzX0/Th2Hf36lm2kRFQIHvxRjXJkbnDEW7mNr
 KhQWLMwB8xxIdQtg3rIWcKbTsHdyyLKdPfxmaBVw2BXuvqzhcZiFIwVaPoezYf6w3uIJhP2G
 ccK8A0Z5waZ2X44+BU2jzcBMQ+oQnF61M9PYHrzbVoZxtAgW3BRzbk/YWjRmKToC658+sAyX
 w4ptHcZdpxrAmp4ZXilwr/hf9ggALXBkUlllLMPKVEy6lKWVbKoqVno5SakDe7/o7Y5hUw+6
 ty/1AYoEEhuRVYQiSkzQaWyGsg9AEpM4iPy3wqLEohg6I5NRJ0WrUxMZtg+4kLjEUZRl9emC
 mIqlU5gEhklm1Acqj7R2zgEeinrMVFoyb6BlQcFSk2iwNkBwXqpICNmoOxdo8xlQVWuzmWvH
 Om8lTYyRpqWdE/dt20o91z2cvM96Re68DnP+7dKbEVNW4a6cm189mu1WHUk7+vVb5YZ3LGwZ
 I7Y7osOI8MJa2qmkJ1kWElH3dUkli/V1Pdzo7xgvDJ3yaZPgbBzt742pWfovBEsQvUEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Xd2eyQExBtO3qFhsnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XHnnusFpd3zWGz+Nx7hNFixvl9TBZr
 j9xlt7h4ytXiduMKNovDb9pZLf5d28jiIOjx/kYru8emVZ1sHpuX1HscfLeHyaNvyypGj8+b
 5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy
 9u7+w1KwQ6hiw64W9gbGD/xdjJwcEgImEkfbN7B0MXJxCAksZZS4snABM0RCTGLSvu3sELaw
 xJ9rXWwgtpDAJ0aJJfeSuhg5ONgE9CR2rCoECYsI1Ev0v7nEBjKHWaCPWaLx+GJWkISwgK/E
 t1eTmEHqWQRUJf5+LwcJ8wp4SRx92gu1Sk7i5rlOMJtTwFui4/EdRohVXhLfXv9gm8DIt4CR
 YRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgZGw79nPLDsaud8GHGAU4GJV4eBmCA2KEWBPL
 iitzDzFKcDArifAa/vaPEeJNSaysSi3Kjy8qzUktPsRoCnTTRGYp0eR8YNTmlcQbmhqaW1ga
 mhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpg1FH0nmIdd2fm2XhelfPbH3m/2v9h
 l0RoXZPE5KX3BK8+KHCNVYk9utzg4p2vwQmv3mmGqqv/aZl448fBRYH2vJnf93N+rj386eXR
 hdnfbVzuc1cvWGyg9eCLZWV5jKPyw/KvofWLlhimVewxbjG5sM0p1SL2Ur+YeO28pJ2zAmbd
 lFhewC8bocRSnJFoqMVcVJwIAPbT0eSiAgAA
X-CMS-MailID: 20190129175524eucas1p1ead98a852f002461984b9b99c5b5b7e4
X-Msg-Generator: CA
X-RootMTR: 20190129175524eucas1p1ead98a852f002461984b9b99c5b5b7e4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190129175524eucas1p1ead98a852f002461984b9b99c5b5b7e4
References: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190129175524eucas1p1ead98a852f002461984b9b99c5b5b7e4@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_095528_098336_3FDE2B56 
X-CRM114-Status: GOOD (  12.92  )
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
