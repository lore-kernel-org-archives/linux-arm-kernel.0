Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843A4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:32:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFB92184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wud4j31u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="CdJp/S4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFB92184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ypNvdwnGh4aOXmSAngevUq5M0CxoaLSifIEH3qX1Yug=; b=Wud4j31uuYcDbKBf1lDFPhKQIQ
	NJAkl45l3ZS+XBBsVZq0NvFP5QfnOOb0xb/MtBxJcX71wCzcgI+J0pDRVjOHu+idZvPrOaBaOx1ON
	vadvYIWJVF4w4J20w4SCidWdbloaFEwIKgXnf6H0kx6BoZRd2pjrVar7jWpvZnWJFn7TWWoV8UFWg
	Vvgs8SwrfbASXwMrzC3ySWv9ontp6Vbnf8cji6Na0aDfhZvTtcpbwqhWxnAh0WJkIiydIVEEKxJ2B
	CpFiPDgF2dox0BSJAJB/8057f0lufnUIJDLd8NvkTrC3ZhUVgCP+DhNTsvcWFVLtJqaN0SmHoT5lp
	7/8Rdlxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb6fo-0001PT-06; Sun, 23 Dec 2018 16:32:16 +0000
Received: from smtp34.i.mail.ru ([94.100.177.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb6fa-0001GU-Vv
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 16:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=2RSQ49SEGGc3KC/wrY1KOTK/dhCKJ4YAF2DsJqRAeGs=; 
 b=CdJp/S4ejVYLIJeHSq68fJyEbPpvZ7DIHWiZ2vjBYpAG5RS/eadydkvpuD20ZtmriP/qCW3666sStnnFCa1dzocpG5zTvgGEb4XZ3lnPbJwrl6idkSeTGLyhKHVOKSA3RiU0E8TR+6MgwIsyMYRJbA85uOBfX1LmMJg7PTEy1Aw=;
Received: by smtp34.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gb6fN-00087P-4N; Sun, 23 Dec 2018 19:31:49 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] ARM: dts: imx6qdl-phytec-pfla02: Replace magic numbers
Date: Sun, 23 Dec 2018 19:31:40 +0300
Message-Id: <20181223163141.6792-3-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20181223163141.6792-1-shc_work@mail.ru>
References: <20181223163141.6792-1-shc_work@mail.ru>
Authentication-Results: smtp34.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: CF41D5CA8C6D3C0C7F9F52485CB584D75945EECDF71DA5B3553F005E15258411F8E8DF9CDF6896AABF272550A167E03324DAF05A372A3159
X-7FA49CB5: 0D63561A33F958A51AC0876731F395BAAE58B855DBA0FAC13F2D4DDEB3110AC58941B15DA834481FA18204E546F3947C0839144E5BB460BAF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B55B19328CBC4F849A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249DA33821E755670D83AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE72CE3825EE585899DCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE781A3AA7CEF54F56589DDD9F30790B09DEFF80C71ABB335746BA297DBC24807EA27F269C8F02392CD20465B3A5AADEC6827F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445223CBA05F7F71A499FF4AA860F84897EAD5E2D065CC703566B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_083203_402680_A05424F2 
X-CRM114-Status: GOOD (  10.71  )
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
Cc: Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use GPIO_ACTIVE_LOW/HIGH for GPIO description.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 211640e..81007d6 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -23,7 +23,7 @@
 			regulator-name = "usb_otg_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio4 15 0>;
+			gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 
@@ -33,7 +33,7 @@
 			regulator-name = "usb_h1_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio1 0 0>;
+			gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 	};
@@ -43,12 +43,12 @@
 
 		green {
 			label = "phyflex:green";
-			gpios = <&gpio1 30 0>;
+			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
 		};
 
 		red {
 			label = "phyflex:red";
-			gpios = <&gpio2 31 0>;
+			gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
@@ -69,7 +69,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3>;
 	status = "okay";
-	cs-gpios = <&gpio4 24 0>;
+	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
 
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor";
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
