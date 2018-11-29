Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E051FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:47:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3DF20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QmV/CCny";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="NrB4WiXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3DF20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ytVDr85B//vnibEjVy1pTES1RsWZc5Jv4O/9+/zVoOU=; b=QmV/CCnykEI7Sn
	Ghw/y9WnR+GYZu7As5aSyyAikIvkh+t94qbS1xI9/H2rzjr0M1rc8ZPYdbNYtGK9pyNaxrAWA7e/z
	hPYuiL1poHBCOkUcFk7KEKSo88jNoQMtBrqYuMgB/hCxst241yQ5bYpLamyq89l2e1G4XiSLAoxd4
	kdnh8Nm1/geG7dWAeMaSem0nBzpeUIPjA6X96HRBO2Ti4txNkGegEZV6ztawi55btLS/YDYqYnrXP
	id4ywsEIaL2/gINTkCRGkNxdkB8lkRnSFyn/QRvC/u/IIDUER/tKGscN2okoxQUM/7gBLP1I6Kxse
	rQwQ6HvYsjLMPv/NC4ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSUA2-0001dQ-AL; Thu, 29 Nov 2018 21:47:50 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSU9y-0001cf-0i
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 21:47:48 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 40D4F4042D;
 Thu, 29 Nov 2018 21:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1543528051; bh=YugYUEbYk2J4yPNunrN9ZeTwNBdjIy/Tome+foZX4Fk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NrB4WiXpwvqxbx7uHbz8g8FatQMnh61Rrgc/1KrWFwmk2t8S0JEWERsYzi36klF5l
 WfIGMQGaY5JO3H04HpIW2pOyDI+Ur8M3dIXL63uWLKfNykWt6jwvIKkgHRiw6iSM0W
 Ea+wJO+Og3MVDqHMDxx68IScGAXfA6nye8mUb7pMntCG5xiQe+jV8NIyrFFcwUVGsB
 oGV/zSrvLpPW8sM2ENL7qTGPVX4z7fiauxHkBffrOBOLhXDuoZnaLDwYOTUX04onNB
 J8uaEtWGFS/fRlOhLJLnvachkW8OEQoKx+pVJz4Sv93MF+vouwD0MTr4XYtDjaRXbR
 f1Yf1950nrVtw==
Date: Thu, 29 Nov 2018 21:47:30 +0000
From: Priit Laes <plaes@plaes.org>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 00/17] initial support for "suniv"
 Allwinner new ARM9 SoC
Message-ID: <20181129214730.6d6aju4jurai6rmv@plaes.org>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_134746_418063_E487057A 
X-CRM114-Status: GOOD (  22.72  )
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
Cc: devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-gpio@vger.kernel.org,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 01:33:10AM +0300, Mesih Kilinc wrote:
> This is the fifth version of patchset for Allwinner ARMv5 F1C100s
> SoC. Addressed comments from Maxime Ripard and Rob Herring, added signatures.

