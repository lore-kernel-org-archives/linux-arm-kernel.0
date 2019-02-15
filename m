Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D25C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D6F2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FCkVSDzb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T5gkn+of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D6F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Message-id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:List-Owner; bh=lA6kI/cx4Pa1SQ0zwYAhp4Uut7CGF6yDPSTDbc2EIUA=; b=FC
	kVSDzb0S6u1FLgiHLTDsQEa9TXj1rW8RhhQYmqnRiqINWO0UOEMwrufJYoDN27hezfgbHF6fbkhZX
	qtfhsSMZNhaqyhKlsSUMlc+avYndthvt3nA+KgEK1DSc1Y7wXwlEV0p8SbHZ7k/HLnfNrUYr+Z8Xi
	6vhWBieDZMImu2msuAgSgMDSCHdSKJsSXPJgYBSyeP18Q8Ybnj/2Ht22mPVhiQegP1D/SxHULyH/l
	DwDDSsA9ufSs0cBTNderveZwFvadHcGfvLgy0uTQXMARRSyA1q1CCLQbmBBc5Q+RDmlpU+LUoZY5X
	HWBRlNOYAnpA4SVyYgpAUpoOJ5sFnSeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gucz3-00064i-Go; Fri, 15 Feb 2019 12:52:49 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucyy-00062b-Kx
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:52:46 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190215125240euoutp020a9af8cf471e93f070703eee78555780~DiqoqgfrB0814508145euoutp02D;
 Fri, 15 Feb 2019 12:52:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190215125240euoutp020a9af8cf471e93f070703eee78555780~DiqoqgfrB0814508145euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550235160;
 bh=AmZKpaQJcCRJYjglpjOPbLazFEnUnkpKaFbP4Z2GDfw=;
 h=From:To:Cc:Subject:Date:References:From;
 b=T5gkn+of6KW4xhHaFgCaBut1uCPRMkDrGfoJcsLyrbJgZNzls/w7Jn8678ihcFujL
 Di8VbcbuxviW9NXOJMZdTd0k3T0vcTOYjkbXdlTB0DqiBBangifSVWpNtVXXw6E/XS
 VobmBmptEApUVzXZiYDgHEr/ZR9WW24RXRL4bvro=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190215125239eucas1p12eae520f3e6d215dd076179ffbabb2d3~DiqoFmzUY2445424454eucas1p1I;
 Fri, 15 Feb 2019 12:52:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id A2.AB.04294.716B66C5; Fri, 15
 Feb 2019 12:52:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190215125238eucas1p2f56fe48600aedcec048bc378ed184419~DiqnYNNRI2420224202eucas1p2p;
 Fri, 15 Feb 2019 12:52:38 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-da-5c66b617dc23
Received: from eusync4.samsung.com ( [203.254.199.214]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 72.C7.04128.616B66C5; Fri, 15
 Feb 2019 12:52:38 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
 eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PMY00LS8X3MCB70@eusync4.samsung.com>;
 Fri, 15 Feb 2019 12:52:38 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] Exynos SoCs: enable support for ARM Architected Timers
