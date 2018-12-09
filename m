Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE79C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:55:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BF32081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sQL6Lryn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNTI8/6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BF32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kDjuyOIhTUBxtzlQNn1HdHqDeYKiS4eh7B64l+SRE2Y=; b=sQL6LrynwTVjNXI7CvsKuC6xdJ
	SSteDf5KLkg3cCixF0FYZDmB70fMoQucWVoUYsGoPiUZazI8EVKM8xs7LvY6SCztZ2fn6bb/Lxl/t
	dz4Uzw7lcg0cP/NNXGN5d6ouYujckDKDAPewaBkcAxIv8PEKggiKt3sVXAVxL4wASK/VliTuywTFg
	V6csJKaCgTl3IeuXuu4ZIY2GXgzwjhyqkif7HflTozSsiIPftah7BVFST5SCX8klAOZuYPXfjpXDj
	G4NbDXQwt75E94r3QhGk4VRgcnvSVVUUcFvJzOhph+aACL9bt6H8MwdVoozxlXTfm6luyK8Ddel3R
	3CUlubkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVzYK-0007Wl-ND; Sun, 09 Dec 2018 13:55:24 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVzXb-0005lc-N6
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 13:54:47 +0000
Received: by mail-wr1-x443.google.com with SMTP id p4so7915185wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 05:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Nvq5FeHdEvsC0QZW7YnkE+ErsIu1+CoQUcHwhHtd2Mw=;
 b=oNTI8/6I/N+Lri3nlZqGuDVy43qFNHyxQMnQD2ym+vqTGdRJG27o2kM/6CJIWLW8b8
 7Zh/O+T5cgUPLzQygnhoUIMOMwgrpmmO0VXGoBOnVU4VZFXreIogQknsUqwCkbbqe7+6
 wm9DYyT6Of3UsVhlHLawK1SeGdptancOtD3yy6bfLRNOawPix2OKKcPOfueWJgxf/KRn
 MzM8FwsagwWk55bp007X+PPisBRR61cp0+RcaVe8sjuA9JaU9q3HjgzQHUZi5TcC9KvZ
 m3UEHwXmzqKOd2AXd/YB4ipZivTl/yH2kZb3itM+nM/VMNlQz3i24AY/EPpiYendhgxM
 eHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Nvq5FeHdEvsC0QZW7YnkE+ErsIu1+CoQUcHwhHtd2Mw=;
 b=I64zEEx3PigL435tIQvqoCwfSKW2TwTlsG3zXLygQHx7kTKrkt+Tijiqn5IIo1jK1G
 pjgFg8iko0HUhE7m2Ir7ALE0aqL9/tGYVeaYUXWWfEB4L4Z2U3uv9v+Ejme8G4IryP6P
 obC8D/FA+lm7n8Wc7qzdpK94LxX4MJ+TIoMY+zrRSxVb2dbyLsIv9pjrZTU1T4YeWVOD
 WaRrLwSuy1LDqs+4iarNV1EgtKpch/okRAHYkcuc3hSQ74nceWPjaaDoyOVXvReL/JxX
 lfGhnHFfpH6oh/n/Y0odjHTkSbEkY67oo1/tOLMQnO4wDR/jwWMZpzkR+HBl9Oby0gsV
 DNKQ==
X-Gm-Message-State: AA+aEWY+nCZj45+slm3yPflwHpoxjNKvsxq/LAInh0GcPsjH73yUjcSD
 mOYL69C6bFM25jh+9Ki7xhs=
X-Google-Smtp-Source: AFSGD/VhyUmIRtPC1D93cWFMO2ecJtzWUe6d6EFp5CsCV6CKLI48EhgF/ZM3TPrZR2fpTzLZzDoqpA==
X-Received: by 2002:adf:f401:: with SMTP id g1mr7257279wro.103.1544363668064; 
 Sun, 09 Dec 2018 05:54:28 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (dgv239.neoplus.adsl.tpnet.pl.
 [83.23.177.239])
 by smtp.gmail.com with ESMTPSA id k128sm12271795wmd.37.2018.12.09.05.54.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 09 Dec 2018 05:54:27 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: stm32: add SPI support on STM32F429 SoC
Date: Sun,  9 Dec 2018 14:53:55 +0100
Message-Id: <1544363636-12161-5-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_055440_209282_9B9C317D 
X-CRM114-Status: GOOD (  11.93  )
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
 Amelie Delaunay <amelie.delaunay@st.com>,
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
