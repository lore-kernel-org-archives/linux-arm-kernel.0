Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9D7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:25:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B7320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="on4sPrUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B7320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/v7oWNn92V3qL+xsc+qj8ggC1wky+i0YmbcQ59NTdLs=; b=on4sPrUQvATcTD
	zbtvAdCWO4SKKQ9W6ARHwfLC+B/u5OI/D6qkhpH6C1rh2RWF8Xarg/L+3GHg7QhgrUDgYm1UTcm6l
	TfLVUbEhFzwXTfq2zuMAPz4bD7V/0ye3J8z9i5Nh/OQisWPn8CA+m3p1YgAyF3e7tJrzsuA46/JC2
	HYVthGI8oHnioTmzo0NONAeYedL/E/6YPMZdwkBeOu6ZF9HBzYOxq4utnsWUOaSpW5iEeKlIHI6Vo
	45xeOIvhI+TzooyMoJ5w/gOfCKhDjsEV/PVBXV8xSep4ISu8osg11vDcDVoLEB/LbWZ4WPtBp0nGR
	0sCaFbjWUWDbRPpDnVZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjYD-0007pz-DZ; Mon, 03 Dec 2018 08:25:57 +0000
Received: from mail-vk1-f194.google.com ([209.85.221.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjYA-0007pO-BP
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:25:55 +0000
Received: by mail-vk1-f194.google.com with SMTP id q80so2672670vka.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 00:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vHXSL1YDJInCiqjXbOl5t6lu6nA1FRGujW5SH3cis30=;
 b=TtFsvIIx1kM0Irmpc7YPXtqb3KciJUt/obS/h89bGd9zQCuEu5rn2H4qc4k/cDWNzC
 L72c9fG4PTCUbWXSMrojJz1/yn4AYU05Xc/2YlQoZleNw+wkSdueLlAzIlREPxddSwqh
 lVZSrh+MlJhg5t0XALjy1vrTRveztE6z0oQP5azWQEoRhImKN9FNvjoyDqngvWZLkSBs
 a/Y/Xff7nSQD5MjqsqC7vE3JviXxsTY3im5qCCxIVlmSZnvi+YqvuecdolvlyA/Se+ET
 7lwL98bloohDMN4YZOQxYB8/+4pSiIpI9riptXtSjGrfIpTpTlotH6n/ES4toHc3zMl4
 PvIw==
X-Gm-Message-State: AA+aEWbgRELwjiv5GMxg0QBdyW1nNPLqljUfvEbE6GBhZBuOpmfhpxE0
 5mGobdH3+QTEC4fKN3EKPCgMGQLsvJMw13lvwos=
X-Google-Smtp-Source: AFSGD/WQjKRL/n0D+7mJBAZ9JT1/c7puNZ77LttIk5gUue8s5GnwmOKIdcBi1KNa26FN3gjxJdGrSJc6tm8gqzNk7iM=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr6553367vkh.65.1543825542794; 
 Mon, 03 Dec 2018 00:25:42 -0800 (PST)
MIME-Version: 1.0
References: <1543675408-11382-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1543675408-11382-1-git-send-email-ykaneko0929@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Dec 2018 09:25:30 +0100
Message-ID: <CAMuHMdXvGEZpuDr6oWH0QGxVtfx-EUiQJ+_Jt33dZhn_Lw4EYQ@mail.gmail.com>
Subject: Re: [PATCH/RFT] arm64: dts: renesas: r8a77990-ebisu: Add BD9571 PMIC
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_002554_394930_3320FBB1 
X-CRM114-Status: GOOD (  16.38  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>, Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kaneko-san,

On Sat, Dec 1, 2018 at 3:43 PM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds the regulator definition required for operation of
> S2RAM.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> @@ -425,6 +425,26 @@
>         };
>  };
>
> +&i2c_dvfs {
> +       status = "okay";
> +
> +       clock-frequency = <400000>;
> +
> +       pmic: pmic@30 {
> +               pinctrl-0 = <&irq0_pins>;
> +               pinctrl-names = "default";
> +
> +               compatible = "rohm,bd9571mwv";
> +               reg = <0x30>;
> +               interrupt-parent = <&intc_ex>;
> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               gpio-controller;
> +               #gpio-cells = <2>;

Just adding this node is not sufficient to make S2RAM work.
As per Documentation/devicetree/bindings/mfd/bd9571mwv.txt, you also have
to describe the DDR-Backup Power configuration.

On the Ebisu-4D development board, only the DDR0 power rail is used, and
needs to be kept powered when backup mode is enabled.

        rohm,ddr-backup-power = <0x1>;
        rohm,rstbmode-level;

Unfortunately resume from s2ram doesn't work with this, probably due to an
issue in ATF.  This may have been fixed in IPL and Secure Monitor Rev1.0.22,
which claims to add support for the Ebisu-4D board.

I don't know if plain Ebisu needs a different configuration.

> +       };
> +};
> +
>  &lvds0 {
>         status = "okay";
>

The rest is fine, hence with the above fixed and tested:

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
