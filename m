Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14C1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:17:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F6F2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IEuTHxWN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="b06qnl8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F6F2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T41RpuEVkvWFwNhiRSUP8leQFhWTIteZb+472fdbOoo=; b=IEuTHxWNOvkBva
	uaShjaxkgybZaImLOYv+tQ13hrRzkAKZhfmIhkxI/m5J24qiyW1EXj6VPNZ/ukP1HMlqy6PG9gU2+
	87AIu0oPJ9bcz3YshF6MCivAp/CptfHT6Zg+45d9xyDtkVQ1/qwMHVaTnp4DX+eHuhIxUidP4Bbt8
	TaJANea7kFcanwSh+foOOuXJafh8zeiAQ85ZXrVU0+J19RH17Q4LrhADe7SlT+53yKAOPF+kZ6DJh
	VNASDrztzYTw7AjfwhxxtMxS4h1y0Id2Y2BiNSc9eHsQrfxfG1jhME6Gvod3Uxj7byg532tbPZN2n
	3fH2vHDVzxcrJhT+LRnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxK4C-000254-6h; Fri, 22 Feb 2019 23:17:16 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxK48-00023Y-Kk
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 23:17:14 +0000
Received: by mail-lf1-x142.google.com with SMTP id e27so2944030lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 15:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QVA5AzqZXjoEZrnV/wDb3648VGZnrciSCRyMN8afaEI=;
 b=b06qnl8+NxU0DFRKXfrkRf89dNhg2oEWtuDsDM1SAX3FlBjMBeRHbuzEPwov6IPXxB
 ys/bOhRH/ce6+jSAWumO0o+FOKFTIT9o/xdPVqWyTCr3F0ifZMcf+GnMFVAQN8pjiRQm
 cVRbXjzjEtbmH+oc+koPHed/GuPZ23SPXdqS0WP2NHr3tEQs+LUQCDwHjd71egu4aq+E
 BYSZnDi+7PALKXd/TiYzbBeJCXvOdTo8NAUrjgJ+0cBuV1JblRz5ghXdQ2Nzr65UIxmV
 0Xfx1Y/3KgFXJBN1B/M1cvTMDyoVLNNPZiAs+qIXxwRijjQtaeiane9d66kdVwsf+aUM
 63Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QVA5AzqZXjoEZrnV/wDb3648VGZnrciSCRyMN8afaEI=;
 b=ODF230R4aOBaVIZIJXX3G3kRuV9BF8n2BM8F9zwZBiwQCHtwEcvCqjZ1gAv+8WHbrX
 9TeVv0y0ptl2bIkk4jVkl66cwN5DuB+6xtn5TzwTk5nxmDPSPDCfyLeE8TFGJuv6KE9M
 E+LAFdWbdWC8+wdxFABw76jhmoTTg01Q9YIISX82z0X2by+XxfMly8c/OVUsUqyNg0Sw
 Rt07Nja6u95zOLHFibu3cDCipUaMjv9d/GFYwIAh875ZPLcHPCTh1A4UmYOKAWo7u3tq
 Caon4HuU427dCewlK0dISL3+wl1EiIQrnxEfXz3PF1T/vqJ/iapT5WYFvzqaquCGYrOh
 /XkQ==
X-Gm-Message-State: AHQUAub+c5jqP8ycO0WChj4Yi0bErRB9QSZ7sps2kB9/Ox4w1DQiWX7X
 FDQGcYhqpLs4lqhnKMubmmMc1CqPv0H6XIW/y9piFg==
X-Google-Smtp-Source: AHgI3IYxYgwN64NEcMkPWmYeD4yKD23EGN/aBuTZ0FgXvYhV6n/aP6dHDRihRHGlzXr8LvRoqdDkhOS5ZGT/cYxoQSI=
X-Received: by 2002:ac2:52b7:: with SMTP id r23mr4159046lfm.66.1550877424745; 
 Fri, 22 Feb 2019 15:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20190222003403.128243-1-briannorris@chromium.org>
 <20190222003403.128243-3-briannorris@chromium.org>
 <20190222182740.GC223791@google.com>
In-Reply-To: <20190222182740.GC223791@google.com>
From: Rajat Jain <rajatja@google.com>
Date: Fri, 22 Feb 2019 15:16:27 -0800
Message-ID: <CACK8Z6ErHe3jJK7rVFA65BmJ_T9p1UcbXZWOdHJ0THXsVYk5Cg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: move QCA6174A wakeup pin into
 its USB node
To: Matthias Kaehlcke <mka@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_151712_684911_FF9BB7A6 
X-CRM114-Status: GOOD (  26.27  )
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
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 Bluez mailing list <linux-bluetooth@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>, Brian Norris <briannorris@chromium.org>,
 Douglas Anderson <dianders@chromium.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-arm-kernel@lists.infradead.org, Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 10:27 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Thu, Feb 21, 2019 at 04:34:03PM -0800, Brian Norris wrote:
