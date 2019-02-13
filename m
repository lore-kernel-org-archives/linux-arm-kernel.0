Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725FAC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCF1222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fCwNaWSu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDWzlYBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCF1222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oFojoqRGaDSMn9jtdh5TakTJ92R4gnkoTdSJ56+GKKs=; b=fCwNaWSuyg9bZXSQ2hHUG7/566
	zrgR6k6xar12K/q3DsbGT//UxFI9jkaXLXMtzJgoBoUXhwbyYdlTSHIq86w7DwO6D7gLAS7+sSrPW
	xAEF5b8eM2ubsMdqd3ukQ5Y0El+9UmZ9qrREhYh6Gvrux6qPqnwRA0M3oZu9gXHOXWt0Pzxj5d2aI
	zm9/Z7LkF+d+zquGSmoam6e8cKyjunDkh45PTW4UCvGUJriIjbtvzkJ0HU5cZKOuPrDOLc7D2nC0I
	fRd2I4wVynyQkctocT7GfjhdudkLEiL9eqChMsFCrJBKoSeu99JtiP2IA6dykwFZVKluBp9b0cqt4
	1go4wuaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gttk6-00069W-Ra; Wed, 13 Feb 2019 12:34:22 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gttjw-0005uI-6H
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 12:34:14 +0000
Received: by mail-pl1-x643.google.com with SMTP id e5so1106664plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 04:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=5wfuddSW6tp5kYw+zApWLVum/WpZ+TiS9aNH3MKdYzo=;
 b=YDWzlYBrahihGwb5mYJoLKo/xZVNfbd33CPt1cbrzZWuoYd4mrO9sghY/jilXAFcPb
 b+yIqYLo+3iLfK4qo47FIeJm2alKAr0zD7IigOBYuDuxyVSpMP81wwKWqbTBYYM32ikY
 7eP1H9UzdYWPJFg2EjQnEimpR2CCNOZFBn4j1318kKvcCLVBMmufv0TQAAgb3M4oLi1l
 30XJVvAP2EU26QLC1+acFBj30jN9YNYmUNZ9h8iy2/P/sF5ZNAOJHkXaW5iopbmtTGVe
 6FnpZ6gyNHgcI2r4cNt4APQ10EgSKsA5vc7FTpYqtJ3E7dF+lR4m5xxIEi9dEOxUb171
 KI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=5wfuddSW6tp5kYw+zApWLVum/WpZ+TiS9aNH3MKdYzo=;
 b=hB/5dcJz2PUibnt4aWgvTbsxYUOpXF/m1jLS/G156BO8cVvaMHuaubu/GqehcjSH76
 /Vbl0b8ZjRmGPq5YpCKa1dne2J9BpMP2yCk/Q+fmLHEf6cBO6/MB2UmQPNTTrS3zxCEr
 xrh0qyOloEHHF5vtSQ5W3z8k4VL3a2Onxwi8N6+gwEMHtqS/eCpuI1M3b9naFL97xckw
 EZiSWY+c5yYGWlx0MLCLzItBP2pMxxP5E95FuUSNYp3jEFrSB7eUF7HW28fgG35ysr+e
 ON2AginiNEMSZ8WFoMGLHI/Wwzsyny1ko6OPvWBAwq1dZPC4mIHahuDCMOPZuBdTg+jM
 QV7g==
X-Gm-Message-State: AHQUAuYGUw94r2dlAtjDSClQdRVup03jGM2Mw8zzpv2LCj7G7yCNz6nF
 tj3PBcrAV7UrQaYvXCDVBlte8w==
X-Google-Smtp-Source: AHgI3IaSAf6j7onzDfTCKd/8Gy4kNKVuhVwJS5+E/ZiiK7RgY9Mi89ivH5Pa1AS62RhmQ6pxvoD77A==
X-Received: by 2002:a17:902:bd0b:: with SMTP id
 p11mr274548pls.259.1550061251528; 
 Wed, 13 Feb 2019 04:34:11 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.07
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 04:34:10 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org,
	mark.rutland@arm.com,
	arnd@arndb.de
Subject: [PATCH v2 1/5] arm64: dts: sprd: Remove PMIC INTC irq trigger type
Date: Wed, 13 Feb 2019 20:32:45 +0800
Message-Id: <b6a32917d1e231277d240a4084bebb6ad91247e3.1550060544.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_043412_372329_E10FF590 
X-CRM114-Status: GOOD (  10.36  )
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
Cc: devicetree@vger.kernel.org, baolin.wang@linaro.org, zhang.lyra@gmail.com,
 broonie@kernel.org, linux-kernel@vger.kernel.org, arm@kernel.org,
 olof@lixom.net, orsonzhai@gmail.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Spreadtrum PMIC INTC controller has no registers to set trigger type,
since it is always high level trigger as default. So remove its child
devices' irq trigger type setting and change #interrupt-cells to 1.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 82bd642..f2f2aa5 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -13,7 +13,7 @@
 		spi-max-frequency = <26000000>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-controller;
-		#interrupt-cells = <2>;
+		#interrupt-cells = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -43,14 +43,14 @@
 			compatible = "sprd,sc27xx-rtc", "sprd,sc2731-rtc";
 			reg = <0x280>;
 			interrupt-parent = <&sc2731_pmic>;
-			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <2>;
 		};
 
 		pmic_eic: gpio@300 {
 			compatible = "sprd,sc27xx-eic";
 			reg = <0x300>;
 			interrupt-parent = <&sc2731_pmic>;
-			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <5>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -69,7 +69,7 @@
 			compatible = "sprd,sc27xx-adc", "sprd,sc2731-adc";
 			reg = <0x480>;
 			interrupt-parent = <&sc2731_pmic>;
-			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <0>;
 			#io-channel-cells = <1>;
 			hwlocks = <&hwlock 4>;
 		};
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
