Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE1C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:58:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9997A20839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C3W2fMQA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KwTlYxDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9997A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-version:Message-id:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=avPYa1BUeiXcG1VYOcjVy0T11T/ped86wxb6r0r2mvE=; b=C3W2fMQAY14Twx
	S7kDgygAsqCqC70ksY5Hkf0YGbbYBuBq7viJ6hamracEg0mURpqCLLcGT30TqjKhyYEKRKFUQu67V
	vr6elaOHLtRCBtICAprobXTnRmGaP9Pn+VZugCD0Bn+KN+V9fWFLNBk7jkTd8/KJaa65CkC9ZU3PB
	GnP59jHDgXQDH8VGM2CeKXYyupiE66Af7e9RwasBkSDKAyDLbSg7OnzcZxZ6hQTl/G0gaHVCF3ija
	Xwb1GTDy3j77X/JiN5xXe/xXrM3NmKTZrTwfniFZUsjBEPUSgXOb+ovIPbW1C54Q0XEn6AAvlk8oo
	PjOZCHtSLlDkcQOwgWlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX8mJ-00033I-RU; Wed, 12 Dec 2018 17:58:35 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8mF-00032M-7W
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 17:58:33 +0000
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20181212175814epoutp02348ee657d45f34074a518d2e67efad7e~vp54rFXcV0476604766epoutp024;
 Wed, 12 Dec 2018 17:58:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20181212175814epoutp02348ee657d45f34074a518d2e67efad7e~vp54rFXcV0476604766epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544637495;
 bh=SjH+fnwAsfS01F3whO8ov8RcBJ+zH22C+/1DnL3Pv9M=;
 h=From:To:Cc:Subject:Date:References:From;
 b=KwTlYxDV7odYD+V8nNl8zKAMYTUNvqTX5Ze1qnoIbmjqVLMPI2az4zs/ISf/ZDt/g
 ujC0ERboLPtK4WLmPrMRVNfzOOPwC/SJ6qfwnW5+bZIUpX+GUeEB7DhtFxP+oXjsU+
 cOOVJ2YYJx0uhha1RiZMagq0ho1Bu7bDZoV+DOm0=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20181212175813epcas2p1472efb481ff7c03ba11a293d0700d3c4~vp53qiyIX2736527365epcas2p1r;
 Wed, 12 Dec 2018 17:58:13 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 73.9E.04060.53C411C5; Thu, 13 Dec 2018 02:58:13 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20181212175813epcas2p26f7ec0e0e5e90d1e9cb7aeccd273e0ab~vp53JDyas1575115751epcas2p2S;
 Wed, 12 Dec 2018 17:58:13 +0000 (GMT)
X-AuditID: b6c32a46-b2dff70000000fdc-b7-5c114c35fa9c
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
 (Symantec Messaging Gateway) with SMTP id FA.59.03627.53C411C5; Thu, 13 Dec
 2018 02:58:13 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
 2014)) with ESMTPA id <0PJM00G7SXWLKH60@mmp2.samsung.com>; Thu, 13 Dec 2018
 02:58:13 +0900 (KST)
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Subject: [PATCH] ARM: dts: exynos: Specify I2S assigned clocks in proper node
Date: Wed, 12 Dec 2018 18:57:44 +0100
Message-id: <20181212175744.8287-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.19.2
MIME-version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCmua6pj2CMwbbNphbzj5xjtTh/fgO7
 xabH11gtLu+aw2Yx4/w+JovWvUfYLQ6/aWe1WLDxEaMDh8emVZ1sHpuX1Hv0bVnF6PF5k1wA
 SxSXTUpqTmZZapG+XQJXxsz7h1gKHslUfH74mqWBca14FyMHh4SAicT8Tv8uRi4OIYEdjBL7
 V65khHC+M0qsXXeaqYuRE6zo9amt7BCJDYwSp84eZYFwfjFKTH/5hxWkik3AUKL3aB8jiC0i
 ICxxb+lysA5mgSeMEktfdLOAJIQF/CUeLXjPCLKbRUBV4vHxdJAwr4CVxKVTJ6G2yUtc2HCL
 FSIuKPFj8j2wVmag+MErz8EWSwhMYZM4/HkFK0SDi8SRZ7fYIWxhiVfHt0DZ0hLPVm1khLCr
 JXZt72aGaO5glGi5sJ0ZImEtcfj4RVaIDXwSHYf/skMChleio00IosRDYvL2F2AlQgKxEmvu
 TGedwCg1C8l9s5Dct4CRaRWjWGpBcW56arFRgZFecWJucWleul5yfu4mRnAMa7ntYFxyzucQ
 owAHoxIPb4a0YIwQa2JZcWXuIUYJDmYlEd4tWkAh3pTEyqrUovz4otKc1OJDjNIcLErivA+l
 50YLCaQnlqRmp6YWpBbBZJk4OKUaGI+G6beU+fXdFQ6sYLWsmHaz3WGvzXTOSq9/EgKH34TM
 XZiqlLRUyEnO6tEjvval/cz5Fgc8XuflTdq/KuCYUIV48rRXbEW23ZaKHmdZD0upcLs/lNo9
 O2Pb6VOGkjYJIVeStC4+0zTfO3fl0wbrCecYJs99Jcl3s71KcJGA7566Ta06jQ9OK7EUZyQa
 ajEXFScCAISJXpvdAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsVy+t9jQV1TH8EYg+ffeCzmHznHanH+/AZ2
 i02Pr7FaXN41h81ixvl9TBate4+wWxx+085qsWDjI0YHDo9NqzrZPDYvqffo27KK0ePzJrkA
 ligum5TUnMyy1CJ9uwSujJn3D7EUPJKp+PzwNUsD41rxLkZODgkBE4nXp7aydzFycQgJrGOU
 mP+nBcr5xSjR8WEXK0gVm4ChRO/RPkYQW0RAWOLe0uVgRcwCTxglPnasYgNJCAv4Ssxe/RrI
 5uBgEVCVeHw8HSTMK2AlcenUSSaIbfISFzbcYoWIC0r8mHyPBcRmBoofvPKcZQIjzywkqVlI
 UgsYmVYxSqYWFOem5xYbFRjlpZbrFSfmFpfmpesl5+duYgQG3bbDWv07GB8viT/EKMDBqMTD
 e0BWMEaINbGsuDL3EKMEB7OSCO8WLaAQb0piZVVqUX58UWlOavEhRmkOFiVxXv78Y5FCAumJ
 JanZqakFqUUwWSYOTqkGxp3n3iWqSPD/WvI46WQVD9uXCW16OSu1ly0LY+D7UFg95UXcepM1
 gs4nGMuW5SrMnCJY2L17+tQXOrM1n6mvip9dtmhf4d/zqrUebXUPDpWf2XXqhU/29ylWn5VD
 bSVqWHZVR+g9264c97xzy8HY3AVCll9V7C125P4sU9Goe3z+7e+zWRf6lyixFGckGmoxFxUn
 AgCAx2MbNgIAAA==
