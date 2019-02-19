Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5209C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9656120823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rbV1xYhZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="vODLDL71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9656120823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X5bqww/byAz1uw0aVA+4lalOd12EWm3WtgiwJvKdl8g=; b=rbV1xYhZBxwQB8
	VpyBsJVdXyk2GI01OA7VJY0KqLN0EHns5Y1VpD6sxeAl076/O43wjTX4JnSjpVMqkYh7khhOsNiQd
	jjVaWjSPODsstHdjNDjRLlNpPy8JKjs67rzA5SSrj5XsLR0vaA0OBIHmmdOG3QGCWlwn5T4B8Q6SF
	1SOmuCvrz/t7SNeTc1gsqAtnNJMCEqNeUjli1WUBZaPthKSrmRw+o73Wrk10+vst2bN1eLDvvOYI4
	55PqXW+0SEE7zHrmkP6fz12+CKRAFKuk7L2cTe17UyUFiI4VmOWptLYE5HLAuAisJ7w8aKiXteics
	TDaB6ilRKzS22FFcK9bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw53r-00052x-PD; Tue, 19 Feb 2019 13:03:47 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw53o-0004zA-83
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 13:03:45 +0000
Received: by mail-wr1-x441.google.com with SMTP id d17so7457411wre.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 05:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=LbMWZVugHEDDl6B6kVACz748pwTAoghLveLfYXT/bz4=;
 b=vODLDL71oqbgI5RJ82lTdYcsU7rdCYlZN2Y/PNrUH7G1RB/itFSgKmWF2j4+63fHnl
 nuslTo6bGLfS2W+9NBuoEt6l9+DL+UzbR8MmzlFHmHq3WDoOvjAyts4lqhZ6Kin3Dist
 DVgrnn1G88iZKM4YTon9LfdOtaXlQihvUcj8aXhwe9wPwDf6sJJifhOju7dsegZX60Vd
 +nM3TQG9bR2+ZOunyfcsa5Fs5AgdCd9j3CQtMHvSnrLpD7nRq4SbBjxHOZj9Cea7H/qI
 PRZV3awFJCyMh+sN8sM293tvSdkNRCqUS+STzTLweuPp0STxarVsdjjg72qy5MQf/Epb
 UDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=LbMWZVugHEDDl6B6kVACz748pwTAoghLveLfYXT/bz4=;
 b=NHarsOC+AxVwYlsyde/sfktt0FFnXNe9x7IX3s8btBQEabZYM7KTi30St9Ok6A3uYa
 YMYc6eFgUjpc4WgQpRHKtO9k+pp1DMpwJM23u7rC+kELxBEvA5JCmkBJy0mvYTh2UJmd
 kO5DJrt6exFGN7l2gXf4qyGj0rJl5gKkIIb6+GATF3h1HHdB0GX5zzai18s6QJgPPRGx
 O7KsbULo7pdDBuOpIJNRVbWRrTNCouSl6NPMRTypE/+T18sJsyxLKsGczBvowzNuXNZs
 Z5ND/+uRqdttHJM7Dms2JVhW9ls95F5Nks7reSeiyN7CrRjH5iPfpDCN8OOz2cAl9xpw
 8isA==
X-Gm-Message-State: AHQUAuY8kHCR/WcmVCwEsogyWLkqYQEk2Tt5AtNDNP5AHXC9G21sGNOd
 tMvvCPkg1WtBr63qE38UF7v/gg==
X-Google-Smtp-Source: AHgI3IZdJMw9NzriD/8qRpvqfCu1suufsqr2zsVvvPz39toDMwdi0FYjyO3QJSWzMFUH4/BQ0wctcA==
X-Received: by 2002:a5d:4686:: with SMTP id u6mr21557468wrq.206.1550581422617; 
 Tue, 19 Feb 2019 05:03:42 -0800 (PST)
Received: from diamond.mathembedded.com
 (host86-137-106-133.range86-137.btcentralplus.com. [86.137.106.133])
 by smtp.gmail.com with ESMTPSA id y22sm61899811wrd.45.2019.02.19.05.03.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 05:03:41 -0800 (PST)
From: Stuart Menefy <stuart.menefy@mathembedded.com>
X-Google-Original-From: Stuart Menefy <stuart@menefy.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: exynos: Add high speed I2C ports for
 exynos5260
Date: Tue, 19 Feb 2019 13:03:35 +0000
Message-Id: <20190219130337.21353-3-stuart@menefy.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190219130337.21353-1-stuart@menefy.org>
References: <20190219130337.21353-1-stuart@menefy.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_050344_311092_2033836D 
X-CRM114-Status: GOOD (  16.65  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

Most of the work to support the high speed I2C ports on the Exynos 5260
was added in commit 218e1496135e ("i2c: exynos5: add support for HSI2C
on Exynos5260 SoC") and the pinctrl nodes have always been available.
All that is missing to get them working is the additon of the DT bindings.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---

Changes since v1:
- Removed unused attribute: samsung,check-transdone-int
- Reordered additions so they now appear in address order
- Changed hex addresses to lower case

 arch/arm/boot/dts/exynos5260.dtsi | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 14b423de9137..a8c7c6e589a0 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -17,6 +17,10 @@
 	#size-cells = <1>;
 
 	aliases {
+		i2c0 = &hsi2c_0;
+		i2c1 = &hsi2c_1;
+		i2c2 = &hsi2c_2;
+		i2c3 = &hsi2c_3;
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
 		pinctrl2 = &pinctrl_2;
@@ -339,6 +343,58 @@
 			fifo-depth = <64>;
 			status = "disabled";
 		};
+
+		hsi2c_0: hsi2c@12da0000 {
+			compatible = "samsung,exynos5260-hsi2c";
+			reg = <0x12DA0000 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_hs_bus>;
+			clocks = <&clock_peri PERI_CLK_HSIC0>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_1: hsi2c@12db0000 {
+			compatible = "samsung,exynos5260-hsi2c";
+			reg = <0x12DB0000 0x1000>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_hs_bus>;
+			clocks = <&clock_peri PERI_CLK_HSIC1>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_2: hsi2c@12dc0000 {
+			compatible = "samsung,exynos5260-hsi2c";
+			reg = <0x12DC0000 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_hs_bus>;
+			clocks = <&clock_peri PERI_CLK_HSIC2>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_3: hsi2c@12dd0000 {
+			compatible = "samsung,exynos5260-hsi2c";
+			reg = <0x12DD0000 0x1000>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c3_hs_bus>;
+			clocks = <&clock_peri PERI_CLK_HSIC3>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
