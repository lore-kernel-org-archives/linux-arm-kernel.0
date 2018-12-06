Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89755C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:17:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0837D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gSGjKVMS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E/yjaR2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0837D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Message-id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:List-Owner; bh=KxWEIBqL+PrN53zx4phlUsndwfzbVd8z82p0S1WYJf4=; b=gS
	GjKVMSS+flUnjc+f4j0JGJ9CRBTE4OwV/7u+hOK0GIh8vuNmCAsiCzpjFaBKZpRqOz/FT7IiSczFx
	EzXC/SX+PzoGx+b3DvWgRidMwHkmOF+WErWR5gprZX5Kji4DJxPWE+4u0K9D4e5Hn9lSDlgzw4Rbu
	7BBk+Ax54t3t1Fzii7ONG7cXif2/DFNpxv65tEWlPaAbIcUEL/wg/4KUiRCldDyK9dXexFqGFBZJ+
	/dKML5PaB0umgAtw6xywwZWODuvS0n5yHyrSpFo3NT/1xW3scCAYBuWXd0GFN0IG3YaUYFaYsk8I9
	TYfCnYQp6eiYAHnQ2pQ7aBuEXlA5pqhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuSa-0002ca-1G; Thu, 06 Dec 2018 14:17:00 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuSW-0002c7-E5
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:16:58 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181206141640euoutp02f367654d4a3ca23c7528f1d027fcad99~txAtTfsAS1708017080euoutp02-;
 Thu,  6 Dec 2018 14:16:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181206141640euoutp02f367654d4a3ca23c7528f1d027fcad99~txAtTfsAS1708017080euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544105800;
 bh=BdKzEUkoK/qd7CThRPmWpnxVY4WDOQw+iKe+TH1H3VA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=E/yjaR2Z2ye70UqcR9BTFqBN+TDAAKt+Vt/ixDs/2JMabaeEMYAdOdFJeonzHs3xD
 Idm2MVtetZ01FitQ+rBCZc/R++UnehS31EED3AiIHSVyspbuf4kxY45NZLDcExuZo4
 2xFuPKQB3PXmeV22Ad8jmahlGOn8902pNRb0crQk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181206141639eucas1p186b3b3c40eac353f46492f3f42ccebcc~txAsnoaBD2221522215eucas1p1Z;
 Thu,  6 Dec 2018 14:16:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 84.4E.04294.74F290C5; Thu,  6
 Dec 2018 14:16:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181206141638eucas1p17743a2bf7d02fce13825007938e07340~txAr_oRdz2401324013eucas1p1W;
 Thu,  6 Dec 2018 14:16:38 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-64-5c092f47c9eb