X-CMS-MailID: 20181212175813epcas2p26f7ec0e0e5e90d1e9cb7aeccd273e0ab
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181212175813epcas2p26f7ec0e0e5e90d1e9cb7aeccd273e0ab
References: <CGME20181212175813epcas2p26f7ec0e0e5e90d1e9cb7aeccd273e0ab@epcas2p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_095831_432242_38481465 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, robh+dt@kernel.org,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The assigned parent clocks should be normally specified in the consumer
device's DT node, this ensures respective driver always sees correct clock
settings when required.

This patch fixes regression in audio subsystem on Odroid XU3/XU4 boards
that appeared after commits:

'commit 647d04f8e07a ("ASoC: samsung: i2s: Ensure the RCLK rate is properly determined")'
'commit 995e73e55f46 ("ASoC: samsung: i2s: Fix rclk_srcrate handling")'
'commit 48279c53fd1d ("ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access")'

Without this patch the driver gets wrong clock as the I2S function (op_clk)
clock in probe() and effectively the clock which is finally assigned from DT
is not being enabled/disabled in the runtime resume/suspend ops.

Without the above listed commits the EXYNOS_I2S_BUS clock was always set
as parent of CLK_I2S_RCLK_SRC regardless of DT settings so there was no issue
with not enabled EXYNOS_SCLK_I2S.

Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 9 ++++-----
 arch/arm/boot/dts/exynos5422-odroidxu4.dts        | 9 ++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
index 03611d50c5a9..e84544b220b9 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -26,8 +26,7 @@
 			"Speakers", "SPKL",
 			"Speakers", "SPKR";
 
-		assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>,
-				<&clock CLK_MOUT_EPLL>,
+		assigned-clocks = <&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
 				<&clock CLK_MOUT_USER_MAU_EPLL>,
 				<&clock_audss EXYNOS_MOUT_AUDSS>,
@@ -36,8 +35,7 @@
 				<&clock_audss EXYNOS_DOUT_AUD_BUS>,
 				<&clock_audss EXYNOS_DOUT_I2S>;
 
-		assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>,
-				<&clock CLK_FOUT_EPLL>,
+		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
 				<&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
 				<&clock CLK_MAU_EPLL>,
@@ -48,7 +46,6 @@
 				<0>,
 				<0>,
 				<0>,
-				<0>,
 				<196608001>,
 				<(196608002 / 2)>,
 				<196608000>;
@@ -84,4 +81,6 @@
 
 &i2s0 {
 	status = "okay";
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>;
 };
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 4a30cc849b00..122174ea9e0a 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -33,8 +33,7 @@
 		compatible = "samsung,odroid-xu3-audio";
 		model = "Odroid-XU4";
 
-		assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>,
-				<&clock CLK_MOUT_EPLL>,
+		assigned-clocks = <&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
 				<&clock CLK_MOUT_USER_MAU_EPLL>,
 				<&clock_audss EXYNOS_MOUT_AUDSS>,
@@ -43,8 +42,7 @@
 				<&clock_audss EXYNOS_DOUT_AUD_BUS>,
 				<&clock_audss EXYNOS_DOUT_I2S>;
 
-		assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>,
-				<&clock CLK_FOUT_EPLL>,
+		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
 				<&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
 				<&clock CLK_MAU_EPLL>,
@@ -55,7 +53,6 @@
 				<0>,
 				<0>,
 				<0>,
-				<0>,
 				<196608001>,
 				<(196608002 / 2)>,
 				<196608000>;
@@ -79,6 +76,8 @@
 
 &i2s0 {
 	status = "okay";
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>;
 };
 
 &pwm {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
