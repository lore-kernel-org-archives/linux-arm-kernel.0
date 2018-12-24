Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC16BC64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:04:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9213F2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M7Zk+GoE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfZOFwSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9213F2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kDjuyOIhTUBxtzlQNn1HdHqDeYKiS4eh7B64l+SRE2Y=; b=M7Zk+GoEhPemCKIptGvWSZHWaH
	1moMwiy3UyDD5JDluAtMa5Zc0y615dja8x0SWC0OGW6ldAHLAb1mHAuGXWlyHyqrHadmfy+dkw8q5
	VSyjyBBpo4/7Kqx4BNMiCRphopa22tJzhyAFdPZi4MvGi7uyqievbWdpopVHXNh19RHkxlfesjuVh
	0jR7jmggL9d3ZG8kKm0juTFBp98JGQTMz0IbBIYy+7Srtx5HV2M7m5e4DCnIqelTZCt66uJl2s5iW
	pYcrV08gPGri8f1JYp6unE19seCgfLDPI2Rsg02uueHSJ9bOFRE/VNfSmPveBn36cGf+rwOMyddqY
	UQ0BVsKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbYKy-0007RN-47; Mon, 24 Dec 2018 22:04:36 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbYHt-0004QS-IV
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 22:01:28 +0000
Received: by mail-wr1-x442.google.com with SMTP id u4so12530050wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 14:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Nvq5FeHdEvsC0QZW7YnkE+ErsIu1+CoQUcHwhHtd2Mw=;
 b=pfZOFwSpAjK5EYEOFRZSndyUYxddBP0mfbZU/cND0YylRbIFb6K3wZqG2x7hR9hQhf
 OGh4+Yy6QbdrNLSjCOeHGf47kf0Q+DkPDjVNlSRM2TqLq80mfi2M2bPaKXu43EWdjvyi
 lsOVeZ1olIMJltzM67j1aOcxCg5OY7Qap0BOz184b7FA9JdEBrhK/6vQVyKVQsYjMpnS
 bzQR4bMS6ogS+gL4cPbxTOzONe7SU0c+AhjlpOs+MkyNvY6JEmdrdO6G7AXM11kd48xv
 Ywa2lsekrTXOi98CNC2XNrI6IiszI4OKGPkkdEkfJAxWTJqfx3f5pSG4oIVzcylstoRZ
 vt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Nvq5FeHdEvsC0QZW7YnkE+ErsIu1+CoQUcHwhHtd2Mw=;
 b=r1z+BJmzkLJJDDVOoO4sOgX2Ve3QPOuXtDvAjDeiXAQOW4FGXH47xXr6paYbYzUKaI
 kLKM+l+tBYbEQ3675L6Vfn1OVfc9d+HEFzrfTCzvgs94Rr6WrbiKFQg4s/iZ9mva+Xvh
 DaktpIxHmeeXjKjIfT0uL3nmrtH/yGDWj+Er/rzJXHxIyVaYrrCUk1C79u3g/8fGe7Ge
 uVjGw2qPLx68Lqp02/WBoeGNS/D+5DpGwFoYcGPzJHghkUWT2HRaz1+5Qr/bxcMAUnGE
 4pqTIE7lZJ93eTtexZAyrUcPx4B0ft4SiWt2mPJ312jQdz5LolNzpVd7XtoLe7xanKoG
 ZRDw==
X-Gm-Message-State: AJcUukcRwTlHIKoJX8hnw6WYAQm39IKsd/W3Rd7HpY8Z+2AS78yCesgR
 fHntT4B1C4lxc3KZeCqgNhtMIpeBcRA=
X-Google-Smtp-Source: ALg8bN5G4GPJ3oQu8VC60DrM2oylE9uEbEYbpwfRYORSiEBeEoofJXnaBgNsBAD4pcpG9eA5DS1kwg==
X-Received: by 2002:adf:f449:: with SMTP id f9mr13398995wrp.40.1545688874135; 
 Mon, 24 Dec 2018 14:01:14 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl.
 [83.23.22.20])
 by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 14:01:13 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 13/14] ARM: dts: stm32: add SPI support on STM32F429 SoC
Date: Mon, 24 Dec 2018 23:00:39 +0100
Message-Id: <1545688840-23992-14-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_140125_674546_E9A4E204 
X-CRM114-Status: GOOD (  12.62  )
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
 Cezary Gapinski <cezary.gapinski@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

This patch adds all SPI instances of the STM32F429 SoC.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 8d6f028..8dbec00 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -314,6 +314,26 @@
 			status = "disabled";
 		};
 
+		spi2: spi@40003800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40003800 0x400>;
+			interrupts = <36>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(SPI2)>;
+			status = "disabled";
+		};
+
+		spi3: spi@40003C00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40003C00 0x400>;
+			interrupts = <51>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(SPI3)>;
+			status = "disabled";
+		};
+
 		usart2: serial@40004400 {
 			compatible = "st,stm32-uart";
 			reg = <0x40004400 0x400>;
@@ -523,6 +543,26 @@
 			status = "disabled";
 		};
 
+		spi1: spi@40013000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40013000 0x400>;
+			interrupts = <35>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI1)>;
+			status = "disabled";
+		};
+
+		spi4: spi@40013400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40013400 0x400>;
+			interrupts = <84>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI4)>;
+			status = "disabled";
+		};
+
 		syscfg: system-config@40013800 {
 			compatible = "syscon";
 			reg = <0x40013800 0x400>;
@@ -587,6 +627,26 @@
 			};
 		};
 
+		spi5: spi@40015000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40015000 0x400>;
+			interrupts = <85>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI5)>;
+			status = "disabled";
+		};
+
+		spi6: spi@40015400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32f4-spi";
+			reg = <0x40015400 0x400>;
+			interrupts = <86>;
+			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI6)>;
+			status = "disabled";
+		};
+
 		pwrcfg: power-config@40007000 {
 			compatible = "syscon";
 			reg = <0x40007000 0x400>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
