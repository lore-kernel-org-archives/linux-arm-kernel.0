Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3C8C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:23:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257F420821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="myAjsrt4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ihkzGFbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257F420821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z+WopL2dPluRK3NLNUs8b4she2iVuPG0jjEoCq2uH1U=; b=myAjsrt4Gb+YmB
	7SE4pk0WhIyVITRGvQYryEW4UyNjVdOUYzJyMN9JJuWS0ouKi0JwKwPs4KyHUzMJ7geXGmQYWh/uv
	C7hZRL/naf8KpGtW6CU0XyXnBYh70APnnjuZ5hnmqipjp+K0Wouj/q1C9F+HvJ7SF3nqeJFfaKU0V
	CCdrZOL9wZ57AHd8Zos5q02wVfFnTjPZh9H8z3cXZsDI1YlETu9pKiVjEtFHbhoDwewXNNY4UkQBe
	Sq0EndDplDse/fJ8wA4DvpHLaCTZT/EvaDd5wk7SHI+AN/wyQocgUnAjI62NNV8Oo2Mm3CSdOnqC7
	wU2zemmuWUNhCgypQjDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLX2-00062O-SR; Mon, 10 Dec 2018 13:23:32 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLWG-0005Cw-Rp
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:22:48 +0000
Received: by mail-wm1-x342.google.com with SMTP id a18so11267252wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 05:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uBjdffJIS6e81RZXl0D/cVk1PRz+k7NxIO5RxlBhn+w=;
 b=ihkzGFbddzBhg7/l98TR3HElWWrO7AG3D5dq2YA45xQZqkZ8mucv9c45zqYilltaHA
 qdPCJYzke/x2SyUCfzPW351/KNQ4i853vaPH9lvPQ/pM/ynE6nH8tsi9+KS+mAsEnVmf
 A0q0qvIzGpxE9KFTIRP/LJ+rnfGrfX/GgnJXulyu5nJ1xBNjewiuErZPMASk0QwUU3pz
 iCxesQcHicy3VTNhEB9MZHosmhlAb4vz55RyDasb1KF9TC4U6SXp+D7Pn6mP7RqXpXtJ
 Dsf/vLX2Up+Oby27kPdZLlDWu2SLnWd3XX8lPD/vrAYUKoq5iVbT9nxJJwr7ki+wDR6V
 0EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uBjdffJIS6e81RZXl0D/cVk1PRz+k7NxIO5RxlBhn+w=;
 b=NugN8EccJoPBfd2JatCTOqU3OKuqWerzusQpOwmpWRXTMilSXa51uhuMrnKtnCaCYU
 eZTJTbP/BldSnN65k6cpxOOZvw4eWG5zgg81llekM9Zjivc5NUcBUGnoIwpFNNWh+Xnj
 v6dX4GmEOFXH26x7fQwaUpmj/ymQCxf6fPYJo9YsO7NHeMWEkGSMwo8+2RRF/h9w9Qav
 hEaZFfEURQ7B4N+riXL3EiLQLaf0jhVPSQHLIbf25pgAWdBPAn9Kx+St+iCs8NohUrIY
 oNNJtMNybMqRjYH8/PlAeIpAXUrSGqLNcSUI+PyF0Xiy33XPh/T3MGNn9BZvsFbsrMCj
 fRxg==
X-Gm-Message-State: AA+aEWY6R43rKBxV5P1cBmpjHd36/wjpm88jn0moG7Yygt0zbCxZl1Sz
 Ig3Vde17i/6GkFag2JKC3vbkjg==
X-Google-Smtp-Source: AFSGD/VNKgkJdWqMIdXGD3Xop2viNm6jJ/VTo9k/ZE2rcJTd/CFg0jW+zJt4sl4Ns8NHop4RRUZdMQ==
X-Received: by 2002:a1c:ad43:: with SMTP id w64mr10122640wme.32.1544448152953; 
 Mon, 10 Dec 2018 05:22:32 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id l3sm11208424wru.36.2018.12.10.05.22.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 05:22:31 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com
Subject: [PATCH 2/2] arm64: dts: meson-gxm: Add Mali-T820 node
Date: Mon, 10 Dec 2018 14:22:27 +0100
Message-Id: <20181210132227.29262-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210132227.29262-1-narmstrong@baylibre.com>
References: <20181210132227.29262-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_052244_925681_A5845EDD 
X-CRM114-Status: GOOD (  13.76  )
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Christian Hewitt <christianshewitt@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Christian Hewitt <christianshewitt@gmail.com>

The Amlogic Meson GXM SoC embeds an ARM Mali T820 GPU.

This patch adds the node with all the needed properties to power
on the GPU.

This has been tested with the work-in-progress PanFrost project
aiming support for ARM Mali Midgard and later GPUs.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index 247888d68a3a..35e59d390903 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -91,6 +91,33 @@
 		reset-names = "phy";
 		status = "okay";
 	};
+
+	mali: gpu@c0000 {
+		compatible = "amlogic,meson-gxm-mali", "arm,mali-t820";
+		reg = <0x0 0xc0000 0x0 0x40000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "gpu", "mmu", "job";
+		clocks = <&clkc CLKID_MALI>;
+		resets = <&reset RESET_MALI_CAPB3>, <&reset RESET_MALI>;
+
+		/*
+		 * Mali clocking is provided by two identical clock paths
+		 * MALI_0 and MALI_1 muxed to a single clock by a glitch
+		 * free mux to safely change frequency while running.
+		 */
+		assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
+				  <&clkc CLKID_MALI_0>,
+				  <&clkc CLKID_MALI>; /* Glitch free mux */
+		assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
+					 <0>, /* Do Nothing */
+					 <&clkc CLKID_MALI_0>;
+		assigned-clock-rates = <0>, /* Do Nothing */
+				       <666666666>,
+				       <0>; /* Do Nothing */
+	};
 };
 
 &clkc_AO {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
