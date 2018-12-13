Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD9CC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:56:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF4C2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nFsQD8TP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PLhR+wSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF4C2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SsHcJe94WlgcfxJNr5t6G0QO5Acl2Ei2zP4ouc7NbzU=; b=nFsQD8TPuqE2KZ
	axfEy788Z9AlpToj2sv84E5lsdtDYQ6ZJzPp7QuOQmdgBJlyp7CORMCwkcofWynZYXcXV6HbqJQFk
	au5/wYhKkKeXUc8qp7lmOLiyqxP8om0AlekiMUSlccytvrYRhET1R6z4uL1qVxyEnaYrj/dqRuNto
	+KOxB63I6cRDI5RyRawVJj/Xdm5TVHCPkIiyzgLDKdpQ+lkr09ZXyP32O3CP4bhJ5iqIYb6dmFIaa
	q+pX78mtSHTh6BAJ4M2ftITISdOVVQnbWWbY5Zl9zmbJhOH+rLDfgVkKOKNqpJPP/D+kT/YdZCfC8
	Q4rgPjOM2R49W1/DxnaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXZuD-0006Ti-KW; Thu, 13 Dec 2018 22:56:33 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXZu8-0006Sq-C6
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 22:56:30 +0000
Received: by mail-qt1-x841.google.com with SMTP id v11so4237611qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 14:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nYHFtPjv8JQJBGdOBsFRXt5vPUKyqFq0Qftwn/agti4=;
 b=PLhR+wSfzhi2oPcg9PAxCb4AB4yL9BkMmkJCQ/GhC5lCVP8btRUZCBDpH5DP2XaOmF
 NGh3ydXwqxQk+4i9oi2JND/sUXlU6PBLGwZ61uLcVXjXUZPr7yrTsi6qQHNeNtajwuSd
 pB4fA930LJtOe8BZLOiWnmNVpfSgcXDuts/fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nYHFtPjv8JQJBGdOBsFRXt5vPUKyqFq0Qftwn/agti4=;
 b=Z7fE+MOlgy1XZrE/BwAivGBKAKC+1nFNAKqGL18JPPrZHeZnZVwZqOikpeB32w9m/z
 AqkNpz0+CvtTlXqDUcpb3ncV+NC+XNE2eLkvVmaVfnMYgtHRin6Eb6Vc4IM2SDKC+bE0
 AnRlMg9Us0a+XqKSAjGgbcyMep3bPjcvMRsrfd5RBHS9/Jgqlf3Z7gmT/ixxZ+BeSO2X
 dZKvjXvANOvUHH2Q6nLVFnzsuhpf/41UfS2FyN3lDbZqLYi8zzwrK8j+O0zTHBwcUuCu
 uhHS4wI7prW44NlcHQ4iENYegI6SHMUhpm7JeBmA+eLr9pss/Kq9A2pyg9Odf3rwzJSZ
 GBMw==
X-Gm-Message-State: AA+aEWYF9YrGMs6YAgw6b0nlrwSeVS+MFLk70iKSXGk8sXSHgP8ng154
 kyV07eGXN4FSE7CVeMUMDGLPp6rrL+gPYZeWLsg=
X-Google-Smtp-Source: AFSGD/XWEZGKKSBkptO8BO7oZ2mOY/V1j06P37FgMYeO07l+cUs2I2lrG/mM0lb5S/R9GqJrzL6QcPND2e+pZZMBO7c=
X-Received: by 2002:a0c:89b4:: with SMTP id 49mr652178qvr.85.1544741777010;
 Thu, 13 Dec 2018 14:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20181213195319.1333402-1-vijaykhemka@fb.com>
In-Reply-To: <20181213195319.1333402-1-vijaykhemka@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 14 Dec 2018 09:26:05 +1030
Message-ID: <CACPK8XfAXDHqWcD=OKm4UhCh-+-7GBxL02Fi9_jgdmo2ZQZSjg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
To: vijaykhemka@fb.com, Andrew Jeffery <andrew@aj.id.au>,
 Rob Herring <robh+dt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_145628_715775_20E6D887 
X-CRM114-Status: GOOD (  16.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 14 Dec 2018 at 06:23, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added ADC and other sensor devices in Facebook Tiogapass device tree.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  .../dts/aspeed-bmc-facebook-tiogapass.dts     | 33 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index f8e7b71af7e6..58bbe08d3ba7 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -21,6 +21,25 @@
>         memory@80000000 {
>                 reg = <0x80000000 0x20000000>;
>         };
> +
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               oemname0 = "MB_P3V3";
> +               oemname1 = "MB_P5V";
> +               oemname2 = "MB_P12V";
> +               oemname3 = "MB_P1V05";
> +               oemname4 = "MB_PVNN_PCH_STBY";
> +               oemname5 = "MB_P3V3_STBY";
> +               oemname6 = "MB_P5V_STBY";

"oemname" isn't part of the upstream bindings. Is this something you
have patches for?

The other parts of the patch lgtm.

> +               io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
> +                                       <&adc 4>, <&adc 5>, <&adc 6>;
> +       };
> +
> +       iio-hwmon-battery {
> +               oemname0 = "MB_P3V_BAT";
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc 7>;
> +       };
>  };
>
>  &fmc {
> @@ -64,6 +83,10 @@
>         use-ncsi;
>  };
>
> +&adc {
> +       status = "okay";
> +};
> +
>  &i2c0 {
>         status = "okay";
>         //Airmax Conn B, CPU0 PIROM, CPU1 PIROM
> @@ -122,6 +145,10 @@
>
>  &i2c8 {
>         status = "okay";
> +       tmp421@1f {
> +               compatible = "ti,tmp421";
> +               reg = <0x1f>;
> +       };
>         //Mezz Sensor SMBus
>  };
>
> @@ -134,13 +161,15 @@
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> +       oemname0 = "System_Fan_Connector_1";
> +       oemname1 = "System_Fan_Connector_3";
>         fan@0 {
>                 reg = <0x00>;
>                 aspeed,fan-tach-ch = /bits/ 8 <0x00>;
>         };
>
>         fan@1 {
> -               reg = <0x00>;
> -               aspeed,fan-tach-ch = /bits/ 8 <0x01>;
> +               reg = <0x01>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x02>;
>         };
>  };
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
