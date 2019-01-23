Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04971C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:56:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D8E2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G8Xx4ZEI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I5VEf+i5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D8E2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FuNnGAmQ+J72vD9mXPt79KPzOcifdgVCO97XkFjIq/U=; b=G8Xx4ZEIVbanRX
	pqxyogV/8VpuFUAaxkFWM9w6O3/OnGraTl1TXsWN70SojXEx1HFQiBF5bJ5sAAUv7FITKkxXRmczd
	3wIjCY6RxCODY0JH/z4O/PalexKkqiBhPCU5nL5S23CE7KgfARk0O+NZ+vqoafFPGXhE6KtKxmA6Q
	UQhqPQjcw1yq7z8zeNukU00qRi/wOMTgmVrkBUrs0TdNfpLTnR6N0mmxmpzWf3ym4FlYd1d+hTfqW
	h5wsTGi1PGEQE4GrELOAcx32hb9YSQCkUIajyLBh3AvoRPME7MvQyEb4yIu2B9vhvMeBjutg8Xb1n
	hap3e6I3YsboJDvMCMHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLom-0001KF-OE; Wed, 23 Jan 2019 16:56:00 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLoj-0001Ig-5G
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 16:55:59 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190123165552euoutp0293175cc6ecd954faea50b76c6c77aca6~8iJavNVXR1410514105euoutp02P
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 16:55:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190123165552euoutp0293175cc6ecd954faea50b76c6c77aca6~8iJavNVXR1410514105euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548262552;
 bh=PzMg4GV1XDi6Y5SAe2HJT0Zvt3QmVJ+RidOcaZENDo4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I5VEf+i5T94R4VphrY2TtCQ6Z/e3NHZpR89R6WCP4fIfgdT5vFgwZUOmY69TH8dCV
 h98n1cQRqpkAR3lV8BoPFnYDVhyV3UJyXsn7M4ujCgd30rM6jS3WsLfupnLZ9Vj0Tt
 Acnb6WKdu51OlwoT9eyJ7xQWW3lk+QAmhJ1al5BM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190123165551eucas1p1efaadcf042c497005404751179695382~8iJZnypc72033420334eucas1p1o;
 Wed, 23 Jan 2019 16:55:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 3C.42.04806.79C984C5; Wed, 23
 Jan 2019 16:55:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190123165550eucas1p1ab8721d90007c689f887d315c926a267~8iJY5rwk11659116591eucas1p1V;
 Wed, 23 Jan 2019 16:55:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190123165550eusmtrp1bc9b197397d15b335c8313f9568f3d17~8iJYq8_nf0321203212eusmtrp1K;
 Wed, 23 Jan 2019 16:55:50 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-82-5c489c973bd5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 78.32.04284.69C984C5; Wed, 23
 Jan 2019 16:55:50 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190123165549eusmtip1b5c1646435565180271e97619785c5cb~8iJYE9P840754507545eusmtip14;
 Wed, 23 Jan 2019 16:55:49 +0000 (GMT)
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
To: k.konieczny@partner.samsung.com
Subject: [PATCH v2 1/3] arm64: dts: exynos: add SlimSSS for Exynos5433
Date: Wed, 23 Jan 2019 17:55:31 +0100
Message-Id: <20190123165533.29645-2-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190123165533.29645-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7rT53jEGNyYzWuxccZ6Vov5R86x
 WvTt+89o0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl91i6fWLTBate4+wO3B7rJm3
 htFj06pONo/NS+o9Dr7bw+TRt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGfOm72Is6OeoaL26
 iLWB8SlbFyMnh4SAicTqO1vZuxi5OIQEVjBKrLz0hRXC+cIocfbKNKjMZ6DMh/3sMC3LV15k
 BbGFBJYzSjzbbwzXce36NxaQBJuAucSj7WeYQGwRAWWJyfemM4MUMQv8Z5JYeGcJ2HJhATeJ
 l5dBpnJwsAioSixeyAcS5hVwkdjz9gsLxDJ5iWmru5hASjgFXCU6f4VBlAhKnJz5BKyEGaik
 eetssPESAtvYJT6saGCF6HWR2D+3BcoWlnh1fAvUAzISpyf3QM0vl9i99Rk7RHMLo8TcyYuY
 IBLWEoePg3zJAbRBU2L9Ln0QU0LAUaLpWwmEySdx460gxAl8EpO2gXwIEuaV6GgTgpihKzHv
 /xmoA6Qluv6vg7I9JJq71rFMYFScheSZWUiemYWwdgEj8ypG8dTS4tz01GLjvNRyveLE3OLS
 vHS95PzcTYzAtHT63/GvOxj3/Uk6xCjAwajEw7shzyNGiDWxrLgy9xCjBAezkgiv60W3GCHe
 lMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2MKpZFb60tPRfl
 ThbUuXrwF2dKs9Ce+M2zX84TneXUeJnvw/7/wuxaHNdeZk/Pl6rZFjnfPHC79fa01/FbZkfI
 M+V7M3iKdEnPOr333dUn1vfN+r5tS7a1evCAOWiuoeBBb81pzvHTr9ZkL9gQb+ATuP/d0cs+
 L7/9idqrFhTXw//a5wuzxitzJZbijERDLeai4kQATru5mEcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7rT5njEGLReFrfYOGM9q8X8I+dY
 Lfr2/We06H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26x9PpFJovWvUfYHbg91sxb
 w+ixaVUnm8fmJfUeB9/tYfLo27KK0ePzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
 Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jHnTdzEW9HNUtF5dxNrA+JSti5GTQ0LARGL5yous
 XYxcHEICSxklTq75wQ6RkJZoPL2aCcIWlvhzrYsNougTo8TjLcvAitgEzCUebT8DViQioCwx
 +d50ZpAiZoF2Zok1u7eBrRAWcJN4eXk/UAMHB4uAqsTihXwgYV4BF4k9b7+wQCyQl5i2uosJ
 pIRTwFWi81cYSFgIqOT5gS+sEOWCEidnPgErZwYqb946m3kCo8AsJKlZSFILGJlWMYqklhbn
 pucWG+oVJ+YWl+al6yXn525iBMbQtmM/N+9gvLQx+BCjAAejEg/vhjyPGCHWxLLiytxDjBIc
 zEoivK4X3WKEeFMSK6tSi/Lji0pzUosPMZoCvTCRWUo0OR8Y33kl8YamhuYWlobmxubGZhZK
 4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhh1V5fce1I4vTuJ7yl32affN2btOlrZy2T1YGIc
 Q2aICrfpTE8PN96OV4dErscu360ZYSeUdGvP2mkn/A0EOGXzRNUnrGLXM6xJ/MB7pMBoQmjW
 lzdrP9WyGd2u2mDf3KdwsCv+hE6i0D/GZRqbFBe63Vx4s6jxZuFc3ttG/luv1190nb/KRVyJ
 pTgj0VCLuag4EQB8ujhdtwIAAA==
