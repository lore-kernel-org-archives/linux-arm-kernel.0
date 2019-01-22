Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492FEC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA63217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dQECCyQc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jIpmGcO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA63217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FuNnGAmQ+J72vD9mXPt79KPzOcifdgVCO97XkFjIq/U=; b=dQECCyQcT5crWQ
	N0zbn8hHQrdiK4/Th2DJUaid3Z+PF3Arx4CUYoDZPMukFQTONSXkAJmeHRjoiiOySCledgP7hH6va
	kFLWL59QBGUDAZAiAqXnR6O9+g9D64sCPhI3ycR0Mo+womHl4zMHS8j9FixHilGB4m9/Uq/inFaFA
	BjwKsRl7phDRCB+KIzX/w+S3vKBCk2sAXOIqb1Boz5iraWHGKleRgiXBjbXSj9wln/JdmGfAjdfRZ
	WZBQZUkGmXaPKuZ0x5SbEF6rIEpbavrvIlRoXuKBIorUqyXK1wIxVNZYpXim7jd209VUaMbFCJwBz
	cng69DwqkmeP39vNPxVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxwW-0006zR-T2; Tue, 22 Jan 2019 15:26:24 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxwK-0006ok-1X
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 15:26:13 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190122152609euoutp02f6559132203a9bf110043946ec2b803b~8NRzTpQNh2913729137euoutp02_
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 15:26:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190122152609euoutp02f6559132203a9bf110043946ec2b803b~8NRzTpQNh2913729137euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548170769;
 bh=PzMg4GV1XDi6Y5SAe2HJT0Zvt3QmVJ+RidOcaZENDo4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jIpmGcO1uPHy/45/TYRufXJg19oShxlcbt3CiMnUQBChD83eCzRGBNXzu5AVoT58d
 o/8e+GQ+V5ODU8Cftl6VY7KsxDWra+EznNyExjEkZV1yOnh3L0h16DxW10UtkmAqga
 4j9xNt4fYIdkPUC1FYKt0ZEHMeoPPnQLBQgMe4gA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190122152609eucas1p103a9a571fc41292b09fde7fa3aea0051~8NRy10WV20988509885eucas1p1B;
 Tue, 22 Jan 2019 15:26:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.69.04294.016374C5; Tue, 22
 Jan 2019 15:26:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190122152608eucas1p298d06d6b1232a37be8c1679b7a626811~8NRyCKGhr1516415164eucas1p2q;
 Tue, 22 Jan 2019 15:26:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190122152608eusmtrp2b595d28960f2e91462f7dc6a187ae25a~8NRxzLEdf0539205392eusmtrp2U;
 Tue, 22 Jan 2019 15:26:08 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-e4-5c4736106842
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.89.04284.016374C5; Tue, 22
 Jan 2019 15:26:08 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190122152607eusmtip26678e806b1a425d762ce8cf308001c7a~8NRxQ2SVb0472704727eusmtip27;
 Tue, 22 Jan 2019 15:26:07 +0000 (GMT)
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
To: k.konieczny@partner.samsung.com
Subject: [PATCH v1 1/3] arm64: dts: exynos: add SlimSSS for Exynos5433
Date: Tue, 22 Jan 2019 16:25:51 +0100
Message-Id: <20190122152553.1537-2-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190122152553.1537-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87oCZu4xBv+eWVpsnLGe1WL+kXOs
 Fn37/jNa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYev0ik0Xr3iPsDtwea+at
 YfTYtKqTzWPzknqPg+/2MHn0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxrzpuxgL+jkqWq8u
 Ym1gfMrWxcjJISFgInHl62XWLkYuDiGBFYwSEzqmMoEkhAS+MErcfGsOkfjMKDG99wArTMf8
 Z6tZIBLLGSX+HTjPDOEAdXx91g/WziZgLvFo+xkwW0RAWWLyvelgRcwC/5kkFt5ZArScg0NY
 wE2i+2IOSA2LgKrE9U1rwep5BZwl/r3uZ4bYJi8xbXUXWJxTwEXi/KlVrBA1ghInZz5hAbGZ
 gWqat84Gmy8hsIld4mnbArD5EkANN47UQMwRlnh1fAs7hC0j8X/nfCYIu1xi99Zn7BC9LYwS
 cycvgkpYSxw+fpEVZA6zgKbE+l36EGFHiRWbZzJCjOeTuPFWEOIEPolJ20BeBAnzSnS0CUFU
 60rM+38GGm7SEl3/10HZHhK7rx5gmsCoOAvJM7OQPDMLYe8CRuZVjOKppcW56anFRnmp5XrF
 ibnFpXnpesn5uZsYgYnp9L/jX3Yw7vqTdIhRgINRiYc34YJrjBBrYllxZe4hRgkOZiURXteL
 bjFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGKMj3x9r
 +HOi+W+niuuzuNDmPQERd7lb5qtEqs1dwyJkyFfCV1uSWrj3ydUGdZYpv5ZHfjn86g9/8drl
 f5f94bbvtWZ502DQ1rfgjpqrYJ7TPV+7lMdTovcc0WS3UV1wNTZJ60dt1Xb778KqG/XNeKfL
 Xi/bs9bn/pfo3if+UVd1WaMsr5znVWIpzkg01GIuKk4EAEbUAAhIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7oCZu4xBmcfcFlsnLGe1WL+kXOs
 Fn37/jNa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYev0ik0Xr3iPsDtwea+at
 YfTYtKqTzWPzknqPg+/2MHn0bVnF6PF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
 pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrzpuxgL+jkqWq8uYm1gfMrWxcjJISFgIjH/2WqW
 LkYuDiGBpYwSK+f9YYJISEs0nl4NZQtL/LnWxQZR9IlR4sXCY2DdbALmEo+2nwErEhFQlph8
 bzozSBGzQDuzxJrd24CKODiEBdwkui/mgNSwCKhKXN+0FqyeV8BZ4t/rfmaIBfIS01Z3gcU5
 BVwkzp9axQpiCwHVPJ4whxWiXlDi5MwnLCA2M1B989bZzBMYBWYhSc1CklrAyLSKUSS1tDg3
 PbfYUK84Mbe4NC9dLzk/dxMjMIq2Hfu5eQfjpY3BhxgFOBiVeHg5zrnGCLEmlhVX5h5ilOBg
 VhLhdb3oFiPEm5JYWZValB9fVJqTWnyI0RToiYnMUqLJ+cAIzyuJNzQ1NLewNDQ3Njc2s1AS
 5z1vUBklJJCeWJKanZpakFoE08fEwSnVwDi5q3o976O5ilbLhfcm7l975V3v9yW+ZQ6x/Mmq
 ks3u2yt83iypNTxlxfjxXf5ylUKjpwcMwpp6En6xKlqebpBVD68O2yB0e87sBzPXFjjJOa+S
 b0wolH9Q9ELae9azvVFln9Lu7vDXfmhXFfNQmuuJZfCD4LqX8x+rmT8LvzdlbfJzDhaZhUos
 xRmJhlrMRcWJAH8RkzG4AgAA
X-CMS-MailID: 20190122152608eucas1p298d06d6b1232a37be8c1679b7a626811
X-Msg-Generator: CA
X-RootMTR: 20190122152608eucas1p298d06d6b1232a37be8c1679b7a626811
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190122152608eucas1p298d06d6b1232a37be8c1679b7a626811
References: <20190122152553.1537-1-k.konieczny@partner.samsung.com>
 <CGME20190122152608eucas1p298d06d6b1232a37be8c1679b7a626811@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_072612_214833_3B2E3FF1 
X-CRM114-Status: GOOD (  12.18  )
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
