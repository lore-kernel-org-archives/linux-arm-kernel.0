Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F13C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:26:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588CF2183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DLxbj5Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588CF2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tYJMJz/vI5MY3BEVM0Nj6WyzPtWC8N99GuaGd6al3R8=; b=DLxbj5CaeadYe5
	8U3yPDG/0DEXTgjU7MGPBZGiClRw246lqd6ZV005vFMidCzYuVzpT7sKk3jdBnIxnkys4UsVe0Idt
	ZZ1EOkItk47yHPkZPOiTcQ9+HGBscVmbqvNrqairilH5Z01uui8BKeX6XiJk8lI3R8i7rHEpMbE7L
	+Zq+jFJgjeI+7k90MW7m34sZ4V+svd3xgt5Wvgv8giJ5He/PWUvzm8p2wa2/FDVBgz0RX6B+jrjNf
	3nBQFe4amdnB/MtWiMZj6Q9eU6fgiELG7NqIMkRZqCzjWVsaqoJgKhqqR6+S58ldbqTgAQ+Vvw0el
	g1oMZbbqRbgtOM4NEB2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSpb-0006dp-Q2; Wed, 20 Feb 2019 14:26:39 +0000
Received: from unicorn.mansr.com ([81.2.72.234])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSp6-00066I-DD
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:26:11 +0000
Received: by unicorn.mansr.com (Postfix, from userid 51770)
 id 3758615638; Wed, 20 Feb 2019 14:26:02 +0000 (GMT)
From: Mans Rullgard <mans@mansr.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 3/3] ARM: dts: sun7i: add /omit-if-no-ref/ tags to pin group
 nodes
Date: Wed, 20 Feb 2019 14:25:36 +0000
Message-Id: <20190220142536.21051-3-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220142536.21051-1-mans@mansr.com>
References: <20190220142536.21051-1-mans@mansr.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_062608_781886_0C705E47 
X-CRM114-Status: UNSURE (   8.57  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since only one alternative at a time is used, and some functions may not
be used at all, this cuts down the size of the board dtb files a bit.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e4d927a8a984..9f8bd8f3164b 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -763,21 +763,25 @@
 				function = "can";
 			};
 
+			/omit-if-no-ref/
 			can_ph_pins: can-ph-pins {
 				pins = "PH20", "PH21";
 				function = "can";
 			};
 
+			/omit-if-no-ref/
 			clk_out_a_pin: clk-out-a-pin {
 				pins = "PI12";
 				function = "clk_out_a";
 			};
 
+			/omit-if-no-ref/
 			clk_out_b_pin: clk-out-b-pin {
 				pins = "PI13";
 				function = "clk_out_b";
 			};
 
+			/omit-if-no-ref/
 			emac_pa_pins: emac-pa-pins {
 				pins = "PA0", "PA1", "PA2",
 				       "PA3", "PA4", "PA5", "PA6",
@@ -797,6 +801,7 @@
 				function = "emac";
 			};
 
+			/omit-if-no-ref/
 			gmac_mii_pins: gmac-mii-pins {
 				pins = "PA0", "PA1", "PA2",
 				       "PA3", "PA4", "PA5", "PA6",
@@ -806,6 +811,7 @@
 				function = "gmac";
 			};
 
+			/omit-if-no-ref/
 			gmac_rgmii_pins: gmac-rgmii-pins {
 				pins = "PA0", "PA1", "PA2",
 				       "PA3", "PA4", "PA5", "PA6",
@@ -820,46 +826,55 @@
 				drive-strength = <40>;
 			};
 
+			/omit-if-no-ref/
 			i2c0_pins: i2c0-pins {
 				pins = "PB0", "PB1";
 				function = "i2c0";
 			};
 
+			/omit-if-no-ref/
 			i2c1_pins: i2c1-pins {
 				pins = "PB18", "PB19";
 				function = "i2c1";
 			};
 
+			/omit-if-no-ref/
 			i2c2_pins: i2c2-pins {
 				pins = "PB20", "PB21";
 				function = "i2c2";
 			};
 
+			/omit-if-no-ref/
 			i2c3_pins: i2c3-pins {
 				pins = "PI0", "PI1";
 				function = "i2c3";
 			};
 
+			/omit-if-no-ref/
 			ir0_rx_pin: ir0-rx-pin {
 				pins = "PB4";
 				function = "ir0";
 			};
 
+			/omit-if-no-ref/
 			ir0_tx_pin: ir0-tx-pin {
 				pins = "PB3";
 				function = "ir0";
 			};
 
+			/omit-if-no-ref/
 			ir1_rx_pin: ir1-rx-pin {
 				pins = "PB23";
 				function = "ir1";
 			};
 
+			/omit-if-no-ref/
 			ir1_tx_pin: ir1-tx-pin {
 				pins = "PB22";
 				function = "ir1";
 			};
 
