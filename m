Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B16C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:09:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67ECC2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DwbgX5bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67ECC2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8AE43xckQf2fVIQJVlRb3+pQEEsw5DX8pnlZLiUY2is=; b=DwbgX5bSVUCzev
	m7lipYNRD3Fvdv5PCkEdkRpAzf4JsSQSKWRU2sprzT+9qMEgeQ6tkCRtW7B4aK+a4o91scQmFwrae
	JhTFFy8yjYXby8IfOxZBeLkhAXTXF3Bpzc4P5TmKt/9Qk7Tf9ZgBlmSH1wxm6cy9cu6WmPfPDwoby
	YyuzGcTgggW2kKgcaFaH1PqZTLURZ/vvbEmoJkY/cFmnJ0zHEeyok3yGjdRHD5FKu42lShHIulOsG
	/2f+1DgTfam+ff7Ul1lP/cZvX2nKY/UN/WtyBnofvtOKK+OvEUus3j0cRiHFuDsdMQ8Be29bpqNVU
	jQtdx62PGIR1Nc1r4l3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gty2D-0008Gb-PI; Wed, 13 Feb 2019 17:09:21 +0000
Received: from relay1.mentorg.com ([192.94.38.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gty21-00083U-Di; Wed, 13 Feb 2019 17:09:20 +0000
Received: from nat-ies.mentorg.com ([192.94.31.2]
 helo=SVR-IES-MBX-04.mgc.mentorg.com)
 by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
 id 1gty20-00047V-KU from Akash_Gajjar@mentor.com ;
 Wed, 13 Feb 2019 09:09:08 -0800
Received: from eyas.local (137.202.0.90) by SVR-IES-MBX-04.mgc.mentorg.com
 (139.181.222.4) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 13 Feb
 2019 17:09:02 +0000
From: Akash Gajjar <Akash_Gajjar@mentor.com>
To: <heiko@sntech.de>
Subject: [PATCH 2/4] arm64: dts: rockchip: rockpro64 dts remove unused node
Date: Wed, 13 Feb 2019 22:36:38 +0530
Message-ID: <20190213170651.3210-3-Akash_Gajjar@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_090909_972583_999424C5 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shohei Maruyama <cheat.sc.linux@outlook.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 Levin Du <djw@t-chip.com.cn>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

lcd panel pinmux and vcc1v8_s3 regulator is redundant and has a no impact, so
removing it.

Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
---
 .../boot/dts/rockchip/rk3399-rockpro64.dts    | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
index 49e83ba64045..c9a2b26d7cad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -83,17 +83,6 @@
 		regulator-max-microvolt = <12000000>;
 	};
 
-	/* switched by pmic_sleep */
-	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc1v8_s3";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_1v8>;
-	};
-
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -522,12 +511,6 @@
 		};
 	};
 
-	lcd-panel {
-		lcd_panel_reset: lcd-panel-reset {
-			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
 	pcie {
 		pcie_pwr_en: pcie-pwr-en {
 			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -576,7 +559,7 @@
 };
 
 &saradc {
-	vref-supply = <&vcca1v8_s3>;
+	vref-supply = <&vcca_1v8>;
 	status = "okay";
 };
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
