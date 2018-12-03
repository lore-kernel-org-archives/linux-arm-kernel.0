Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38120C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:10:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0515320834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nsR318/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0515320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m6DIaEAFSGzePF7ry/6CpnJnDf+l7xi84xO6ty4Yrj4=; b=nsR318/PGosoFj
	RiwpkL/9DHCS5HTsgeq7DghtpqTefcbK7knjUR10ebug+bqJy9LGgw3RBs9AaXw86voNq3LaDOAHD
	MIUfwIvhylPm5vuYEy05tkzBGDDj6lb0iYPHFkjK6xQol+9UMK2CRcT1mXt+fZLMnMhkWzWb1aJt4
	4qwrwq170q6MDZ5fW0Au9igD36DnnEDBoj79Ozvm6TL5h45fmpQnUg66wIbMJ1JO5soBceckgZOaP
	w31nx3yxuLmmMqlFt88NPHDEvtTj8hQNfe7YaecPRPSsbktgy0r6DoZdZJH3Rl3mYow2hpzncCrmn
	0t6Ozj77dx3YGZfQq0YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTprd-0006yf-G1; Mon, 03 Dec 2018 15:10:25 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpgV-0005z1-BB
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:59:10 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 9FBC95FDD7; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 13/14] ARM: dts: sun8i: r40: Add RTC device node
Date: Mon,  3 Dec 2018 22:58:24 +0800
Message-Id: <20181203145825.20511-14-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
References: <20181203145825.20511-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_065856_326247_7213221A 
X-CRM114-Status: GOOD (  12.85  )
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
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The R40 has an RTC hardware block, which has additional registers
that are not related to RTC or clock functions, and is otherwise
compatible with the H3's RTC.

Add a device node for it, and fix up any references to the LOSC.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index a8917f8b1c80..89762dbefe42 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -70,7 +70,7 @@
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
 			clock-accuracy = <20000>;
-			clock-output-names = "osc32k";
+			clock-output-names = "ext-osc32k";
 		};
 	};
 
@@ -315,17 +315,27 @@
 		ccu: clock@1c20000 {
 			compatible = "allwinner,sun8i-r40-ccu";
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&osc32k>;
+			clocks = <&osc24M>, <&rtc 0>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
 
+		rtc: rtc@1c20400 {
+			compatible = "allwinner,sun8i-r40-rtc",
+				     "allwinner,sun8i-h3-rtc";
+			reg = <0x01c20400 0x400>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "osc32k", "osc32k-out";
+			clocks = <&osc32k>;
+			#clock-cells = <1>;
+		};
+
 		pio: pinctrl@1c20800 {
 			compatible = "allwinner,sun8i-r40-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
