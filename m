Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDF5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:05:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8CD2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uMreVfu5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HumzKVYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8CD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fKT2Wf0ZM9290d7+G4+fYCggVw0J4h10udYQnEE8kMs=; b=uMreVfu5PhKAA9
	/UyakZhSWWrWKXLhddWgEQ3JFTbufxHVJ06MJ4wQA9uR74g6r3wOiK/uxOu2D8JgAMo1LoOG8QwTJ
	F76k0wsotFSNu4guVLzxtaExyQEJQj5bXAwOP1LMg06UOpaeqHfdQh6dhUGtRBOZLXFEBZ8NPaHEx
	0jBe5eVdqqAQ4B7741JOr5lH8zF57S17aEfdzIAkAFUc8iA8DdY8XbHb5UwLSYxNPDhmvNqh/qqpO
	vDckxxRT6/0K7WPLA5I8UU4B57ntygf9gkU83mkWLx++tyxUrFeKoPmc5j2ieqYi/vAPkr+vn1dkN
	jDQNZXEvT7pRKm3ndxrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDCg-0005kD-72; Tue, 04 Dec 2018 16:05:42 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDCC-00040g-8I
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:05:16 +0000
Received: by mail-wm1-x341.google.com with SMTP id r24so9748718wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 08:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+mmyKSe8RhG6C5GdPFMiEIaydW42TIFAIaOelZC+wSA=;
 b=HumzKVYEoC0fGGjQvx2NsKH7NCK/dCpgjr9RncujA5A4uCuTmGCG5SNkHWdrUTMhbd
 Xu8ozAZAndJfTMry1rtH+urk7NJLuAOOPpNZJHGU/MhSCa7KOrmDrTiAnjXlcpbuSaLZ
 4vRtk/O8DatgDYrNSL3PS+NK/7IgSK0lFeO6n3vczYKR8ykOz1DzVirsi1G/zx1Pyfvf
 WbBbxQqdf9O0tesdvYPtXvr8bhHDP0u4wvcFAmmtQ7S5m+563zVeRtxON4WbIT5Ctfjx
 +Q/VsOrmGp14yofxfBKHmFoBudUN27D2xjkF2gvDaHcv/hyUZok1RumkAVEjOLdNe42Q
 QhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+mmyKSe8RhG6C5GdPFMiEIaydW42TIFAIaOelZC+wSA=;
 b=P2/KXgPwykpjEi7vr+pUHcEoSLDpNyM+4S3QAzKlxRldyHTaF+KO1p/NUYCtHfZMnM
 UqulFvVb+jzosxyL4tcehA9MP6GiNjfDjO/bZSOi3k36/q03nFtYcksQrpVLtFj4CtTS
 RyG3b19jZk14oKMgXM7ceo//zcxAuY9zPoTap3p9yPznA0hHeu3UvTqW2j6TKup+IZuO
 aK2gFMQJIBlllwuQM+CZlHC5c5doaevb9BU/gX5DqERwdZhkjUIlzL4oU5gwaJ5bd89U
 VD+G4fqI4BdoKSmQgvN6gMpy9ovwylTI9F4VromCiW4xp1RxzwRQspR+wSg9+cBUcVQX
 51CA==
X-Gm-Message-State: AA+aEWYWw/UdjeUjhWPFGwsnENwkcMO4rgPsoqZo0V3a/XKhOLV39xXv
 QLYsaxyClYzIN09nYBRyhqfmvw==
X-Google-Smtp-Source: AFSGD/U4iFmxXdG9k7sTnqG4xIIhyaa5DDwGNZi29MKqiZ46pRwpoIEJA2v/2CogcsYeGmE+K68MMw==
X-Received: by 2002:a1c:630a:: with SMTP id x10mr5313269wmb.63.1543939500496; 
 Tue, 04 Dec 2018 08:05:00 -0800 (PST)
Received: from xps.expressvpn ([2a00:23c4:f7a1:ce00:1581:6f5a:196:51f2])
 by smtp.gmail.com with ESMTPSA id k23sm5451585wmj.32.2018.12.04.08.04.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 08:04:59 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, martin.blumenstingl@googlemail.com
Subject: [PATCH 1/2] arm64: dts: meson: Fix IRQ trigger type for macirq
Date: Tue,  4 Dec 2018 16:04:46 +0000
Message-Id: <20181204160447.27869-2-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204160447.27869-1-ccaione@baylibre.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_080512_330917_AE08FF0D 
X-CRM114-Status: GOOD (  13.87  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A long running stress test on a custom board shipping an AXG SoCs and a
Realtek RTL8211F PHY revealed that after a few hours the connection
speed would drop drastically, from ~1000Mbps to ~3Mbps. At the same time
the 'macirq' (eth0) IRQ would stop being triggered at all and as
consequence the GMAC IRQs never ACKed.

After a painful investigation the problem seemed to be due to a wrong
defined IRQ type for the GMAC IRQ that should be LEVEL_HIGH instead of
EDGE_RISING.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/boot/dts/meson.dtsi               | 2 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 0d9faf1a51ea..a86b89086334 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -263,7 +263,7 @@
 			compatible = "amlogic,meson6-dwmac", "snps,dwmac";
 			reg = <0xc9410000 0x10000
 			       0xc1108108 0x4>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index df017dbd2e57..b1a42e99cb67 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -143,7 +143,7 @@
 			compatible = "amlogic,meson-axg-dwmac", "snps,dwmac";
 			reg = <0x0 0xff3f0000 0x0 0x10000
 			       0x0 0xff634540 0x0 0x8>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			clocks = <&clkc CLKID_ETH>,
 				 <&clkc CLKID_FCLK_DIV2>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index f1e5cdbade5e..58e6bcaac1d8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -462,7 +462,7 @@
 			compatible = "amlogic,meson-gx-dwmac", "amlogic,meson-gxbb-dwmac", "snps,dwmac";
 			reg = <0x0 0xc9410000 0x0 0x10000
 			       0x0 0xc8834540 0x0 0x4>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			status = "disabled";
 		};
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
