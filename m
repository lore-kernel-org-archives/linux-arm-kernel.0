Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D74C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:34:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC3820818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s4hj035j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC3820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PSnO61L7zOqkPWV9jhK0Yj862LN7fEgsBQLeEo+x//g=; b=s4hj035jwseGtr
	UU72OAR9mEMC1VV710G/2/AWM8f7wd8Hqe98fd7wWsfaBquxwq9HCDqOXNx+xLMiQ5d1w2LgbDBiE
	Vw15/5lyDgRM4ncmLmXDdgJU1PBX0hn/jAx8e2/n4c0rbO9NTmJfBrA4naLRnwK2YUk6UFaghD2T/
	Zz5HgSWe4Iy/DpSXi9HnrxS++WvVlaQqitmPxD9AX3vR3NJVU7v9DFfv6LyPA0dRAhzyIJVvcEeT+
	c3hmrmJiAt3bxZsdeHKfUaFO8ssxPXXgNl6spCoaFYQS4+9xb21Uy3MQFQfJwcQ5DD9I067p6N+fn
	wvJ6Dhk2Ys2yEbA/tZDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAmr-0006w6-Gf; Mon, 11 Feb 2019 12:34:13 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAls-00061u-Kf; Mon, 11 Feb 2019 12:34:08 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gtAlp-0004HU-9q; Mon, 11 Feb 2019 13:33:09 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Add on-board WiFi/BT support for
 Rock960 boards
Date: Mon, 11 Feb 2019 13:33:08 +0100
Message-ID: <10789434.psaOHqdiec@diego>
In-Reply-To: <20190211113128.GA22843@mani>
References: <20190207055349.27919-1-manivannan.sadhasivam@linaro.org>
 <CALeDE9MNa+CDJR8bvS05f2UTKrhwMRo8jzdS5o8Ndu7H8V8Ldg@mail.gmail.com>
 <20190211113128.GA22843@mani>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_043313_529885_BFC100A8 
X-CRM114-Status: GOOD (  24.43  )
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
Cc: tom@vamrs.com, mani@kernel.org, linux-kernel@vger.kernel.org, dev@vamrs.com,
 linux-rockchip@lists.infradead.org, Peter Robinson <pbrobinson@gmail.com>,
 ezequiel@collabora.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Montag, 11. Februar 2019, 12:31:28 CET schrieb Manivannan Sadhasivam:
