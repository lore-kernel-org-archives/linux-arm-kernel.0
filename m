Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03888C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:26:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B123F2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fVlJJ3ED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B123F2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wqubo55d5xwhNvNNf3/d1ty0Sb2nEfT5lvYteUHuTOg=; b=fVlJJ3EDxvgcjg
	hWC1MHmz1TPIIgO6nufmUz0X+5lFzC6RJtp/k3etpIznOrre2L0MLA8eg2nuiXS8/tB142D2ZjwP+
	jhlceUwJ1ZsvZ4jUDCXOQqVnpUJhGePUvnnNGUrQyM21aujJMuwMl2qLqTuXjEOETnD91rdr3C2zq
	vQak1Zy2D36qHWlxkrqJ2JhEREaAXaQxy06M2vFhxn7SiM6NRUOhJYQNMjYVkQwawJvmETdJiicJW
	KcYXNAgfBwFrQM/2ys90/r0+GO9DcvPWEe+BMRKkBwvRdo8tdPB0veuVkYpg2alTLbANPfGYoRvm7
	cRIUr6WNMJumZBkQZbwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXaNA-000078-8J; Thu, 13 Dec 2018 23:26:28 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXaN7-00006i-AU
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 23:26:26 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 1992B8081;
 Thu, 13 Dec 2018 23:26:17 +0000 (UTC)
Date: Thu, 13 Dec 2018 15:26:11 -0800
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: omap4-droid4: Configure wlcore wakeirq
Message-ID: <20181213232611.GT6707@atomide.com>
References: <20181213230411.5009-1-tony@atomide.com>
 <20181213230411.5009-3-tony@atomide.com>
 <20181213232228.beiwpqeixfvadjjf@earth.universe>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213232228.beiwpqeixfvadjjf@earth.universe>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_152625_402306_E9C8F064 
X-CRM114-Status: GOOD (  14.03  )
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
 =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Sebastian Reichel <sre@kernel.org> [181213 23:22]:
> Hi,
> 
> On Thu, Dec 13, 2018 at 03:04:11PM -0800, Tony Lindgren wrote:
> > With wlcore supporting optional wakeirqs, we can configure it
> > for pandaboard.
> 
> -ENOPANDA

Oops, thanks for catching the typo. Updated patch below.

Regards,

Tony

8< ----------------------
From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 13 Dec 2018 15:03:21 -0800
Subject: [PATCH] ARM: dts: omap4-droid4: Configure wlcore wakeirq

With wlcore supporting optional wakeirqs, we can configure it
for droid 4. This makes ssh connection usable with the SoC
entering deeper idle states.

Let's configure a wakeirq both for the wlcore GPIO and the SDIO
dat1 pin in case wlcore starts supporting SDIO dat1 interrupt at
some point.

And let's also add the missing keep-power-in-suspend while at it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -359,20 +359,24 @@
 
 &mmc3 {
 	vmmc-supply = <&wl12xx_vmmc>;
+	/* uart2_tx.sdmmc3_dat1 pad as wakeirq */
 	interrupts-extended = <&wakeupgen GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0xde>;
-
+	interrupt-names = "irq", "wakeup";
 	non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
+	keep-power-in-suspend;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
 	wlcore: wlcore@2 {
 		compatible = "ti,wl1285", "ti,wl1283";
 		reg = <2>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <4 IRQ_TYPE_EDGE_RISING>; /* gpio100 */
+		/* gpio_100 with gpmc_wait2 pad as wakeirq */
+		interrupts-extended = <&gpio4 4 IRQ_TYPE_EDGE_RISING>,
+				      <&omap4_pmx_core 0x4e>;
+		interrupt-names = "irq", "wakeup";
 		ref-clock-frequency = <26000000>;
 		tcxo-clock-frequency = <26000000>;
 	};
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