Date: Fri, 15 Feb 2019 13:52:24 +0100
Message-id: <20190215125229.30180-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7djP87ri29JiDGbNELTYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksfbIXXaLzZumMjtweGxa1cnmcefaHjaPd+fOsXtsXlLv
 0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBlLj29iKzjGU/H3yC/GBsa5XF2MnBwSAiYSp/9e
 ZOti5OIQEljBKPFn5kQ2kISQwGdGiUnX/LoYOcCKTj1mhahZxiixu/EfE4TTwCSxf+4zJpAG
 NgFDia63XWDNIgLeEpPP/GUHKWIW6GKSuL3wADtIQhgocff7PrAGFgFViWtTtzKD2LwCthK7
 GqeyQ5wkL7F6wwFmkGYJgZ+sEpdOH2GESLhInDzxlQXClpG4PLmbBaKomVGifcYsdginh1Fi
 65wdbBBV1hKHj19kBbGZBfgkJm2bzgzxEK9ER5sQRImHRFfnbiaIn2MlNjx6zDKBUXwBI8Mq
 RvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwAg7/e/4lx2Mu/4kHWIU4GBU4uFdkZEaI8Sa
 WFZcmXuIUYKDWUmEl3NNWowQb0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZqakF
 qUUwWSYOTqkGRo+llmuypWv2rt9twvRtZ/2rTeVzp7MsT+7ksJj6+WP5xla1PIZjNq3e15Ka
 eGeJu/ZPMbVrX+py0K7G/KDm/C2btGtm3umcGNNwNV4l5V+h1q608rkflq2VmGq37H36l8Z8
 XiFH4e7ucJYfLcusnB5bPrq7VWhhdauezLQYDp4VCc3B67ZeVGIpzkg01GIuKk4EAHBGBiGs
 AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOJMWRmVeSWpSXmKPExsVy+t/xa7pi29JiDH7dUrDYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksfbIXXaLzZumMjtweGxa1cnmcefaHjaPd+fOsXtsXlLv
 0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBlLj29iKzjGU/H3yC/GBsa5XF2MHBwSAiYSpx6z
 djFycQgJLGGUWLXjKpTTxCSx8e8VIIeTg03AUKLrbRcbiC0i4C0x+cxfdpAiZoEeJon2q7/Z
 QRLCQIm73/cxgdgsAqoS16ZuZQaxeQVsJXY1TgWrkRCQl1i94QDzBEauBYwMqxhFUkuLc9Nz
 i430ihNzi0vz0vWS83M3MQKDY9uxn1t2MHa9Cz7EKMDBqMTDuyIjNUaINbGsuDL3EKMEB7OS
 CC/nmrQYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYxK
 4n1fthzZ1mg4MY15W/rvly8/Pj78ZF5sbofrgmTlJDPGEh9LK7P+VazV0yfyi+zZfX8BY6P7
 8kWqH2adfL+x8uw1dWnOAtWvwS8mSu728ywOjqvuzZiyOstQj30xY1cVewDPI7sT09ryprGl
 qoubXS2zEi+fKbvnpMgrlj+//5wrrny3aZUSS3FGoqEWc1FxIgAMIyrlCgIAAA==
X-CMS-MailID: 20190215125238eucas1p2f56fe48600aedcec048bc378ed184419
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215125238eucas1p2f56fe48600aedcec048bc378ed184419
References: <CGME20190215125238eucas1p2f56fe48600aedcec048bc378ed184419@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_045245_008729_C66D62AD 
X-CRM114-Status: GOOD (  14.02  )
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

Dear All,

ARM Architected Timers are present in all CortexA7/A15 based Samsung
Exynos SoCs. So far they were not enabled, because there were some issues
related to their initialization. Samsung Exynos SoCs used custom timer
hardware - Exynos MultiCore Timer. It turned out that enabling MCT it is
also needed to get ARM Architected Timers working, because they both
share some common hardware blocks (global system counter).

This patchset enables support for ARM Architected Timer driver together
with a standard Exynos MultiCore Timer driver, which is kept as a default
timer source on ARM 32bit platforms. Support for ARM architected timers
is essential for enabling proper KVM support on those platforms.

Some of the MCT cleanup patches were earlier a part of the similar
patchset for ARM64-based Exynos5433 SoC.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Marek Szyprowski (5):
  clocksource: exynos_mct: Remove dead code
  clocksource: exynos_mct: Fix error path in timer resources
    initialization
  clocksource: exynos_mct: Increase priority over ARM arch timer
  ARM: dts: exynos: Add support ARM architected timers
  ARM: exynos: Enable support for ARM architected timers

 arch/arm/boot/dts/exynos3250.dtsi | 10 ++++++++++
 arch/arm/boot/dts/exynos5250.dtsi |  1 +
 arch/arm/boot/dts/exynos54xx.dtsi | 10 ++++++++++
 arch/arm/mach-exynos/Kconfig      |  1 +
 drivers/clocksource/exynos_mct.c  | 27 +++++++++++++++++----------
 include/linux/cpuhotplug.h        |  2 +-
 6 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