> Hi Peter,
> 
> On Fri, Feb 08, 2019 at 04:45:01PM +0000, Peter Robinson wrote:
> > Hi Mani,
> > 
> > On Thu, Feb 7, 2019 at 5:54 AM Manivannan Sadhasivam
> > 
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > Add on-board WiFi/BT support for Rock960 boards such as Rock960 based
> > > on AP6356S and Ficus based on AP6354 wireless modules.
> > > 
> > > Firmwares for the respective boards are available here:
> > > 
> > > http://people.linaro.org/~manivannan.sadhasivam/rock960_wifi/
> > > http://people.linaro.org/~manivannan.sadhasivam/ficus_wifi/
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > There's some warnings on building these I noticed in testing this on 
Fedora:
> >   DTC     arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb
> > 
> > arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:490.3-13: Warning
> > (reg_format): /dwmmc@fe310000/wifi@1:reg: property has invalid length
> > (4 bytes) (#address-cells == 2, #size-cells == 1)
> > arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning
> > (pci_device_bus_num): Failed prerequisite 'reg_format'
> > arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning (i2c_bus_reg):
> > Failed prerequisite 'reg_format'
> > arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning (spi_bus_reg):
> > Failed prerequisite 'reg_format'
> > arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
> > (avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
> > #address-cells value
> > arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
> > (avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
> > #size-cells value
> > 
> >   DTC     arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb
> > 
> > arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:490.3-13: Warning
> > (reg_format): /dwmmc@fe310000/wifi@1:reg: property has invalid length
> > (4 bytes) (#address-cells == 2, #size-cells == 1)
> > arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
> > (pci_device_bus_num): Failed prerequisite 'reg_format'
> > arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
> > (i2c_bus_reg): Failed prerequisite 'reg_format'
> > arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
> > (spi_bus_reg): Failed prerequisite 'reg_format'
> > arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
> > (avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
> > #address-cells value
> > arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
> > (avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
> > #size-cells value
> 
> Hmm. Since the parent node "sdio0" is missing the address/size cells
> property, the default value has been used by the DTC. I think it would
> make sense to just drop the reg property from "wifi" node instead of
> modifying the parent "sdio0" node.
> 
> If no one has any issue over this, I'll send out another revision with the
> reg property removed.

actually I do think you might just want to add address+size-cells
to your &sdio0 instance instead. Especially as I'm not sure that the
system will find the card-node when matching against the card itself
without the reg property?

The core sdio0 does not necessarily have subnodes, so I guess
the *-cells may just live in the board dts?


Heiko



> > > ---
> > > 
> > >  .../boot/dts/rockchip/rk3399-rock960.dtsi     | 96 ++++++++++++++++++-
> > >  1 file changed, 95 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi index
> > > 56abbb08c133..1b2f7cd82244 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > > @@ -9,6 +9,15 @@
> > > 
> > >  #include "rk3399-opp.dtsi"
> > >  
> > >  / {
> > > 
> > > +       sdio_pwrseq: sdio-pwrseq {
> > > +               compatible = "mmc-pwrseq-simple";
> > > +               clocks = <&rk808 1>;
> > > +               clock-names = "ext_clock";
> > > +               pinctrl-names = "default";
> > > +               pinctrl-0 = <&wifi_enable_h>;
> > > +               reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> > > +       };
> > > +
> > > 
> > >         vcc1v8_s0: vcc1v8-s0 {
> > >         
> > >                 compatible = "regulator-fixed";
> > >                 regulator-name = "vcc1v8_s0";
> > > 
> > > @@ -362,6 +371,20 @@
> > > 
> > >  };
> > >  
> > >  &pinctrl {
> > > 
> > > +       bt {
> > > +               bt_enable_h: bt-enable-h {
> > > +                       rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO
> > > &pcfg_pull_none>; +               };
> > > +
> > > +               bt_host_wake_l: bt-host-wake-l {
> > > +                       rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO
> > > &pcfg_pull_none>; +               };
> > > +
> > > +               bt_wake_l: bt-wake-l {
> > > +                       rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO
> > > &pcfg_pull_none>; +               };
> > > +       };
> > > +
> > > 
> > >         sdmmc {
> > >         
> > >                 sdmmc_bus1: sdmmc-bus1 {
> > >                 
> > >                         rockchip,pins =
> > > 
> > > @@ -387,6 +410,26 @@
> > > 
> > >                 };
> > >         
> > >         };
> > > 
> > > +       sdio0 {
> > > +               sdio0_bus4: sdio0-bus4 {
> > > +                       rockchip,pins =
> > > +                               <2 20 RK_FUNC_1 &pcfg_pull_up_20ma>,
> > > +                               <2 21 RK_FUNC_1 &pcfg_pull_up_20ma>,
> > > +                               <2 22 RK_FUNC_1 &pcfg_pull_up_20ma>,
> > > +                               <2 23 RK_FUNC_1 &pcfg_pull_up_20ma>;
> > > +               };
> > > +
> > > +               sdio0_cmd: sdio0-cmd {
> > > +                       rockchip,pins =
> > > +                               <2 24 RK_FUNC_1 &pcfg_pull_up_20ma>;
> > > +               };
> > > +
> > > +               sdio0_clk: sdio0-clk {
> > > +                       rockchip,pins =
> > > +                               <2 25 RK_FUNC_1 &pcfg_pull_none_20ma>;
> > > +               };
> > > +       };
> > > +
> > > 
> > >         pmic {
> > >         
> > >                 pmic_int_l: pmic-int-l {
> > >                 
> > >                         rockchip,pins =
> > > 
> > > @@ -403,6 +446,19 @@
> > > 
> > >                                 <1 14 RK_FUNC_GPIO &pcfg_pull_down>;
> > >                 
> > >                 };
> > >         
> > >         };
> > > 
> > > +
> > > +       sdio-pwrseq {
> > > +               wifi_enable_h: wifi-enable-h {
> > > +                       rockchip,pins =
> > > +                               <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> > > +               };
> > > +       };
> > > +
> > > +       wifi {
> > > +               wifi_host_wake_l: wifi-host-wake-l {
> > > +                       rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO
> > > &pcfg_pull_none>; +               };
> > > +       };
> > > 
> > >  };
> > >  
> > >  &pwm2 {
> > > 
> > > @@ -413,6 +469,33 @@
> > > 
> > >         status = "okay";
> > >  
> > >  };
> > > 
> > > +&sdio0 {
> > > +       clock-frequency = <50000000>;
> > > +       bus-width = <4>;
> > > +       cap-sdio-irq;
> > > +       cap-sd-highspeed;
> > > +       no-emmc;
> > > +       keep-power-in-suspend;
> > > +       mmc-pwrseq = <&sdio_pwrseq>;
> > > +       non-removable;
> > > +       num-slots = <1>;
> > > +       pinctrl-names = "default";
> > > +       pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> > > +       sd-uhs-sdr104;
> > > +
> > > +       status = "okay";
> > > +
> > > +       brcmf: wifi@1 {
> > > +               compatible = "brcm,bcm4329-fmac";
> > > +               reg = <1>;
> > > +               interrupt-parent = <&gpio0>;
> > > +               interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> > > +               interrupt-names = "host-wake";
> > > +               pinctrl-names = "default";
> > > +               pinctrl-0 = <&wifi_host_wake_l>;
> > > +       };
> > > +};
> > > +
> > > 
> > >  &sdhci {
> > >  
> > >         bus-width = <8>;
> > >         mmc-hs400-1_8v;
> > > 
> > > @@ -439,8 +522,19 @@
> > > 
> > >  &uart0 {
> > >  
> > >         pinctrl-names = "default";
> > > 
> > > -       pinctrl-0 = <&uart0_xfer &uart0_cts>;
> > > +       pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> > > 
> > >         status = "okay";
> > > 
> > > +
> > > +       bluetooth {
> > > +               compatible = "brcm,bcm43438-bt";
> > > +               clocks = <&rk808 1>;
> > > +               clock-names = "ext_clock";
> > > +               device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> > > +               host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> > > +               shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> > > +               pinctrl-names = "default";
> > > +               pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> > > +       };
> > > 
> > >  };
> > >  
> > >  &uart2 {
> > > 
> > > --
> > > 2.17.1





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
