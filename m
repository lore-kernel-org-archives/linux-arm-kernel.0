Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:54:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1E22192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BjQES9Qa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjIjzg8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1E22192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hD+2uo5ewZKvOPr45V0K2YdVw7x87EyyAhhacLayr74=; b=BjQES9QaAHPxy0
	uCtlFQKaZa7KhDoO1Xa2H1Zq36Uh7W54QMJ6XSAh46Qi926aAoAcuHfLzKfwTUc5I8k/ygheRUttT
	O9QBfemP6GgPlN4UntA0yjxGTmnA+3p8H9LSyjoE5u33eY0dPsjNA40vdMR3eaB8Ev9Z0C4rGf9ah
	GgxMAfqCqrjs71JZfez58Mi3+KGfdqnRCEYj6/B5DEhhsvIFKU1LV9MDZiFsWqai6oaMOtyel1kEY
	01dhC/33gcZIyRxr6A7QoF+KWks1ljMr2CxDkKFJu2f1cG29j1fvPHSpN/T5H3ceBhKPYc8nuR90s
	AHuISKmSsBTwuOkb/SjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaoHh-00014F-SW; Sat, 22 Dec 2018 20:54:09 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaoHe-00013Z-Vo
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 20:54:08 +0000
Received: by mail-it1-x142.google.com with SMTP id w18so11804622ite.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 22 Dec 2018 12:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kPnkkSLzGT9xUoB2g373U8D2o1yyW0DfX+mloyabfGQ=;
 b=CjIjzg8eozWF2FzgWPnKJmB9RGcdxxmr4/kL9xOg3aaKcXrj6K4pMGMKXpPRsuFwVH
 +L+xjXdBrCmPlvKwI/A0aOFgxGQgd5tGiEJ0hvJiPtI9lFOo+7Z7Lo5pMjZOCuIUnVlj
 iFuWIPhoLPn7HoVn86RBO2Op/74wAlT3HEiDA1QO+hO/KMBig7uy05IWN1G3gMOBgEjt
 53VEbL0YRIwcweze7js8IYMwp2+oUSPHFB5eVz/Y24kPnx8KPAy273e7rwjdHF703dAV
 /MaLyoqismKOTHE+XzBV9N5NOQzTTCJqAfPBwoPlENFb7dS5R2rgfpBKayul6OyOCStp
 8OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kPnkkSLzGT9xUoB2g373U8D2o1yyW0DfX+mloyabfGQ=;
 b=s0GUNHI38/xNWemB2ke/nRX9VmrtGN17Q5f+xeL2TS9eIg8+VV87B3uBBYmY+PeTNr
 rM31jn8IniKJWZjEhQH/N/SAQoBOcT1quaIq7F/6tuUNxcW3bldhK/iKZMyGgGO0uZco
 UZPUIFXhYcnPnCJh3xt67RuVxJWxgXPvqI96PAxYV1AnLIMfqI5siQKuxUZkUjSl6NOH
 Up/MdIOGlB3TuYjWEp+CzNyuPZZKRdm0qO3RyFDUGO3JGBGrFnC8gbu/YuuCllatnu7O
 0imdXrNbsBiOenS6hgo4kJlmmQnlR90fxAyYn+eXMsjnNOsvDxLki6dyTpkBsXtbBRz6
 CDJA==
X-Gm-Message-State: AA+aEWaNH39yz7rGeDKX2n8t9K9TvpVXXucOo1xTZc+YJt4Sevi5H68o
 nYM/3GPRvsN9iePLQw9/uUBtncPNJTGyiY3xWAQ=
X-Google-Smtp-Source: AFSGD/WLywQfjxIHFfccr/pAYGPX6bDXE9yo7MMi/4afnMNThPVQVqDZfd/0MyLHpOKsoti4N41NkOwysnurFlisIJg=
X-Received: by 2002:a02:8894:: with SMTP id n20mr5370245jaj.52.1545512033353; 
 Sat, 22 Dec 2018 12:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20181213230411.5009-1-tony@atomide.com>