+			/omit-if-no-ref/
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
@@ -868,6 +883,7 @@
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
 			mmc2_pins: mmc2-pins {
 				pins = "PC6", "PC7", "PC8",
 				       "PC9", "PC10", "PC11";
@@ -876,6 +892,7 @@
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
 			mmc3_pins: mmc3-pins {
 				pins = "PI4", "PI5", "PI6",
 				       "PI7", "PI8", "PI9";
@@ -884,77 +901,92 @@
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
 			ps2_0_pins: ps2-0-pins {
 				pins = "PI20", "PI21";
 				function = "ps2";
 			};
 
+			/omit-if-no-ref/
 			ps2_1_ph_pins: ps2-1-ph-pins {
 				pins = "PH12", "PH13";
 				function = "ps2";
 			};
 
+			/omit-if-no-ref/
 			pwm0_pin: pwm0-pin {
 				pins = "PB2";
 				function = "pwm";
 			};
 
+			/omit-if-no-ref/
 			pwm1_pin: pwm1-pin {
 				pins = "PI3";
 				function = "pwm";
 			};
 
+			/omit-if-no-ref/
 			spdif_tx_pin: spdif-tx-pin {
 				pins = "PB13";
 				function = "spdif";
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
 			spi0_pi_pins: spi0-pi-pins {
 				pins = "PI11", "PI12", "PI13";
 				function = "spi0";
 			};
 
+			/omit-if-no-ref/
 			spi0_cs0_pi_pin: spi0-cs0-pi-pin {
 				pins = "PI10";
 				function = "spi0";
 			};
 
+			/omit-if-no-ref/
 			spi0_cs1_pi_pin: spi0-cs1-pi-pin {
 				pins = "PI14";
 				function = "spi0";
 			};
 
+			/omit-if-no-ref/
 			spi1_pi_pins: spi1-pi-pins {
 				pins = "PI17", "PI18", "PI19";
 				function = "spi1";
 			};
 
+			/omit-if-no-ref/
 			spi1_cs0_pi_pin: spi1-cs0-pi-pin {
 				pins = "PI16";
 				function = "spi1";
 			};
 
+			/omit-if-no-ref/
 			spi2_pb_pins: spi2-pb-pins {
 				pins = "PB15", "PB16", "PB17";
 				function = "spi2";
 			};
 
+			/omit-if-no-ref/
 			spi2_cs0_pb_pin: spi2-cs0-pb-pin {
 				pins = "PB14";
 				function = "spi2";
 			};
 
+			/omit-if-no-ref/
 			spi2_pc_pins: spi2-pc-pins {
 				pins = "PC20", "PC21", "PC22";
 				function = "spi2";
 			};
 
+			/omit-if-no-ref/
 			spi2_cs0_pc_pin: spi2-cs0-pc-pin {
 				pins = "PC19";
 				function = "spi2";
 			};
 
+			/omit-if-no-ref/
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB22", "PB23";
 				function = "uart0";
@@ -990,26 +1022,31 @@
 				function = "uart2";
 			};
 
+			/omit-if-no-ref/
 			uart2_pi_pins: uart2-pi-pins {
 				pins = "PI18", "PI19";
 				function = "uart2";
 			};
 
+			/omit-if-no-ref/
 			uart2_cts_rts_pi_pins: uart2-cts-rts-pi-pins {
 				pins = "PI16", "PI17";
 				function = "uart2";
 			};
 
+			/omit-if-no-ref/
 			uart3_pg_pins: uart3-pg-pins {
 				pins = "PG6", "PG7";
 				function = "uart3";
 			};
 
+			/omit-if-no-ref/
 			uart3_cts_rts_pg_pins: uart3-cts-rts-pg-pins {
 				pins = "PG8", "PG9";
 				function = "uart3";
 			};
 
+			/omit-if-no-ref/
 			uart3_ph_pins: uart3-ph-pins {
 				pins = "PH0", "PH1";
 				function = "uart3";
@@ -1021,11 +1058,13 @@
 				function = "uart3";
 			};
 
+			/omit-if-no-ref/
 			uart4_pg_pins: uart4-pg-pins {
 				pins = "PG10", "PG11";
 				function = "uart4";
 			};
 
+			/omit-if-no-ref/
 			uart4_ph_pins: uart4-ph-pins {
 				pins = "PH4", "PH5";
 				function = "uart4";
@@ -1037,6 +1076,7 @@
 				function = "uart5";
 			};
 
+			/omit-if-no-ref/
 			uart5_pi_pins: uart5-pi-pins {
 				pins = "PI10", "PI11";
 				function = "uart5";
@@ -1048,6 +1088,7 @@
 				function = "uart6";
 			};
 
+			/omit-if-no-ref/
 			uart6_pi_pins: uart6-pi-pins {
 				pins = "PI12", "PI13";
 				function = "uart6";
@@ -1059,6 +1100,7 @@
 				function = "uart7";
 			};
 
+			/omit-if-no-ref/
 			uart7_pi_pins: uart7-pi-pins {
 				pins = "PI20", "PI21";
 				function = "uart7";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