X-CMS-MailID: 20190123165550eucas1p1ab8721d90007c689f887d315c926a267
X-Msg-Generator: CA
X-RootMTR: 20190123165550eucas1p1ab8721d90007c689f887d315c926a267
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190123165550eucas1p1ab8721d90007c689f887d315c926a267
References: <20190123165533.29645-1-k.konieczny@partner.samsung.com>
 <CGME20190123165550eucas1p1ab8721d90007c689f887d315c926a267@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_085557_504535_88792E7F 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add DT node for SlimSSS (aka Slim SecuritySubSystem) in Exynos5433 SoC.
The users can use compatibility "samsung,exynos5433-slim-sss".

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index e7cd3b67d818..9e5fcb6c7776 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -559,6 +559,15 @@
 				<&cmu_top CLK_DIV_ACLK_IMEM_200>;
 		};
 
+		slim_sss: slim-sss@11140000 {
+			compatible = "samsung,exynos5433-slim-sss";
+			reg = <0x11140000 0x1000>;
+			interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_imem CLK_ACLK_SLIMSSS>,
+				 <&cmu_imem CLK_PCLK_SLIMSSS>;
+		};
+
 		pd_gscl: power-domain@105c4000 {
 			compatible = "samsung,exynos5433-pd";
 			reg = <0x105c4000 0x20>;
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
