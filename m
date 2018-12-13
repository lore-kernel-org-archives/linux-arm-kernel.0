Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ACDC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:57:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E57E20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cpE/1mkj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uvKeDYLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E57E20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DGO8rbQtKbrF/iByBy8rJD/VSZoy8iIUuX4rSWKbQmk=; b=cpE/1mkjG2QIT6
	ULq2HLI9lznTqRyUW+yBtl7+tR6hW7QIpVawoNqHVHxLizCiecDA87dC/Arxh3vQ6J5l7wDwSlosY
	OENX3/7O1+7VLkuU6KelDoI0PAe8F67PSbDW9hRyVacLyndfMKsMMos1ORWJjigEjPibAIEDOZhFT
	Ih75fFjnRJKQfiWg2NhkIOkoUycNO3fzo0AjqLOPZOARSknDpRQAzZRCyelW+Cu0h+UYvz6iIblg0
	Nq8FIm9TqKYhH3G12fMc6b7+vl+deNSK0bkDepodUUZc0Lg1t1ISo28T0NZ/tPuk9AyNJ67430gPA
	IN0efOXW4xagB/ILGl2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXRUf-0007tk-St; Thu, 13 Dec 2018 13:57:37 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXRUc-0007st-FN
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:57:36 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBDDv6AR043174;
 Thu, 13 Dec 2018 07:57:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544709426;
 bh=X+5PGu+PbgRsPcexAX3iiM/QufCv/s3h28oHNYIvSY4=;
 h=From:To:CC:Subject:Date;
 b=uvKeDYLDrgmx4OuVug36Zf446jBZlLx/GyzAtk2ht6TLHfwv1uwSea+J5YyjqJpg6
 7W7SgyEaoeHvIznPhaapfXpfb6nlvvzVVRAMlXA8DjOZOdiOy8vgkWiFf49mDyy47G
 W7J4Pj5qHCh7eVUz8JYvnpre6JrZsXPuSferEIb4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBDDv6Eg004389
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Dec 2018 07:57:06 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 13
 Dec 2018 07:57:06 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 13 Dec 2018 07:57:06 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBDDv4QL009397;
 Thu, 13 Dec 2018 07:57:04 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <tony@atomide.com>, <linux@armlinux.org.uk>
Subject: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if booted
 with latest u-boot
Date: Thu, 13 Dec 2018 15:58:45 +0200
Message-ID: <20181213135845.3965-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_055734_641262_5A9A230D 
X-CRM114-Status: GOOD (  18.51  )
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
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The ethernet works in kernel only if we use some binary u-boot from the
past which have support for KS8851.

The u-boot sources are not available for this mysterious u-boot image
people tends to hold on... Mainline u-bott does not have ethernet support
for sdp4430 and if we use that the ethernet is not working.

After some debugging I have managed to get the ethernet working with
mainline u-boot while not breaking the networking with the case when we
boot with the mysterious binary u-boot.

Basically we were missing bunch of pinmux settings and the 'magic'
gpio_138 handling in kernel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 9dc7ec7655cb..c88817bdcc56 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -26,6 +26,9 @@
 	};
 
 	vdd_eth: fixedregulator-vdd-eth {
+		pinctrl-names = "default";
+		pinctrl-0 = <&enet_enable_gpio>;
+
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_ETH";
 		regulator-min-microvolt = <3300000>;
@@ -352,6 +355,29 @@
 			OMAP4_IOPAD(0x152, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3.sdmmc5_dat3 */
 		>;
 	};
+
+	/* gpio_48 for ENET_ENABLE */
+	enet_enable_gpio: pinmux_enet_enable_gpio {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x070, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpmc_a24.gpio_48 */
+		>;
+	};
+
+	ks8851_pins: pinmux_ks8851_pins {
+		pinctrl-single,pins = <
+			/* ENET_INT */
+			OMAP4_IOPAD(0x054, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad10.gpio_34 */
+			/*
+			 * Misterious pin which makes the ethernet working
+			 * The legacy board file requested this pin on boot
+			 * (ETH_KS8851_QUART) and set it to high, similarly to
+			 * the ENET_ENABLE pin.
+			 * We could use gpio-hog to keep it high, but let's use
+			 * it as a reset GPIO for ks8851.
+			 */
+			OMAP4_IOPAD(0x13a, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* mcspi1_cs1.gpio_138 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -452,12 +478,16 @@
 	pinctrl-0 = <&mcspi1_pins>;
 
 	eth@0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ks8851_pins>;
+
 		compatible = "ks8851";
 		spi-max-frequency = <24000000>;
 		reg = <0>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>; /* gpio line 34 */
 		vdd-supply = <&vdd_eth>;
+		reset-gpios = <&gpio5 10 GPIO_ACTIVE_HIGH>;
 	};
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