In-Reply-To: <20181213230411.5009-1-tony@atomide.com>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 22 Dec 2018 14:53:42 -0600
Message-ID: <CAHCN7xJmde1RJOMMqexR0uNiVEYjztTV4qXvkcjqb+w7R1vmpA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: Add wlcore wakeirq for omap3-evm
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_125407_021536_21597169 
X-CRM114-Status: GOOD (  20.48  )
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
Cc: devicetree <devicetree@vger.kernel.org>, linux-omap@vger.kernel.org,
 =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 5:05 PM Tony Lindgren <tony@atomide.com> wrote:
>
> With wlcore supporting optional wakeirqs, let's configure it for
> omap3-evm and update the related pin muxing as some pins are left
> unmuxed.
>
> Let's configure a wakeirq both for the wlcore GPIO and the SDIO
> dat1 pin in case wlcore starts supporting SDIO dat1 interrupt at
> some point.
>
> Note that for off-mode, the wlcore reset GPIO will have a glitch
> meaning wlcore will reset. The only way to workaround for this
> currently is to configure the reset pin with SAFE_MODE + PULL.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap3-evm-common.dtsi           |  7 +++++--
>  arch/arm/boot/dts/omap3-evm-processor-common.dtsi | 10 +++++++++-
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
> --- a/arch/arm/boot/dts/omap3-evm-common.dtsi
> +++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
> @@ -122,6 +122,7 @@
>  };
>
>  &mmc2 {
> +       interrupts-extended = <&intc 86 &omap3_pmx_core 0x12e>;
>         vmmc-supply = <&wl12xx_vmmc>;
>         non-removable;
>         bus-width = <4>;
> @@ -132,8 +133,10 @@
>         wlcore: wlcore@2 {
>                 compatible = "ti,wl1271";
>                 reg = <2>;
> -               interrupt-parent = <&gpio5>;
> -               interrupts = <21 IRQ_TYPE_EDGE_RISING>; /* gpio 149 */
> +               /* gpio_149 with uart1_rts pad as wakeirq */
> +               interrupts-extended = <&gpio5 21 IRQ_TYPE_EDGE_RISING>,
> +                                     <&omap3_pmx_core 0x14e>;
> +               interrupt-names = "irq", "wakeup";


Tony,

Question...
I noticed for your patch, I noticed you listed both the IRQ, gpio 149
as well as uart1_rts.  Looking at the device tree, I see that
uart1_rts is configured as gpio 149.  I did a quick scan of other
boards, I haven't noticed other boards listing the same gpio twice,
once under IRQ and once under the pmx_core wakeup.  Is that something
we should do on other boards, or is that something unique to the
omap3-evm?

adam
>                 ref-clock-frequency = <38400000>;
>         };
>  };
> diff --git a/arch/arm/boot/dts/omap3-evm-processor-common.dtsi b/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
> --- a/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
> +++ b/arch/arm/boot/dts/omap3-evm-processor-common.dtsi
> @@ -86,6 +86,10 @@
>                         OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1.sdmmc2_dat1 */
>                         OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat2.sdmmc2_dat2 */
>                         OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat3.sdmmc2_dat3 */
> +                       OMAP3_CORE1_IOPAD(0x2164, PIN_OUTPUT | MUX_MODE1)       /* sdmmc2_dat4.sdmmc2_dir_dat0 */
> +                       OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE1)       /* sdmmc2_dat5.sdmmc2_dir_dat1 */
> +                       OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE1)       /* sdmmc2_dat6.sdmmc2_dir_cmd */
> +                       OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE1)        /* sdmmc2_dat7.sdmmc2_clkin */
>                 >;
>         };
>
> @@ -127,9 +131,13 @@
>                 >;
>         };
>
> +       /*
> +        * Note that gpio_150 pulled high with internal pull to prevent wlcore
> +        * reset on return from off mode in idle.
> +        */
>         wl12xx_gpio: pinmux_wl12xx_gpio {
>                 pinctrl-single,pins = <
> -                       OMAP3_CORE1_IOPAD(0x2180, PIN_OUTPUT | MUX_MODE4)               /* uart1_cts.gpio_150 */
> +                       OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT_PULLUP | MUX_MODE7)         /* uart1_cts.gpio_150 */
>                         OMAP3_CORE1_IOPAD(0x217e, PIN_INPUT | MUX_MODE4)                /* uart1_rts.gpio_149 */
>                 >;
>         };
> --
> 2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
