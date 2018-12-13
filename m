Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA19EC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:05:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886442080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IdcgrZaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886442080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9M7Hb/jj4ngW4zwiJfKqfNkTOm5NW/dDk78VnzMffZE=; b=IdcgrZaRAhpOpY
	wg8sO+OeSk/EwZpS7GcJUrRMEnb1ZRVYS4KoQnubDWcBaSJihEM4te51+QTIWdYQlejmHWuPBXy//
	u3hug29FuCjEjITpy4yHiiTqrlwpLMyX0mw8fhSxyb50qrO0ndE58O30Le1uhZ7GmuPd9yPU6uaei
	Cp2HQT5sZYz5B+cGxRum+YZmPvdF1Nv8WNeXzK4WpADKiFwl/Q6ucNavoYR9K64VJgqXVbTpLXWw8
	WfnQ+zqP4RfOXsbMl4WAmfHc4RMEPggKW7Iz4rWEJSLPTnjbSuKauVNbMy2SJ7Chdw9PbKLXJi97s
	inMAga8eHNpEBHQSkPHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXa2U-0000cr-Oo; Thu, 13 Dec 2018 23:05:06 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXa1s-0008Lx-Eq
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 23:04:31 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id D2FBA8081;
 Thu, 13 Dec 2018 23:04:17 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: Add wlcore wakeirq for omap3-evm
Date: Thu, 13 Dec 2018 15:04:09 -0800
Message-Id: <20181213230411.5009-1-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_150428_590060_F3CBE099 
X-CRM114-Status: GOOD (  10.04  )
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
Cc: devicetree@vger.kernel.org,
 =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

With wlcore supporting optional wakeirqs, let's configure it for
omap3-evm and update the related pin muxing as some pins are left
unmuxed.

Let's configure a wakeirq both for the wlcore GPIO and the SDIO
dat1 pin in case wlcore starts supporting SDIO dat1 interrupt at
some point.

Note that for off-mode, the wlcore reset GPIO will have a glitch
meaning wlcore will reset. The only way to workaround for this
currently is to configure the reset pin with SAFE_MODE + PULL.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-evm-common.dtsi           |  7 +++++--
 arch/arm/boot/dts/omap3-evm-processor-common.dtsi | 10 +++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -122,6 +122,7 @@
 };
 
 &mmc2 {
+	interrupts-extended = <&intc 86 &omap3_pmx_core 0x12e>;
 	vmmc-supply = <&wl12xx_vmmc>;
 	non-removable;
 	bus-width = <4>;
@@ -132,8 +133,10 @@
 	wlcore: wlcore@2 {
 		compatible = "ti,wl1271";
 		reg = <2>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <21 IRQ_TYPE_EDGE_RISING>; /* gpio 149 */
+		/* gpio_149 with uart1_rts pad as wakeirq */
+		interrupts-extended = <&gpio5 21 IRQ_TYPE_EDGE_RISING>,
+				      <&omap3_pmx_core 0x14e>;
+		interrupt-names = "irq", "wakeup";
 		ref-clock-frequency = <38400000>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-evm-processor-common.dtsi b/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
--- a/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
@@ -86,6 +86,10 @@
 			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1.sdmmc2_dat1 */
 			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
 			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
+			OMAP3_CORE1_IOPAD(0x2164, PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat4.sdmmc2_dir_dat0 */
+			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat5.sdmmc2_dir_dat1 */
+			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat6.sdmmc2_dir_cmd */
+			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE1)	/* sdmmc2_dat7.sdmmc2_clkin */
 		>;
 	};
 
@@ -127,9 +131,13 @@
 		>;
 	};
 
+	/*
+	 * Note that gpio_150 pulled high with internal pull to prevent wlcore
+	 * reset on return from off mode in idle.
+	 */
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2180, PIN_OUTPUT | MUX_MODE4)		/* uart1_cts.gpio_150 */
+			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT_PULLUP | MUX_MODE7)		/* uart1_cts.gpio_150 */
 			OMAP3_CORE1_IOPAD(0x217e, PIN_INPUT | MUX_MODE4)		/* uart1_rts.gpio_149 */
 		>;
 	};
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
