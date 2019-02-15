Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA6AC10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E955F2192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UJ30dLF1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NfrtUq8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E955F2192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-reply-to:Message-id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HvmfM4A+PeSgHUY5YR6oJPVHwsUZFOwwwm8h7XdNxkY=; b=UJ30dLF1Wpxw2/S5i80XwN8gk8
	UNbs5STQPl2u5p6/3O+p9s8YFkccEk9NeMzDBwJg9AAH8oY8EOgvOffF5u9/LFaD3jyDnmsYU/RLc
	j64V4GMKV0ucGWtwg427RKmlM/nm0fydCahQKro3OWHmUivvX4rFa/egSi/1SVCFRyx6tEspyabDH
	gvMUaqOrKw2cEKW1oKT6VbRnmqJ/wRxo5q8qxxN8bwh2SzmrAFw2d1Cnm/o2B5WkASy/6jOteh+N7
	o/9/dT3BvMsfjsmTwIG5tc2p86LLszOoT4UXXXoMR3HtpGqZxdINL/1LfpkrxEM6m2Nqgkr6I/KmK
	JJS3eF6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guczy-0007Ev-Bf; Fri, 15 Feb 2019 12:53:46 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucyy-00062g-Kw
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:52:48 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190215125241euoutp02189f6159585d643c1dcf8a77ef7a6ab6~Diqp2sCHz0820708207euoutp02-;
 Fri, 15 Feb 2019 12:52:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190215125241euoutp02189f6159585d643c1dcf8a77ef7a6ab6~Diqp2sCHz0820708207euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550235161;
 bh=fHx1/gTigQk7lKnUMAYd/WWCAnY+8EztucUv4WRMRU4=;
 h=From:To:Cc:Subject:Date:In-reply-to:References:From;
 b=NfrtUq8PgJWvinkvYmVZPYHgWENtZaAgF548PKCWv0XwiY+jI2mn0PSLFubeocZYc
 1MXJxC/oK1ypOO7Ou7YNo/4PHmpFOQn/LBmCzRDyy6z82WbVzx8zMqwXCbDXGMlnhJ
 zwbep7a8Rr4PEB3u/7EH8lA5cD1KnCZMGmuktWlE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190215125241eucas1p2170dc6909241b064d12511ab147908fd~DiqpbWarB2826728267eucas1p2a;
 Fri, 15 Feb 2019 12:52:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id B1.32.04806.816B66C5; Fri, 15
 Feb 2019 12:52:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190215125240eucas1p277671ab6d0eb4d1102d3cddd6c61c255~Diqor4ZpB2649426494eucas1p2t;
 Fri, 15 Feb 2019 12:52:40 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-0d-5c66b618b971
Received: from eusync4.samsung.com ( [203.254.199.214]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 30.20.04284.816B66C5; Fri, 15
 Feb 2019 12:52:40 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
 eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PMY00LS8X3MCB70@eusync4.samsung.com>;
 Fri, 15 Feb 2019 12:52:40 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] ARM: dts: exynos: Add support ARM architected timers
