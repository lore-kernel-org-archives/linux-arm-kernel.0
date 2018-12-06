Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F003C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:32:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC0E20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tHka2V5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC0E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qqq2OElrlWCx0732yL6mT+aspdtBO/PdWM7AKMEnD5g=; b=tHka2V5FhNr9HX
	sT2tTS00kxIlGKGL1b0XMtDc6JCtyIJkLSJRfYBolDBsXEPlRfA+i7Jp3F5gurCcXnadDOXEmuIYB
	6qRBflMGC0xooW893y9ZMHQQMMSDUBbPiGtQ5gp6XDX97PBCZHCc39INl1/V3+RgJ7upG5oE1dFyJ
	q3mDNW8U8Mout/5mYOyVP7Ed7NyXKT2Q5bBJ4SnruuL+YqZrDRFH+MGwO/PtxIqT2pYTNDMyCNkSf
	76OKKXI5Fqe6arL1OrvWagjEJJO81b8bgKU6GViimrvVVBjnKDmpyaTRIzo5p6VD2441RoHhFtRA3
	oZDg7+q8AGlm0qpqtuWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwZR-0002R5-Ev; Thu, 06 Dec 2018 16:32:13 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwZN-0002Eh-D2
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:32:11 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 516E280F6;
 Thu,  6 Dec 2018 16:32:00 +0000 (UTC)
Date: Thu, 6 Dec 2018 08:31:54 -0800
From: Tony Lindgren <tony@atomide.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: OMAP4430 SDP with KS8851: very slow networking
Message-ID: <20181206163154.GK6707@atomide.com>
References: <20181206132256.GT30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206132256.GT30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_083209_483861_A73F2A4F 
X-CRM114-Status: GOOD (  13.21  )
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
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

* Russell King - ARM Linux <linux@armlinux.org.uk> [181206 13:23]:
> It looks very much like a receive problem - in that the board is not
> always aware of a packet having been received until it attempts to
> transmit (eg, in the case of TFTP, when it re-sends the ACK after a
> receive timeout, it _then_ notices that there's a packet waiting.)
> 
> I'm not quite sure when this cropped up as I no longer regularly
> update and run my nightly boot tests, but I think 4.18 was fine.

Sounds like it's some gpio or PM related issue. If it's not caused
by commit b764a5863fd8 ("gpio: omap: Remove custom PM calls and
use cpu_pm instead"), then maybe the changes to probe devices
with ti-sysc interconnect target module driver caused it. Below
is a revert for mcspi that would help in that case.

Also I guess it could be caused by drivers/spi/spi-omap2-mcspi.c
changes since v4.18.

Care to post output of /sys/kernel/debug/pm_debug/count for
a working and non-working kernels?

Regards,

Tony

8< -------------------
diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4.dtsi
--- a/arch/arm/boot/dts/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/omap4-l4.dtsi
@@ -2050,25 +2050,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x98000 0x1000>;
-
-			mcspi1: spi@0 {
-				compatible = "ti,omap4-mcspi";
-				reg = <0x0 0x200>;
-				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ti,spi-num-cs = <4>;
-				dmas = <&sdma 35>,
-				       <&sdma 36>,
-				       <&sdma 37>,
-				       <&sdma 38>,
-				       <&sdma 39>,
-				       <&sdma 40>,
-				       <&sdma 41>,
-				       <&sdma 42>;
-				dma-names = "tx0", "rx0", "tx1", "rx1",
-					    "tx2", "rx2", "tx3", "rx3";
-			};
+			status = "disabled";
 		};
 
 		target-module@9a000 {			/* 0x4809a000, ap 51 2c.0 */
@@ -2089,20 +2071,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x9a000 0x1000>;
-
-			mcspi2: spi@0 {
-				compatible = "ti,omap4-mcspi";
-				reg = <0x0 0x200>;
-				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ti,spi-num-cs = <2>;
-				dmas = <&sdma 43>,
-				       <&sdma 44>,
-				       <&sdma 45>,
-				       <&sdma 46>;
-				dma-names = "tx0", "rx0", "tx1", "rx1";
-			};
+			status = "disabled";
 		};
 
 		target-module@9c000 {			/* 0x4809c000, ap 53 36.0 */
@@ -2290,17 +2259,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xb8000 0x1000>;
-
-			mcspi3: spi@0 {
-				compatible = "ti,omap4-mcspi";
-				reg = <0x0 0x200>;
-				interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ti,spi-num-cs = <2>;
-				dmas = <&sdma 15>, <&sdma 16>;
-				dma-names = "tx0", "rx0";
-			};
+			status = "disabled";
 		};
 
 		target-module@ba000 {			/* 0x480ba000, ap 71 32.0 */
@@ -2321,17 +2280,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xba000 0x1000>;
-
-			mcspi4: spi@0 {
-				compatible = "ti,omap4-mcspi";
-				reg = <0x0 0x200>;
-				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ti,spi-num-cs = <1>;
-				dmas = <&sdma 70>, <&sdma 71>;
-				dma-names = "tx0", "rx0";
-			};
+			status = "disabled";
 		};
 
 		target-module@d1000 {			/* 0x480d1000, ap 73 44.0 */
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -193,6 +193,66 @@
 			#gpio-cells = <2>;
 		};
 
+		mcspi1: spi@48098000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x48098000 0x200>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi1";
+			ti,spi-num-cs = <4>;
+			dmas = <&sdma 35>,
+			       <&sdma 36>,
+			       <&sdma 37>,
+			       <&sdma 38>,
+			       <&sdma 39>,
+			       <&sdma 40>,
+			       <&sdma 41>,
+			       <&sdma 42>;
+			dma-names = "tx0", "rx0", "tx1", "rx1",
+				    "tx2", "rx2", "tx3", "rx3";
+		};
+
+		mcspi2: spi@4809a000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x4809a000 0x200>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi2";
+			ti,spi-num-cs = <2>;
+			dmas = <&sdma 43>,
+			       <&sdma 44>,
+			       <&sdma 45>,
+			       <&sdma 46>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
+		};
+
+		mcspi3: spi@480b8000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x480b8000 0x200>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi3";
+			ti,spi-num-cs = <2>;
+			dmas = <&sdma 15>, <&sdma 16>;
+			dma-names = "tx0", "rx0";
+		};
+
+		mcspi4: spi@480ba000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x480ba000 0x200>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi4";
+			ti,spi-num-cs = <1>;
+			dmas = <&sdma 70>, <&sdma 71>;
+			dma-names = "tx0", "rx0";
+		};
+
+
 		mmu_dsp: mmu@4a066000 {
 			compatible = "ti,omap4-iommu";
 			reg = <0x4a066000 0x100>;
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