> > Currently, we don't coordinate BT USB activity with our handling of the
> > BT out-of-band wake pin, and instead just use gpio-keys. That causes
> > problems because we have no way of distinguishing wake activity due to a
> > BT device (e.g., mouse) vs. the BT controller (e.g., re-configuring wake
> > mask before suspend). This can cause spurious wake events just because
> > we, for instance, try to reconfigure the host controller's event mask
> > before suspending.
> >
> > We can avoid these synchronization problems by handling the BT wake pin
> > directly in the btusb driver -- for all activity up until BT controller
> > suspend(), we simply listen to normal USB activity (e.g., to know the
> > difference between device and host activity); once we're really ready to
> > suspend the host controller, there should be no more host activity, and
> > only *then* do we unmask the GPIO interrupt.
> >
> > This is already supported by btusb; we just need to describe the wake
> > pin in the right node.
> >
> > We list 2 compatible properties, since both PID/VID pairs show up on
> > Scarlet devices, and they're both essentially identical QCA6174A-based
> > modules.
> >
> > Also note that the polarity was wrong before: Qualcomm implemented WAKE
> > as active high, not active low. We only got away with this because
> > gpio-keys always reconfigured us as bi-directional edge-triggered.
> >
> > Finally, we have an external pull-up and a level-shifter on this line
> > (we didn't notice Qualcomm's polarity in the initial design), so we
> > can't do pull-down. Switch to pull-none.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>

If it matters, LGTM.

Reviewed-by: Rajat Jain <rajatja@google.com>

> > ---
> > This patch is also required to make this stable, but since it's not
> > really tied to the device tree, and it's an existing bug, I sent it
> > separately:
> >
> >   https://lore.kernel.org/patchwork/patch/1044896/
> >   Subject: Bluetooth: btusb: request wake pin with NOAUTOEN
> >
> >  .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 13 ++++++
> >  .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 46 ++++++++++++-------
> >  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 13 ------
> >  3 files changed, 42 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> > index c400be64170e..931640e9aed4 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> > @@ -200,6 +200,19 @@
> >               pinctrl-0 = <&bl_en>;
> >               pwm-delay-us = <10000>;
> >       };
> > +
> > +     gpio_keys: gpio-keys {
> > +             compatible = "gpio-keys";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&bt_host_wake_l>;
> > +
> > +             wake_on_bt: wake-on-bt {
> > +                     label = "Wake-on-Bluetooth";
> > +                     gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <KEY_WAKEUP>;
> > +                     wakeup-source;
> > +             };
> > +     };
> >  };
> >
> >  &ppvar_bigcpu {
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> > index fc50b3ef758c..3e2196c08473 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> > @@ -175,6 +175,21 @@
> >               pinctrl-0 = <&dmic_en>;
> >               wakeup-delay-ms = <250>;
> >       };
> > +
> > +     gpio_keys: gpio-keys {
> > +             compatible = "gpio-keys";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pen_eject_odl>;
> > +
> > +             pen-insert {
> > +                     label = "Pen Insert";
> > +                     /* Insert = low, eject = high */
> > +                     gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <SW_PEN_INSERTED>;
> > +                     linux,input-type = <EV_SW>;
> > +                     wakeup-source;
> > +             };
> > +     };
> >  };
> >
> >  /* pp900_s0 aliases */
> > @@ -328,20 +343,6 @@ camera: &i2c7 {
> >               <400000000>;
> >  };
> >
> > -&gpio_keys {
> > -     pinctrl-names = "default";
> > -     pinctrl-0 = <&bt_host_wake_l>, <&pen_eject_odl>;
> > -
> > -     pen-insert {
> > -             label = "Pen Insert";
> > -             /* Insert = low, eject = high */
> > -             gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> > -             linux,code = <SW_PEN_INSERTED>;
> > -             linux,input-type = <EV_SW>;
> > -             wakeup-source;
> > -     };
> > -};
> > -
> >  &i2c_tunnel {
> >       google,remote-bus = <0>;
> >  };
> > @@ -437,8 +438,19 @@ camera: &i2c7 {
> >       status = "okay";
> >  };
> >
> > -&wake_on_bt {
> > -     gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> > +&usb_host0_ohci {
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
> > +
> > +     qca_bt: bt@1 {
> > +             compatible = "usb0cf3,e300", "usb04ca,301a";
> > +             reg = <1>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&bt_host_wake_l>;
> > +             interrupt-parent = <&gpio1>;
> > +             interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> > +             interrupt-names = "wakeup";
> > +     };
> >  };
>
> I didn't know it was possible to configure (certain) USB devices
> through the DT, neat!
>
> >
> >  /* PINCTRL OVERRIDES */
> > @@ -455,7 +467,7 @@ camera: &i2c7 {
> >  };
> >
> >  &bt_host_wake_l {
> > -     rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_up>;
> > +     rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_none>;
> >  };
> >
> >  &ec_ap_int_l {
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > index ea607a601a86..da03fa9c5662 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > @@ -269,19 +269,6 @@
> >               #clock-cells = <0>;
> >       };
> >
> > -     gpio_keys: gpio-keys {
> > -             compatible = "gpio-keys";
> > -             pinctrl-names = "default";
> > -             pinctrl-0 = <&bt_host_wake_l>;
> > -
> > -             wake_on_bt: wake-on-bt {
> > -                     label = "Wake-on-Bluetooth";
> > -                     gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> > -                     linux,code = <KEY_WAKEUP>;
> > -                     wakeup-source;
> > -             };
> > -     };
> > -
> >       max98357a: max98357a {
> >               compatible = "maxim,max98357a";
> >               pinctrl-names = "default";
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