IIRC, the original author of these patches was Icenowy, what happened to this?
> 
> Changes since v4:
> - Patch "dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl"
>   - This patch applied for 4.21.
> - Patch "pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)"
>   - This patch applied for 4.21.
> - Patch "dt-bindings: clock: Add Allwinner suniv F1C100s CCU"
>   - Fixed license identifier position
>   - Added DMA fields.
> - Patch "clk: sunxi-ng: add support for suniv F1C100s SoC"
>   - Added DMA reset and clock support.
> - Patch "ARM: dts: suniv: add initial DTSI file for F1C100s"
>   - Remove dt-binding headers. 
>   - Fix uart0 pin label.
> - Patch "ARM: suniv: f1c100s: add device tree for Lichee Pi Nano"
>   - Fix uart0 pin label.
> 
> Changes since v3:
> - Patch "ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs"
>   - Remove CONFIG_ARCH_SUNXI_Vx. Use ARCH_MULTI_Vx to differentiate SoC's
>   - Change KConfig ARCH_SUNXI selection: 'select' to 'default'. 
> - Patch "irqchip/sun4i: Add a struct to hold global variables"
>   - Split irq_sun4i.c changes to 3 patch.
> - Patch "pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)"
>   - pinctrl-suniv-f1c100s: remove: disable_strict_mode = true
> - Patch "ARM: dts: suniv: add initial DTSI file for F1C100s"
>   - suniv-f1c100s.dtsi: remove unnecessary componenets.
>   - Instead of patching drivers, add original compatible string with 
> f1c100s compatibles.
>   - Add Acked-by signatures.
> 
> Changes since v2:
> - Patch "ARM: sunxi: add Allwinner ARMv5 SoCs"
>   - Move SUN4I_TIMER option to ARCH_SUNXI
>   - Added help text for MACH_SUNIV
> - Patch "irqchip/sun4i: add support for suniv interrupt controller"
>   - Defined sunxi_irq_chip_data struct and used it to differentiate
>     registers between different chips.
> - Patch " ARM: dts: suniv: add initial DTSI file for F1C100s"
>   - Removed unnecessary fake clock.
>   - Fixed compatible strings.
> 
> Changes since v1:
> - Patch "ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7
>   Allwinner SoCs"
>   - Instead of using a common bool config use a common menuconfig. 
>   - Use ARCH_MULTI_V7 to differentiate V7 SoCs.
>   - Addressed comment from Julian Calaby
> - Patch "ARM: sunxi: add Allwinner ARMv5 SoCs"
>   - Use ARCH_MULTI_V5 to differentiate V5 SoCs.
>   - removed "allwinner,suniv" board compatible string
>   - Added dt-bindings
> - Patch "irqchip/sun4i: add support for suniv interrupt controller"
>   - Added dt-bindings
>   - Changed "allwinner,suniv-ic" to "allwinner,suniv-f1c100s-ic"
> - Patch "clocksource: sun4i: add a compatible for suniv"
>   - Added dt-bindings
>   - Changed "allwinner,suniv-timer" to "allwinner,suniv-f1c100s-timer"
> - Patch "pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)"
>   - Added dt-bindings
>   - Renamed suniv-pinctrl to suniv-f1c100s-pinctrl
> - Patch "clk: sunxi-ng: add support for suniv F1C100s SoC"
>   - Added dt-bindings
>   - Renamed suniv-ccu to suniv-f1c100s-ccu
> - Patch "ARM: suniv: f1c100s: add device tree for Lichee Pi Nano"
>   - Addressed comment from Rask Ingemann Lambertsen
> 
> Thanks!
> 
> Mesih Kilinc (17):
>   ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs
>   dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
>   ARM: sunxi: add Allwinner ARMv5 SoCs
>   dt-bindings: interrupt-controller: Add suniv interrupt-controller
>   irqchip/sun4i: Add a struct to hold global variables
>   irqchip/sun4i: Move IC specific register offsets to struct
>   irqchip/sun4i: Add support for Allwinner ARMv5 F1C100s
>   dt-bindings: timer: Add Allwinner suniv timer
>   clocksource: sun4i: add a compatible for suniv
>   dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
>   pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)
>   dt-bindings: clock: Add Allwinner suniv F1C100s CCU
>   clk: sunxi-ng: add support for suniv F1C100s SoC
>   dt-bindings: sram: Add Allwinner suniv F1C100s
>   dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt
>   ARM: dts: suniv: add initial DTSI file for F1C100s
>   ARM: suniv: f1c100s: add device tree for Lichee Pi Nano
> 
>  Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
>  .../interrupt-controller/allwinner,sun4i-ic.txt    |   4 +-
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
>  .../devicetree/bindings/sram/sunxi-sram.txt        |   4 +
>  .../bindings/timer/allwinner,sun4i-timer.txt       |   4 +-
>  .../devicetree/bindings/watchdog/sunxi-wdt.txt     |   1 +
>  arch/arm/boot/dts/Makefile                         |   2 +
>  arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |  26 +
>  arch/arm/boot/dts/suniv-f1c100s.dtsi               | 147 ++++++
>  arch/arm/mach-sunxi/Kconfig                        |  19 +-
>  arch/arm/mach-sunxi/sunxi.c                        |  10 +
>  drivers/clk/sunxi-ng/Kconfig                       |   5 +
>  drivers/clk/sunxi-ng/Makefile                      |   1 +
>  drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           | 541 +++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |  34 ++
>  drivers/clocksource/sun4i_timer.c                  |   5 +-
>  drivers/irqchip/irq-sun4i.c                        | 106 ++--
>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c      | 416 ++++++++++++++++
>  include/dt-bindings/clock/suniv-ccu-f1c100s.h      |  70 +++
>  include/dt-bindings/reset/suniv-ccu-f1c100s.h      |  38 ++
>  23 files changed, 1408 insertions(+), 33 deletions(-)
>  create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
>  create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
>  create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
>  create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
>  create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h
> 
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
