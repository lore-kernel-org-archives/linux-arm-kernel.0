Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3035C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:14:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5872A2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ax4HaR8e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iF4U0Dsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5872A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=niCekRbOB/MfDCzeJSBwwls5KW8Vp3Ss8DzaP5aVBns=; b=ax4HaR8eBQvTcb
	a0ddV9E8wXQsoCvKGOlk5y4CsDQrqm3MHthdDobgKEBUbu7WzswPdCy8X7Tk+CMqxOBvHdX3F1Bj+
	PArrUvMMQw6xXJjIkpZdtXJULW5cTW0v2C6LXgL5f79Nmw76D79xiPfTgkjIl+eT5nMM5Nv/N2f6x
	j41KJqpKFQGbq/smduxlmjbHSOwvS4HWZrggVhv1WttZsgp8EQjDhE10UM+nzowMEj3Ez4Mj4GqSu
	u1ulMZ0B4mqiSASFLFhYNDzjF/ll8trB+Y0n2PZdNNphJKt0dkEtNpy1v5AjDqeB03PR1Zi6AGnjp
	axf7zVEDv6KMaSgVLrAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVgB5-0004Z7-Qr; Sat, 08 Dec 2018 17:14:07 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVgAN-0003bj-UO; Sat, 08 Dec 2018 17:13:27 +0000
Received: by mail-wr1-x442.google.com with SMTP id 96so6604100wrb.2;
 Sat, 08 Dec 2018 09:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1CKwmb26jrhBLBt3QpwRPRe3U3/77uADy4gMJnqH2Dc=;
 b=iF4U0Dsy22CATFhzUilDo3CA4AGa0ooH8buA9bFahQ2WxXGenn7SykJf1aPB5rmjSF
 mtLq1RBaP/O1lg5oFAU7GePAet5stjS/Zf3Wq+8zEftMGK8CInR2YTtPyT77axgE49QA
 NNxzGBMMJudHPKOcSD7gakWFY8xX7IHVDLOOY74RHo18nVNrKYFmczYPNbJDn43TH0Wh
 uWhwNmUHjoFFIxlsHyBHstZAjUAAKMWVNNmmLqtXhz5H1w9L2y4wcnuDcCf0wp/RfM02
 Wodk2B8gj7L5ZiDsGceyhmLQ3kSSlYts6oX8PG0id50HT4jA6tbpLm2FN9FRUH6PNCyH
 VR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1CKwmb26jrhBLBt3QpwRPRe3U3/77uADy4gMJnqH2Dc=;
 b=NGvev8zSxLnz89cSirmtyrFRSBAATGtuTbqdABYqEIAtAl1JxPDSBGUYHlHPh/L9Yu
 SBV270/G1bJC4ciaweL7kL2oW4a56u494ga7+MQ273kfjBs979b2dAy6tP5JtUGgvrle
 WqJAivgTV+Kj0ZBqN9U3aunPX2vQFz2c72m1njppJ/FuYyCRrYX+pDmuY/Kgr6mDW7B/
 VsOCJr6ASfLSC/FB30Aw8qf5O5sVvNvqwyhC5SACj2i6UouMgXzwPbwdFbg6XdV7kHc1
 2nXrFIEuLWSWlYa/EFkas3Y/aGOteObUDWmBrDkzl1iWKVlhKQVYg9g93mQmet55V9+B
 0Nkw==
X-Gm-Message-State: AA+aEWal8s7NJeRniVJUy2C24Pnyttz1JVejxGXlAVzRGZ3S+JsdiFsU
 s0vXUSC3VNjplWJw60CVB7bP8v8M
X-Google-Smtp-Source: AFSGD/Xt/gYdaEq443dIwgz6+RZMT51zJkRJfreev114eQ/oJxHbAf2Eg1si4RKHoWt1jARc5qOabg==
X-Received: by 2002:a5d:46c2:: with SMTP id g2mr5313106wrs.49.1544289194507;
 Sat, 08 Dec 2018 09:13:14 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id r12sm4995851wrq.3.2018.12.08.09.13.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 09:13:13 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jbrunet@baylibre.com, narmstrong@baylibre.com, khilman@baylibre.com,
 robh+dt@kernel.org
Subject: [PATCH 5/5] ARM: dts: meson8b: add the Mali-450 MP2 GPU
Date: Sat,  8 Dec 2018 18:12:47 +0100
Message-Id: <20181208171247.22238-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_091324_287959_02BF1442 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the Mali-450 GPU and it's OPP table for Meson8. The GPU uses two
pixel processors in this configuration. The OPP table is taken from the
3.10 vendor kernel which uses the following table:
  FCLK_DEV5 | 1,     /* 255 Mhz */
  FCLK_DEV7 | 0,     /* 364 Mhz */
  FCLK_DEV3 | 1,     /* 425 Mhz */
  FCLK_DEV5 | 0,     /* 510 Mhz */
  FCLK_DEV4 | 0,     /* 637.5 Mhz */
This describes the mux (FCLK_DEVx) and a 0-based divider in the clock
controller. "FCLK" is "fixed_pll" which is running at 2550MHz.
The "turbo" setting is described by "turbo_clock = 4" where 4 is the
index of the table above.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 5d036842c355..dd498e681939 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -158,6 +158,32 @@
 		};
 	};
 
+	gpu_opp_table: gpu-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-255000000 {
+			opp-hz = /bits/ 64 <255000000>;
+			opp-microvolt = <1150000>;
+		};
+		opp-364300000 {
+			opp-hz = /bits/ 64 <364300000>;
+			opp-microvolt = <1150000>;
+		};
+		opp-425000000 {
+			opp-hz = /bits/ 64 <425000000>;
+			opp-microvolt = <1150000>;
+		};
+		opp-510000000 {
+			opp-hz = /bits/ 64 <510000000>;
+			opp-microvolt = <1150000>;
+		};
+		opp-637500000 {
+			opp-hz = /bits/ 64 <637500000>;
+			opp-microvolt = <1150000>;
+			turbo-mode;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a5-pmu";
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
@@ -185,6 +211,26 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0xd0000000 0x200000>;
+
+		mali: gpu@c0000 {
+			compatible = "amlogic,meson8b-mali", "arm,mali-450";
+			reg = <0xc0000 0x40000>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp", "gpmmu", "pp", "pmu",
+					  "pp0", "ppmmu0", "pp1", "ppmmu1";
+			resets = <&reset RESET_MALI>;
+			clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
+			clock-names = "bus", "core";
+			operating-points-v2 = <&gpu_opp_table>;
+			switch-delay = <0xffff>;
+		};
 	};
 }; /* end of / */
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
