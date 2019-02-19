Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E0DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:08:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7CA2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pHlCMEtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7CA2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iwCfq7bh4mcszlHcnsh7hB8onCW/POU1nMc3oqWCeFM=; b=pHlCMEtT5TnVcW
	czTXbVjt6O2x6aoAST/XSx+tJ5L1HMEH+QHwCRvo8bn4UG75N2NM+1qQbm8PiXFdHU24moUJSmcx1
	ut/rxen9kN+P1BBrTPPs/5/WogbNJwa2Pgeo+zwaSC16Ek03JCzN6i1S65CJeBeqq0hTy1aYa3xhH
	XRym9W1JBZEWKCq0FKJ681CgxNieOf3PmErSkAYDgXXFkphbyA4qefTu72y4zql/kK8IFcXTgRY8P
	G99Yb/DtDX4hAQfghtlqNyNQ4RK6ieUkXJwYiAGFHUp3L2V7toIJPSd7xCy8QqZtjdoE7nzkMD69c
	e/R1VehMZaIFpZ8Dsf7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw64Q-0007hl-Pj; Tue, 19 Feb 2019 14:08:26 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw649-0007PE-FE; Tue, 19 Feb 2019 14:08:12 +0000
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1JE84aW082694;
 Tue, 19 Feb 2019 23:08:04 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Tue, 19 Feb 2019 23:08:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from localhost.localdomain (119.104.232.153.ap.dti.ne.jp
 [153.232.104.119]) (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1JE81Zk082668
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Tue, 19 Feb 2019 23:08:03 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
To: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Subject: [PATCH 1/2] arm64: dts: rockchip: replace GPIO number into macro for
 rk3399
Date: Tue, 19 Feb 2019 23:07:59 +0900
Message-Id: <20190219140800.12624-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_060809_991257_03476525 
X-CRM114-Status: UNSURE (   8.70  )
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
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch just replace some absolute GPIO numbers of I2C, I2S, UART,
SPDIF, SPI and so on for rk3399 devicetree into RK_PXn macro for more
readability.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 236 +++++++++++------------
 1 file changed, 118 insertions(+), 118 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index db9d948c0b03..76fc2c7af80a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2045,14 +2045,14 @@
 
 		clock {
 			clk_32k: clk-32k {
-				rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
+				rockchip,pins = <0 RK_PA0 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		edp {
 			edp_hpd: edp-hpd {
 				rockchip,pins =
-					<4 23 RK_FUNC_2 &pcfg_pull_none>;
+					<4 RK_PC7 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
@@ -2060,167 +2060,167 @@
 			rgmii_pins: rgmii-pins {
 				rockchip,pins =
 					/* mac_txclk */
-					<3 17 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PC1 RK_FUNC_1 &pcfg_pull_none_13ma>,
 					/* mac_rxclk */
-					<3 14 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB6 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_mdio */
-					<3 13 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB5 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_txen */
-					<3 12 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PB4 RK_FUNC_1 &pcfg_pull_none_13ma>,
 					/* mac_clk */
-					<3 11 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB3 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxdv */
-					<3 9 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB1 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_mdc */
-					<3 8 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB0 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxd1 */
-					<3 7 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA7 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxd0 */
-					<3 6 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA6 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_txd1 */
-					<3 5 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PA5 RK_FUNC_1 &pcfg_pull_none_13ma>,
 					/* mac_txd0 */
-					<3 4 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PA4 RK_FUNC_1 &pcfg_pull_none_13ma>,
 					/* mac_rxd3 */
-					<3 3 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA3 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxd2 */
-					<3 2 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA2 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_txd3 */
-					<3 1 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PA1 RK_FUNC_1 &pcfg_pull_none_13ma>,
 					/* mac_txd2 */
-					<3 0 RK_FUNC_1 &pcfg_pull_none_13ma>;
+					<3 RK_PA0 RK_FUNC_1 &pcfg_pull_none_13ma>;
 			};
 
 			rmii_pins: rmii-pins {
 				rockchip,pins =
 					/* mac_mdio */
-					<3 13 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB5 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_txen */
-					<3 12 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PB4 RK_FUNC_1 &pcfg_pull_none_13ma>,
 					/* mac_clk */
-					<3 11 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB3 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxer */
-					<3 10 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB2 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxdv */
-					<3 9 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB1 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_mdc */
-					<3 8 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PB0 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxd1 */
-					<3 7 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA7 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_rxd0 */
-					<3 6 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PA6 RK_FUNC_1 &pcfg_pull_none>,
 					/* mac_txd1 */
-					<3 5 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					<3 RK_PA5 RK_FUNC_1 &pcfg_pull_none_13ma>,
 					/* mac_txd0 */
-					<3 4 RK_FUNC_1 &pcfg_pull_none_13ma>;
+					<3 RK_PA4 RK_FUNC_1 &pcfg_pull_none_13ma>;
 			};
 		};
 
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins =
-					<1 15 RK_FUNC_2 &pcfg_pull_none>,
-					<1 16 RK_FUNC_2 &pcfg_pull_none>;
+					<1 RK_PB7 RK_FUNC_2 &pcfg_pull_none>,
+					<1 RK_PC0 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		i2c1 {
 			i2c1_xfer: i2c1-xfer {
 				rockchip,pins =
-					<4 2 RK_FUNC_1 &pcfg_pull_none>,
-					<4 1 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PA2 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA1 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		i2c2 {
 			i2c2_xfer: i2c2-xfer {
 				rockchip,pins =
-					<2 1 RK_FUNC_2 &pcfg_pull_none_12ma>,
-					<2 0 RK_FUNC_2 &pcfg_pull_none_12ma>;
+					<2 RK_PA1 RK_FUNC_2 &pcfg_pull_none_12ma>,
+					<2 RK_PA0 RK_FUNC_2 &pcfg_pull_none_12ma>;
 			};
 		};
 
 		i2c3 {
 			i2c3_xfer: i2c3-xfer {
 				rockchip,pins =
-					<4 17 RK_FUNC_1 &pcfg_pull_none>,
-					<4 16 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PC1 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PC0 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		i2c4 {
 			i2c4_xfer: i2c4-xfer {
 				rockchip,pins =
-					<1 12 RK_FUNC_1 &pcfg_pull_none>,
-					<1 11 RK_FUNC_1 &pcfg_pull_none>;
+					<1 RK_PB4 RK_FUNC_1 &pcfg_pull_none>,
+					<1 RK_PB3 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		i2c5 {
 			i2c5_xfer: i2c5-xfer {
 				rockchip,pins =
-					<3 11 RK_FUNC_2 &pcfg_pull_none>,
-					<3 10 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PB3 RK_FUNC_2 &pcfg_pull_none>,
+					<3 RK_PB2 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		i2c6 {
 			i2c6_xfer: i2c6-xfer {
 				rockchip,pins =
-					<2 10 RK_FUNC_2 &pcfg_pull_none>,
-					<2 9 RK_FUNC_2 &pcfg_pull_none>;
+					<2 RK_PB2 RK_FUNC_2 &pcfg_pull_none>,
+					<2 RK_PB1 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		i2c7 {
 			i2c7_xfer: i2c7-xfer {
 				rockchip,pins =
-					<2 8 RK_FUNC_2 &pcfg_pull_none>,
-					<2 7 RK_FUNC_2 &pcfg_pull_none>;
+					<2 RK_PB0 RK_FUNC_2 &pcfg_pull_none>,
+					<2 RK_PA7 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		i2c8 {
 			i2c8_xfer: i2c8-xfer {
 				rockchip,pins =
-					<1 21 RK_FUNC_1 &pcfg_pull_none>,
-					<1 20 RK_FUNC_1 &pcfg_pull_none>;
+					<1 RK_PC5 RK_FUNC_1 &pcfg_pull_none>,
+					<1 RK_PC4 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		i2s0 {
 			i2s0_2ch_bus: i2s0-2ch-bus {
 				rockchip,pins =
-					<3 24 RK_FUNC_1 &pcfg_pull_none>,
-					<3 25 RK_FUNC_1 &pcfg_pull_none>,
-					<3 26 RK_FUNC_1 &pcfg_pull_none>,
-					<3 27 RK_FUNC_1 &pcfg_pull_none>,
-					<3 31 RK_FUNC_1 &pcfg_pull_none>,
-					<4 0 RK_FUNC_1 &pcfg_pull_none>;
+					<3 RK_PD0 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD1 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD2 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD3 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD7 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA0 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			i2s0_8ch_bus: i2s0-8ch-bus {
 				rockchip,pins =
-					<3 24 RK_FUNC_1 &pcfg_pull_none>,
-					<3 25 RK_FUNC_1 &pcfg_pull_none>,
-					<3 26 RK_FUNC_1 &pcfg_pull_none>,
-					<3 27 RK_FUNC_1 &pcfg_pull_none>,
-					<3 28 RK_FUNC_1 &pcfg_pull_none>,
-					<3 29 RK_FUNC_1 &pcfg_pull_none>,
-					<3 30 RK_FUNC_1 &pcfg_pull_none>,
-					<3 31 RK_FUNC_1 &pcfg_pull_none>,
-					<4 0 RK_FUNC_1 &pcfg_pull_none>;
+					<3 RK_PD0 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD1 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD2 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD3 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD4 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD5 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD6 RK_FUNC_1 &pcfg_pull_none>,
+					<3 RK_PD7 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA0 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		i2s1 {
 			i2s1_2ch_bus: i2s1-2ch-bus {
 				rockchip,pins =
-					<4 3 RK_FUNC_1 &pcfg_pull_none>,
-					<4 4 RK_FUNC_1 &pcfg_pull_none>,
-					<4 5 RK_FUNC_1 &pcfg_pull_none>,
-					<4 6 RK_FUNC_1 &pcfg_pull_none>,
-					<4 7 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PA3 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA4 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA5 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA6 RK_FUNC_1 &pcfg_pull_none>,
+					<4 RK_PA7 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
@@ -2311,18 +2311,18 @@
 
 		sleep {
 			ap_pwroff: ap-pwroff {
-				rockchip,pins = <1 5 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins = <1 RK_PA5 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			ddrio_pwroff: ddrio-pwroff {
-				rockchip,pins = <0 1 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins = <0 RK_PA1 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		spdif {
 			spdif_bus: spdif-bus {
 				rockchip,pins =
-					<4 21 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PC5 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			spdif_bus_1: spdif-bus-1 {
@@ -2334,229 +2334,229 @@
 		spi0 {
 			spi0_clk: spi0-clk {
 				rockchip,pins =
-					<3 6 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA6 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi0_cs0: spi0-cs0 {
 				rockchip,pins =
-					<3 7 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA7 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi0_cs1: spi0-cs1 {
 				rockchip,pins =
-					<3 8 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PB0 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi0_tx: spi0-tx {
 				rockchip,pins =
-					<3 5 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA5 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi0_rx: spi0-rx {
 				rockchip,pins =
-					<3 4 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA4 RK_FUNC_2 &pcfg_pull_up>;
 			};
 		};
 
 		spi1 {
 			spi1_clk: spi1-clk {
 				rockchip,pins =
-					<1 9 RK_FUNC_2 &pcfg_pull_up>;
+					<1 RK_PB1 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi1_cs0: spi1-cs0 {
 				rockchip,pins =
-					<1 10 RK_FUNC_2 &pcfg_pull_up>;
+					<1 RK_PB2 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi1_rx: spi1-rx {
 				rockchip,pins =
-					<1 7 RK_FUNC_2 &pcfg_pull_up>;
+					<1 RK_PA7 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi1_tx: spi1-tx {
 				rockchip,pins =
-					<1 8 RK_FUNC_2 &pcfg_pull_up>;
+					<1 RK_PB0 RK_FUNC_2 &pcfg_pull_up>;
 			};
 		};
 
 		spi2 {
 			spi2_clk: spi2-clk {
 				rockchip,pins =
-					<2 11 RK_FUNC_1 &pcfg_pull_up>;
+					<2 RK_PB3 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi2_cs0: spi2-cs0 {
 				rockchip,pins =
-					<2 12 RK_FUNC_1 &pcfg_pull_up>;
+					<2 RK_PB4 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi2_rx: spi2-rx {
 				rockchip,pins =
-					<2 9 RK_FUNC_1 &pcfg_pull_up>;
+					<2 RK_PB1 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi2_tx: spi2-tx {
 				rockchip,pins =
-					<2 10 RK_FUNC_1 &pcfg_pull_up>;
+					<2 RK_PB2 RK_FUNC_1 &pcfg_pull_up>;
 			};
 		};
 
 		spi3 {
 			spi3_clk: spi3-clk {
 				rockchip,pins =
-					<1 17 RK_FUNC_1 &pcfg_pull_up>;
+					<1 RK_PC1 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi3_cs0: spi3-cs0 {
 				rockchip,pins =
-					<1 18 RK_FUNC_1 &pcfg_pull_up>;
+					<1 RK_PC2 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi3_rx: spi3-rx {
 				rockchip,pins =
-					<1 15 RK_FUNC_1 &pcfg_pull_up>;
+					<1 RK_PB7 RK_FUNC_1 &pcfg_pull_up>;
 			};
 			spi3_tx: spi3-tx {
 				rockchip,pins =
-					<1 16 RK_FUNC_1 &pcfg_pull_up>;
+					<1 RK_PC0 RK_FUNC_1 &pcfg_pull_up>;
 			};
 		};
 
 		spi4 {
 			spi4_clk: spi4-clk {
 				rockchip,pins =
-					<3 2 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA2 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi4_cs0: spi4-cs0 {
 				rockchip,pins =
-					<3 3 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA3 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi4_rx: spi4-rx {
 				rockchip,pins =
-					<3 0 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA0 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi4_tx: spi4-tx {
 				rockchip,pins =
-					<3 1 RK_FUNC_2 &pcfg_pull_up>;
+					<3 RK_PA1 RK_FUNC_2 &pcfg_pull_up>;
 			};
 		};
 
 		spi5 {
 			spi5_clk: spi5-clk {
 				rockchip,pins =
-					<2 22 RK_FUNC_2 &pcfg_pull_up>;
+					<2 RK_PC6 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi5_cs0: spi5-cs0 {
 				rockchip,pins =
-					<2 23 RK_FUNC_2 &pcfg_pull_up>;
+					<2 RK_PC7 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi5_rx: spi5-rx {
 				rockchip,pins =
-					<2 20 RK_FUNC_2 &pcfg_pull_up>;
+					<2 RK_PC4 RK_FUNC_2 &pcfg_pull_up>;
 			};
 			spi5_tx: spi5-tx {
 				rockchip,pins =
-					<2 21 RK_FUNC_2 &pcfg_pull_up>;
+					<2 RK_PC5 RK_FUNC_2 &pcfg_pull_up>;
 			};
 		};
 
 		testclk {
 			test_clkout0: test-clkout0 {
 				rockchip,pins =
-					<0 0 RK_FUNC_1 &pcfg_pull_none>;
+					<0 RK_PA0 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			test_clkout1: test-clkout1 {
 				rockchip,pins =
-					<2 25 RK_FUNC_2 &pcfg_pull_none>;
+					<2 RK_PD1 RK_FUNC_2 &pcfg_pull_none>;
 			};
 
 			test_clkout2: test-clkout2 {
 				rockchip,pins =
-					<0 8 RK_FUNC_3 &pcfg_pull_none>;
+					<0 RK_PB0 RK_FUNC_3 &pcfg_pull_none>;
 			};
 		};
 
 		tsadc {
 			otp_gpio: otp-gpio {
-				rockchip,pins = <1 6 RK_FUNC_GPIO &pcfg_pull_none>;
+				rockchip,pins = <1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
 
 			otp_out: otp-out {
-				rockchip,pins = <1 6 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins = <1 RK_PA6 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins =
-					<2 16 RK_FUNC_1 &pcfg_pull_up>,
-					<2 17 RK_FUNC_1 &pcfg_pull_none>;
+					<2 RK_PC0 RK_FUNC_1 &pcfg_pull_up>,
+					<2 RK_PC1 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			uart0_cts: uart0-cts {
 				rockchip,pins =
-					<2 18 RK_FUNC_1 &pcfg_pull_none>;
+					<2 RK_PC2 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
 			uart0_rts: uart0-rts {
 				rockchip,pins =
-					<2 19 RK_FUNC_1 &pcfg_pull_none>;
+					<2 RK_PC3 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		uart1 {
 			uart1_xfer: uart1-xfer {
 				rockchip,pins =
-					<3 12 RK_FUNC_2 &pcfg_pull_up>,
-					<3 13 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PB4 RK_FUNC_2 &pcfg_pull_up>,
+					<3 RK_PB5 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		uart2a {
 			uart2a_xfer: uart2a-xfer {
 				rockchip,pins =
-					<4 8 RK_FUNC_2 &pcfg_pull_up>,
-					<4 9 RK_FUNC_2 &pcfg_pull_none>;
+					<4 RK_PB0 RK_FUNC_2 &pcfg_pull_up>,
+					<4 RK_PB1 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		uart2b {
 			uart2b_xfer: uart2b-xfer {
 				rockchip,pins =
-					<4 16 RK_FUNC_2 &pcfg_pull_up>,
-					<4 17 RK_FUNC_2 &pcfg_pull_none>;
+					<4 RK_PC0 RK_FUNC_2 &pcfg_pull_up>,
+					<4 RK_PC1 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		uart2c {
 			uart2c_xfer: uart2c-xfer {
 				rockchip,pins =
-					<4 19 RK_FUNC_1 &pcfg_pull_up>,
-					<4 20 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PC3 RK_FUNC_1 &pcfg_pull_up>,
+					<4 RK_PC4 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		uart3 {
 			uart3_xfer: uart3-xfer {
 				rockchip,pins =
-					<3 14 RK_FUNC_2 &pcfg_pull_up>,
-					<3 15 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PB6 RK_FUNC_2 &pcfg_pull_up>,
+					<3 RK_PB7 RK_FUNC_2 &pcfg_pull_none>;
 			};
 
 			uart3_cts: uart3-cts {
 				rockchip,pins =
-					<3 18 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PC2 RK_FUNC_2 &pcfg_pull_none>;
 			};
 
 			uart3_rts: uart3-rts {
 				rockchip,pins =
-					<3 19 RK_FUNC_2 &pcfg_pull_none>;
+					<3 RK_PC3 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
 		uart4 {
 			uart4_xfer: uart4-xfer {
 				rockchip,pins =
-					<1 7 RK_FUNC_1 &pcfg_pull_up>,
-					<1 8 RK_FUNC_1 &pcfg_pull_none>;
+					<1 RK_PA7 RK_FUNC_1 &pcfg_pull_up>,
+					<1 RK_PB0 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		uarthdcp {
 			uarthdcp_xfer: uarthdcp-xfer {
 				rockchip,pins =
-					<4 21 RK_FUNC_2 &pcfg_pull_up>,
-					<4 22 RK_FUNC_2 &pcfg_pull_none>;
+					<4 RK_PC5 RK_FUNC_2 &pcfg_pull_up>,
+					<4 RK_PC6 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