Received: from eusync1.samsung.com ( [203.254.199.211]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id AA.24.04284.64F290C5; Thu,  6
 Dec 2018 14:16:38 +0000 (GMT)
Received: from AMDC3748.DIGITAL.local ([106.120.43.17]) by
 eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PJB00I6BJNPTL50@eusync1.samsung.com>;
 Thu, 06 Dec 2018 14:16:38 +0000 (GMT)
From: Andrzej Hajda <a.hajda@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] ARM: dts: exynos: remove display-port node from Arndale
Date: Thu, 06 Dec 2018 15:16:35 +0100
Message-id: <20181206141635.15610-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7djPc7ru+pwxBtum8VjcWneO1WLjjPWs
 FvOPAFnnz29gt9j0+BqrxYzz+5gs1h65y+7A7rFpVSebx+Yl9R59W1YxenzeJBfAEsVlk5Ka
 k1mWWqRvl8CV8WfCYbaCHs6KryffsDQwzmPvYuTkkBAwkbj59BdbFyMXh5DACkaJGe93MkI4
 nxkllu+YzQRT9efNGWaIxDJGicmTlrJAOP8ZJfr69oBVsQloSvzdfJMNxBYBsq///c4KUsQs
 8JVR4u67KawgCWEBD4mOmVMYQWwWAVWJN0dngB3CK2AhseteEyPEOnmJ1RsOgK2TEHjIKnG9
 aR9UwkVi9vwOZghbWOLV8S1QX8hIdHYchLq1XqJp5hWo5g5GiROLl7NBJKwlDh+/CHYFswCf
 xKRt04GKOIDivBIdbUIQJR4S20+sB5spJBAr8ezNAqYJjBILGBlWMYqnlhbnpqcWG+WllusV
 J+YWl+al6yXn525iBMbX6X/Hv+xg3PUn6RCjAAejEg/viwfsMUKsiWXFlbmHGCU4mJVEeBn0
 OGKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MM59tPOW
 0RfxjxasXO/4V/z/GiD91u8yc1Z7xM7259I/XDcLpj6rmzBZs9hRcPrfHzn1Wl/rkl9tzrL5
 E6G/bjUH22xDhZrp75/fyMyat0zhjtREsdnPH6n0Tpl8ce7p5MOBRoeWW+q8Z61VX/FiodGF
 O1tXv+RSChF3KZQNn+RyOlCpLHlimbYSS3FGoqEWc1FxIgC7jLh4qwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJMWRmVeSWpSXmKPExsVy+t/xy7pu+pwxBrcXS1vcWneO1WLjjPWs
 FvOPAFnnz29gt9j0+BqrxYzz+5gs1h65y+7A7rFpVSebx+Yl9R59W1YxenzeJBfAEsVlk5Ka
 k1mWWqRvl8CV8WfCYbaCHs6KryffsDQwzmPvYuTkkBAwkfjz5gxzFyMXh5DAEkaJefPvskA4
 jUwSS7Y3soFUsQloSvzdfBPMFgGyr//9zgpSxCzwnVHi1OpeFpCEsICHRMfMKYwgNouAqsSb
 ozPAVvAKWEjsutfECLFOXmL1hgPMExi5FjAyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAgM
 gW3Hfm7ewXhpY/AhRgEORiUe3hcP2GOEWBPLiitzDzFKcDArifAy6HHECPGmJFZWpRblxxeV
 5qQWH2KU5mBREuc9b1AZJSSQnliSmp2aWpBaBJNl4uCUamDsDej6YXBPWyli7fOq+wUXPnp9
 i+P85/dIcJGAoslMl81yx+rPe956J/10w/65ia68P1IMXW8+y1Co7fTj2FOzdhfXJIMFRc8e
 r/56Ua8y0P7Sco6k4th6uVM7r0m/Kf76YFkiR4HSJoXT/F75wu8sjbznXC7sODotNu+KluOs
 5/mbD2bt3f9SiaU4I9FQi7moOBEA31CKvP0BAAA=
X-CMS-MailID: 20181206141638eucas1p17743a2bf7d02fce13825007938e07340
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181206141638eucas1p17743a2bf7d02fce13825007938e07340
References: <CGME20181206141638eucas1p17743a2bf7d02fce13825007938e07340@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_061656_787130_D8EBBD6A 
X-CRM114-Status: GOOD (  11.60  )
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
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Andrzej Hajda <a.hajda@samsung.com>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Arndale boards have wires for DSI and eDP panels, but in-kernel support
for eDP panels is broken for long time and breaks display support even on
boards with DSI panels.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 25 ------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index e2e5b3f28686..2ca9319f48f2 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -181,31 +181,6 @@
 	};
 };
 
-&dp {
-	status = "okay";
-	samsung,color-space = <0>;
-	samsung,color-depth = <1>;
-	samsung,link-rate = <0x0a>;
-	samsung,lane-count = <4>;
-
-	display-timings {
-		native-mode = <&timing0>;
-
-		timing0: timing {
-			/* 2560x1600 DP panel */
-			clock-frequency = <50000>;
-			hactive = <2560>;
-			vactive = <1600>;
-			hfront-porch = <48>;
-			hback-porch = <80>;
-			hsync-len = <32>;
-			vback-porch = <16>;
-			vfront-porch = <8>;
-			vsync-len = <6>;
-		};
-	};
-};
-
 &fimd {
 	status = "okay";
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
