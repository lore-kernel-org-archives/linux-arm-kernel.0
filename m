Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F09C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:46:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5635521872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q61Hc8Tv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RwTzTyir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5635521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FuNnGAmQ+J72vD9mXPt79KPzOcifdgVCO97XkFjIq/U=; b=Q61Hc8TvoIPnUZ
	egrs/7GgUkm0kGlO1gdZ1zQFILuBjWUISjDeWfLJyhB3yQA8yPGWaygLYC0cFy0tL1JMNNRpqUsZ/
	hBUa2/iW65uJI9jEOqxsJmYrBePoaVkudOXKeBUJPcUDoGsFCXcC15RYYvAcQ8aNyyaJhTPZvPddH
	qBFBpov+5RLKh8I/Akzy3pj9FP+mZU7zISYZw79zpm7uIU0Vzj0ShKk02a2/RMAWEvMOcj+4O/2K3
	4Pm8bA5IBOlZBu5ifEPcc1K7q5cY+IoYq8ZUBRoxEg8WyOgzRNIAD40mNSCrUbSQyLeUtdDt9pGf8
	FGYjucMNCRjiCwF6dEVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmhCX-0000p9-2R; Thu, 24 Jan 2019 15:45:57 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhCI-0000dY-VG
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:45:45 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190124154540euoutp01a59a98baa918220020e5b797fd61ff47~801Z90DwF2679626796euoutp01L
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 15:45:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190124154540euoutp01a59a98baa918220020e5b797fd61ff47~801Z90DwF2679626796euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548344740;
 bh=PzMg4GV1XDi6Y5SAe2HJT0Zvt3QmVJ+RidOcaZENDo4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RwTzTyirfyeAfbVWUkiVSEV/nFSW7shTHJ37uwP+8qUr/zL62WN9UwStH6zu9i7Wn
 x4d4ChJgtFNimI28/U7D4O6s+wLLe2qxq6smZh6fyakSXsLyIqdZv4VgBMRMFWeJ/R
 HSKincZpANhSvQJy9nWa8i3O+xy6rpC6zloGI6go=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190124154539eucas1p1dbf6c93dca26dc85f023df86cb467229~801ZWGLAd1368013680eucas1p1V;
 Thu, 24 Jan 2019 15:45:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 49.31.04806.3ADD94C5; Thu, 24
 Jan 2019 15:45:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7~801YlMxaD0349803498eucas1p2c;
 Thu, 24 Jan 2019 15:45:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190124154538eusmtrp26496d38667cad7a9a33d0476054bc169~801YWj5ga1826018260eusmtrp2q;
 Thu, 24 Jan 2019 15:45:38 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-e6-5c49dda367bf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.59.04284.2ADD94C5; Thu, 24
 Jan 2019 15:45:38 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190124154537eusmtip22c457d4332a782cda8616e044cae4f91~801XndraN2489624896eusmtip2X;
 Thu, 24 Jan 2019 15:45:37 +0000 (GMT)
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
To: k.konieczny@partner.samsung.com
Subject: [PATCH v3 1/3] arm64: dts: exynos: add SlimSSS for Exynos5433
Date: Thu, 24 Jan 2019 16:45:19 +0100
Message-Id: <20190124154521.13589-2-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190124154521.13589-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87qL73rGGLTOEbHYOGM9q8X8I+dY
 Lfr2/We06H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26x9PpFJovWvUfYHbg91sxb
 w+ixaVUnm8fmJfUeB9/tYfLo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujHnTdzEW9HNUtF5d
 xNrA+JSti5GTQ0LARGL90r3MXYxcHEICKxglnv26AuV8YZRYvnQqI4TzmVGi78pudpiWebNe
 Q1UtZ5RYcPIQO1zLw01HwAazCZhLPNp+hgnEFhFQlph8bzpYB7PAfyaJhXeWgBUJC7hJ3L91
 ixXEZhFQldh6/gXQJA4OXgEXiecHOCC2yUtMW90FNodTwFVi74RmFhCbV0BQ4uTMJ2A2M1BN
 89bZYPMlBDaxS2x51MAK0ewicXzGRxYIW1ji1fEtUC/ISPzfOZ8Jwi6X2L31GTtEcwujxNzJ
 i6AS1hKHj19kBTmIWUBTYv0ufYiwo0T7ghNsIGEJAT6JG28FIW7gk5i0DeRHkDCvREebEES1
 rsS8/2egrpGW6Pq/Dsr2kFh18h/LBEbFWUi+mYXkm1kIexcwMq9iFE8tLc5NTy02zkst1ytO
 zC0uzUvXS87P3cQITE6n/x3/uoNx35+kQ4wCHIxKPLwdhzxjhFgTy4orcw8xSnAwK4nwul50
 ixHiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXA6ByWt2Lu
 T52vlzWZTvdXp2WvVL6UXiq5far116u2r3flVHvE/E4vW+D8w3S+btzLP7unGAsuU3M+fKf0
 VL7tal4R3m7LqZfY/y39ruwWm76FVemTwlmjBtmTv1LXhEduXcl2RfFibFxWYeuFr5y3d//X
 Tp2XV53B/YYr3rxrvt+JRnmt2fXflViKMxINtZiLihMBmt8PaUoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7qL7nrGGDzcqGSxccZ6Vov5R86x
 WvTt+89o0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl91i6fWLTBate4+wO3B7rJm3
 htFj06pONo/NS+o9Dr7bw+TRt2UVo8fnTXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYm
 lnqGxuaxVkamSvp2NimpOZllqUX6dgl6GfOm72Is6OeoaL26iLWB8SlbFyMnh4SAicS8Wa+Z
 uxi5OIQEljJKdPWtYIVISEs0nl7NBGELS/y51sUGUfSJUeLul5NgCTYBc4lH28+A2SICyhKT
 700Hm8Qs0M4ssWb3NrAVwgJuEvdv3QKbyiKgKrH1/Av2LkYODl4BF4nnBzggFshLTFvdBTaH
 U8BVYu+EZhYQWwioZO63WWBjeAUEJU7OfAIWZwaqb946m3kCo8AsJKlZSFILGJlWMYqklhbn
 pucWG+oVJ+YWl+al6yXn525iBEbRtmM/N+9gvLQx+BCjAAejEg9vxyHPGCHWxLLiytxDjBIc
 zEoivK4X3WKEeFMSK6tSi/Lji0pzUosPMZoC/TCRWUo0OR8Y4Xkl8YamhuYWlobmxubGZhZK
 4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhgDd1j+4SueFfS9PpXJUkDMdfXitmsclm8dLByn
 S7L0Taj42zhBcOuJ/k61BVHpiam8+zskmLPU8u+Wr5uhktYm13GIeXdDy9X2+x9XbDPjL+8+
 wH3vvuPTS62tGwMEfHc81S35uKx9EqvZm4Uqyozq84N3Hbgsydn4NWOOYNOS15ccc8u8jJVY
 ijMSDbWYi4oTAbTScbS4AgAA
X-CMS-MailID: 20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7
X-Msg-Generator: CA
X-RootMTR: 20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7
References: <20190124154521.13589-1-k.konieczny@partner.samsung.com>
 <CGME20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_074543_302944_17F50B3D 
X-CRM114-Status: GOOD (  11.94  )
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
