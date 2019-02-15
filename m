Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C44C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30552192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e1fbh0eR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QB3bAesf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30552192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-reply-to:Message-id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QoMFYnQ1rGmHiwETkTHD+rw3XXd8HX/c4HRK2sFetPY=; b=e1fbh0eRHrnC/bEafX9zD+bmxG
	Akj9fzU/yqeUZ+XwKY5Gys5WT6MLAQsHg/OnZV9DxSZfz78i0IHu1oVG/lYRhKWaO1Oxr98Qex3UQ
	J1gwOoQiqY4A7qcpMNr+1+i9ZfMer/j2U7D2FsmfC3tAm3Zf8FBxQqouvsKYLruBud3P7KHWg2sbi
	e/y8CCPQ5cL5nEJ185w02Hd4HaDQOoZDKc5iq2Xe+TeH79QcS3+IwoCRGNMIUFZMEeRv5Y8Gd4B3e
	Nr0N+j1s+v8keGWhXIU9D/YVVPAjljdqg47erL59dNQtkaztW2/RgfsHN9a1hj1G4HvWIN7e5NLBg
	wLPFqEXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guczU-0006ci-A9; Fri, 15 Feb 2019 12:53:16 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucyy-00062h-Kx
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:52:48 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190215125241euoutp024ff235d6df1dd4a5ef872fed7558c991~DiqqTOA0Z0874008740euoutp02a;
 Fri, 15 Feb 2019 12:52:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190215125241euoutp024ff235d6df1dd4a5ef872fed7558c991~DiqqTOA0Z0874008740euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550235162;
 bh=vhh9h8Ye7R8ou4zjA7my3tgHS2E/fWcAEoavnXMxYc4=;
 h=From:To:Cc:Subject:Date:In-reply-to:References:From;
 b=QB3bAesfZtUgvBhfFSOCNLh6PU916l7hKL3q+GkWi4AGOWLFMfIaDXnpxz8sW9jKz
 X9OEaSLodYZv9QAu1JIlRVPJccX1dEcaiEcazroUbaUw6XX6d5kUV2HxT5/YwyKKjZ
 f10nCaohz/Xcky9ny9xNiI/PrFEMxCRR6sHBY50Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190215125241eucas1p20262ae6b89fb53b0e228c0ab383a8d5c~Diqpzv4C10629506295eucas1p2w;
 Fri, 15 Feb 2019 12:52:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id F6.35.04441.916B66C5; Fri, 15
 Feb 2019 12:52:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190215125240eucas1p219154e5bd27bd09dac0b8419c3e4e259~DiqpISWf-0683906839eucas1p2i;
 Fri, 15 Feb 2019 12:52:40 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-63-5c66b61990d7
Received: from eusync4.samsung.com ( [203.254.199.214]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.C7.04128.816B66C5; Fri, 15
 Feb 2019 12:52:40 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
 eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PMY00LS8X3MCB70@eusync4.samsung.com>;
 Fri, 15 Feb 2019 12:52:40 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] ARM: exynos: Enable support for ARM architected timers
Date: Fri, 15 Feb 2019 13:52:29 +0100
Message-id: <20190215125229.30180-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190215125229.30180-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7djP87qS29JiDHr+cFhsnLGe1eL6l+es
 FvM+y1qcP7+B3WLT42usFjPO72OyWHvkLrvF5k1TmR04PDat6mTzuHNtD5vHu3Pn2D02L6n3
 6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroyO+T+ZCxawVRzf0cDSwLiQtYuRk0NCwETi+aTz
 7CC2kMAKRomt/zS6GLmA7M+MEi9urGODKXp76z4TRGIZo8Tave2sEE4Dk8T1++vBRrEJGEp0
 ve0C6xAR8JaYfOYvO0gRs0AXk8TthQfAdggDJfZffA5UxMHBIqAqMX1yJEiYV8BWYtaFxVAn
 yUus3nCAGcTmFLCTWLOmhxlkjoTABDaJE5vmMEIUuUjsmHQKqkFG4vLkbhaIomZGifYZs9gh
 nB6gh+bsgHrCWuLw8YtgHcwCfBKTtk1nBrlCQoBXoqNNCML0kFi7AOqziUCtO/czT2CUWMDI
 sIpRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMw8k7/O/5pB+PXS0mHGAU4GJV4eFdkpMYI
 sSaWFVfmHmKU4GBWEuHlXJMWI8SbklhZlVqUH19UmpNafIhRmoNFSZy3muFBtJBAemJJanZq
 akFqEUyWiYNTqoFxkWWK6f8ljgHmcY6G8h3yx6yrvvfbyivVMx+evuCJ++J/QYKiVvu87ulx
 tUz20rZwuynC5nlt5UI1of1vQ+dw9k1iWvvlxcEja0+UeH9ud+5+abSBQXVy4sxpQjoXH3ZZ
 Hb0ewHyvP5S/bnYf9/LHVcZ1uXwzoxWPlk5cZW/xotmhyySpZaYSS3FGoqEWc1FxIgB4c1pq
 uAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42I5/e/4NV2JbWkxBjOWqVtsnLGe1eL6l+es
 FvM+y1qcP7+B3WLT42usFjPO72OyWHvkLrvF5k1TmR04PDat6mTzuHNtD5vHu3Pn2D02L6n3
 6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroyO+T+ZCxawVRzf0cDSwLiQtYuRk0NCwETi7a37
 TF2MXBxCAksYJZYv+QWWEBJoYpLomCUBYrMJGEp0ve1iA7FFBLwlJp/5yw7SwCzQwyTRfvU3
 O0hCGCix/+JzoCIODhYBVYnpkyNBwrwCthKzLiyGWiYvsXrDAWYQm1PATmLNmh5miF22EpdX
 PWCcwMizgJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmAobTv2c8sOxq53wYcYBTgYlXh4
 V2SkxgixJpYVV+YeYpTgYFYS4eVckxYjxJuSWFmVWpQfX1Sak1p8iFGag0VJnPe8QWWUkEB6
 YklqdmpqQWoRTJaJg1OqgbFV4I201paajZIyH/3etz9fdiN1Qfk8HY3lc51fqTsFPDriWFxi
 rlhw9tmPv/eqFbOXs3wI49UrXzxttgurS+fiJzuYNV60lBifCF+yU8RBeetnk+SjQUatdzi1
 eCReOU97MN1vi9+b5LxOhWMF2lxqzEzHjFrZz30pnXuXY9KDeTWmcRJapkosxRmJhlrMRcWJ
 ALLsAyEhAgAA
X-CMS-MailID: 20190215125240eucas1p219154e5bd27bd09dac0b8419c3e4e259
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215125240eucas1p219154e5bd27bd09dac0b8419c3e4e259
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125240eucas1p219154e5bd27bd09dac0b8419c3e4e259@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_045245_011384_DE593B7B 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ARM architected timer can be used together with Exynos MultiCore Timer
driver, so enable support for it. Support for ARM architected timers is
essential for enabling proper KVM support.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b40963cf91c7..b5ec21c027a1 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -18,6 +18,7 @@ menuconfig ARCH_EXYNOS
 	select EXYNOS_SROM
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select GPIOLIB
+	select HAVE_ARM_ARCH_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