Date: Fri, 15 Feb 2019 13:52:28 +0100
Message-id: <20190215125229.30180-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190215125229.30180-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7djP87oS29JiDHav17XYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksfbIXXaLzZumMjtweGxa1cnmcefaHjaPd+fOsXtsXlLv
 0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBm3frUzFXSIVNx+t4G5gXGHQBcjB4eEgInE6x79
 LkYuDiGBFYwS07bNZIJwPjNKvPwwh7WLkROs6PbyQ4wQiWWMEv/eLIeqamCSuH5/PVgVm4Ch
 RNfbLjYQW0TAW2Lymb/sIEXMAl1MErcXHmAHSQgLeErMvtEGVsQioCrx7cg8FhCbV8BWYuPH
 y1Dr5CVWbzjADGJzCthJrFnTwwwySEJgBpvE418HGCGKXCQm/30O1SAj0dlxkAmiqJlRon3G
 LHYIp4dRYuucHWwQVdYSh49fBOtgFuCTmLRtOjMkCHglOtqEIEo8JO61f2WF+G0io0Tf17PM
 ExglFjAyrGIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAiMvtP/jn/dwbjvT9IhRgEORiUe
 3hUZqTFCrIllxZW5hxglOJiVRHg516TFCPGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQ
 nliSmp2aWpBaBJNl4uCUamC0eKf4d+H7ifzWKyfIJL2tXJdi/edWu+fW5mOHlnzg2eqtcIZl
 yyLHmBlPWrcenvff59nioLi1FWa/cqe2fwhXmbrJIMmbt49D6vw+g6xzR9OOPLlzau4aLqkz
 f9fvTb5y7+jNix77fXMDNKLWVGwo/FLu3rVW4Ou0Y5J99yLO/AxxFJh1j8vXQImlOCPRUIu5
 qDgRAI0GTz66AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42I5/e/4NV2JbWkxBosP81hsnLGe1eL6l+es
 FvM+y1qcP7+B3WLT42usFjPO72OyWHvkLrvF5k1TmR04PDat6mTzuHNtD5vHu3Pn2D02L6n3
 6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroxbv9qZCjpEKm6/28DcwLhDoIuRk0NCwETi9vJD
 jF2MXBxCAksYJabf38AKkhASaGKS6JglAWKzCRhKdL3tYgOxRQS8JSaf+csO0sAs0MMk0X71
 NztIQljAU2L2jTawIhYBVYlvR+axgNi8ArYSGz9eZoXYJi+xesMBZhCbU8BOYs2aHmaIZbYS
 l1c9YJzAyLOAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYDBtO/Zz8w7GSxuDDzEKcDAq
 8fCuyEiNEWJNLCuuzD3EKMHBrCTCy7kmLUaINyWxsiq1KD++qDQntfgQozQHi5I473mDyigh
 gfTEktTs1NSC1CKYLBMHp1QDY2f2uplpMhfcCh2XXxC/EHeJo/BefUChbMnh/bcCPXRK3X+c
 bDI9sVXzcMHL8h/aDlInDs/hOXE39lTm0n+rhS//OM59d/nR8sTXNbnT3+0z1f2aGz5j+wX9
 6HfChhoJlno7FBf2yh1iS1lkcPnwlD+P91x8MfHnuo0ht5POe1zy6JR0fji1/LUSS3FGoqEW
 c1FxIgCLZcC+IgIAAA==
X-CMS-MailID: 20190215125240eucas1p277671ab6d0eb4d1102d3cddd6c61c255
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215125240eucas1p277671ab6d0eb4d1102d3cddd6c61c255
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125240eucas1p277671ab6d0eb4d1102d3cddd6c61c255@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_045245_065376_5DD30996 
X-CRM114-Status: GOOD (  15.64  )
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

All CortexA7/A15 based Exynos SoCs have ARM architected timers, so enable
support for them directly in the base dtsi for Exynos3250, Exynos5250
and Exynos54xx SoCs. None of the known firmware properly configures arch
timer registers, so mark them as not-fw-configured and set frequency
to 24MHz, which is the only configuration supported by the remaining
drivers (clocks) so far.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 10 ++++++++++
 arch/arm/boot/dts/exynos5250.dtsi |  1 +
 arch/arm/boot/dts/exynos54xx.dtsi | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 608d17454179..3966e7960964 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -134,6 +134,16 @@
 			};
 		};
 
+		timer {
+			compatible = "arm,armv7-timer";
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			clock-frequency = <24000000>;
+			arm,cpu-registers-not-fw-configured;
+		};
+
 		sysram@2020000 {
 			compatible = "mmio-sram";
 			reg = <0x02020000 0x40000>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 80986b97dfe5..95af4050f69d 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -239,6 +239,7 @@
 			 * so we need the value from DT.
 			 */
 			clock-frequency = <24000000>;
+			arm,cpu-registers-not-fw-configured;
 		};
 
 		mct@101c0000 {
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index de26e5ee0d2d..45e06717ee51 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -46,6 +46,16 @@
 			status = "disabled";
 		};
 
+		timer {
+			compatible = "arm,armv7-timer";
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			arm,cpu-registers-not-fw-configured;
+			clock-frequency = <24000000>;
+		};
+
 		sysram@2020000 {
 			compatible = "mmio-sram";
 			reg = <0x02020000 0x54000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
