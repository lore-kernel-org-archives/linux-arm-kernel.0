Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED18C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1492192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OagGjGnj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hqgVt0yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1492192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-reply-to:Message-id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=34i3p5SKUbOUPoI26ALpMJTwSsojEYztHh9gGTy4zIY=; b=OagGjGnjYE3FqoZmfWtqXk923F
	pAYf98OZSr9vw/WS5fn/df/6PJ4B1SiluAWd6VlD6rYRUaBGCXznVL/Cbxni2atJcYShVeJwSetc5
	QHDq026lchkUn0y4WMe135EJAvjwjB1tseGuyVwhhnH//qkP53tGKpbcNJvBsg9+3Oxd/Ru845+T7
	TRk700Tw/+EajeO5gNCyckIk98rbMAjsnkeY0WitLG7gWi90DBtX0Qp2u2Q8YAe5RSOCryWF0wB6d
	v8u+1eHDtUF0VfwuF+Fii/BXQdnVjGeHKs2RQCO7hgKYoAEsf1X0YKCm+/KEfXXh2i+ota4x9TXZS
	noW/mgJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guczo-00071I-DD; Fri, 15 Feb 2019 12:53:36 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucyy-00062f-Kx
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:52:48 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190215125240euoutp02d1a5efa36947d21e2ce06a387213e33d~DiqpWbX8W0825108251euoutp022;
 Fri, 15 Feb 2019 12:52:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190215125240euoutp02d1a5efa36947d21e2ce06a387213e33d~DiqpWbX8W0825108251euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550235160;
 bh=S3nzVWc9y2XxWLwNUeI00lq0MvjHBGxxHnEHRZdYmK4=;
 h=From:To:Cc:Subject:Date:In-reply-to:References:From;
 b=hqgVt0yGgPw+g4Q4+rFIjWKkkdgG+uDPwZSntVkn54fzU8/53FZ8Ah7h1WW8SG6iL
 MW2g1IZ2Vy8Kj2AdTd8y3qf7rdxVF+9DUHwLx9GtqqRwpbyGRnKQZOcWL1eaUuc6Vo
 p29gMOYd3h/l7j4FJmUcmq5i9Fi4b5n2JjnuShlc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190215125240eucas1p1753129627de7da88667853b51eed2acd~Diqo-40Zo1088510885eucas1p11;
 Fri, 15 Feb 2019 12:52:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 53.AB.04294.816B66C5; Fri, 15
 Feb 2019 12:52:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2~DiqoSl1Fg2398823988eucas1p2s;
 Fri, 15 Feb 2019 12:52:39 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-de-5c66b61851c7
Received: from eusync4.samsung.com ( [203.254.199.214]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id B4.C7.04128.716B66C5; Fri, 15
 Feb 2019 12:52:39 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
 eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PMY00LS8X3MCB70@eusync4.samsung.com>;
 Fri, 15 Feb 2019 12:52:39 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] clocksource: exynos_mct: Increase priority over ARM
 arch timer
Date: Fri, 15 Feb 2019 13:52:27 +0100
Message-id: <20190215125229.30180-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190215125229.30180-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7djP87oS29JiDM6u4rfYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksfbIXXaLzZumMjtweGxa1cnmcefaHjaPd+fOsXtsXlLv
 0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBnP9/WzFXzjr3jVcI6pgfEcbxcjJ4eEgInEkc4m
 FhBbSGAFo8SU72ZdjFxA9mdGie6ZXWwwRTen3WGGSCxjlDi95RSU08AksWLXO3aQKjYBQ4mu
 txAdIgLeEpPP/GUHKWIW6GKSuL3wAFiRsECoxJ2bm5lBbBYBVYknWxtYQWxeAVuJY3O2MEOs
 k5dYveEAmM0pYCexZk0PVHwCm8Tep5UQtotE17MVTBC2jMTlyd0sIMskBJoZJdpnzGKHcHoY
 JbbO2QH1hLXE4eMXwbYxC/BJTNo2HWgqB1CcV6KjTQiixEPi5ePzjBCvTWSUODttDcsERokF
 jAyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAmPv9L/jX3Yw7vqTdIhRgINRiYd3RUZq
 jBBrYllxZe4hRgkOZiURXs41aTFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRm
 p6YWpBbBZJk4OKUaGAsZJSWErtZNWfJmbaiEy29v/fPJ4hZvVzvt8gtelpcSnqTbbbqrO9kq
 KdPebBfnscMus6zyqgzC95ha+rF84HE4XFQ8ZeJG3rCLS87vOTona+/6hmULlwdZqH+7cGrR
 T13B722XmhTaJP5GHHb2kDhw7vaBuxnpn+Us1wfOu7DAOvPL+19iWUosxRmJhlrMRcWJAH+D
 w0u5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsVy+t/xa7ri29JiDLZ90rfYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksfbIXXaLzZumMjtweGxa1cnmcefaHjaPd+fOsXtsXlLv
 0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBnP9/WzFXzjr3jVcI6pgfEcbxcjJ4eEgInEzWl3
 mLsYuTiEBJYwSlw5No8Fwmlikpj1uYEJpIpNwFCi620XG4gtIuAtMfnMX3aQImaBHiaJ9qu/
 2UESwgKhEhvezwRrYBFQlXiytYEVxOYVsJU4NmcLM8Q6eYnVGw6A2ZwCdhJr1vSA2UJANZdX
 PWCcwMizgJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmA4bTv2c8sOxq53wYcYBTgYlXh4
 V2SkxgixJpYVV+YeYpTgYFYS4eVckxYjxJuSWFmVWpQfX1Sak1p8iFGag0VJnPe8QWWUkEB6
 YklqdmpqQWoRTJaJg1OqgZGV6TE3bzGD39k9KxNWzMkPXxaj6logn73MWXbphBlt16a9Zzmm
 3nM6r22C+qmu+oNF0l+tKp69vKOfG+8U+fa0p88jQ63yD3OufVjyO070P8/eCVbJ6intfZm+
 f+q03LWOppUvkDMU06gMPdprt8VCXy3uRnKE17yyy74KD99ue7C+e++nk0osxRmJhlrMRcWJ
 ACekzJMjAgAA
X-CMS-MailID: 20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_045245_060277_AC3D48BB 
X-CRM114-Status: GOOD (  15.06  )
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

Exynos Multi-Core Timer driver (exynos_mct) must be started before ARM
Architected Timers (arch_timer), because they both share some common
hardware blocks (global system counter) and turning on MCT is needed
to get ARM Architected Timer working properly. Increase MCT timer rating
and hotplug priority over ARM Archictected timer driver to achieve that.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 4 ++--
 include/linux/cpuhotplug.h       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 49413900b24c..58090f57ada3 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -211,7 +211,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
 
 static struct clocksource mct_frc = {
 	.name		= "mct-frc",
-	.rating		= 400,
+	.rating		= 450,
 	.read		= exynos4_frc_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -465,7 +465,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->set_state_oneshot_stopped = set_state_shutdown;
 	evt->tick_resume = set_state_shutdown;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->rating = 450;
+	evt->rating = 500;
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index fd586d0301e7..bdd544f21102 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -115,10 +115,10 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_ACPI_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
+	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_JCORE_TIMER_STARTING,
-	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
 	CPUHP_AP_ARMADA_TIMER_STARTING,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
