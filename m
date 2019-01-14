Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810C9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:55:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3772086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eOzb6GHM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q+I4rAox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3772086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:In-reply-to:Subject:To:
	From:References:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uq4uPFJW05qwlafjs5a+nr94u5kF8f8n8vm28yg+QRM=; b=eOzb6GHM5xGvh2Sv2tdt1LEfF
	O4yz3r/yj+G1nzYsrTcjl+IrSMkdN6tM7CWX2GGUeZJzjOMa13+LwaIhcrQ4CXKLkhJ/1jnwCrUOh
	fEaiZ3T3pneOzKq5Iy1GHg54Wq/mR0uB+29E88zHUH334xlOvJjqsai8mPW6XprC1jJfTq0o24iZf
	x3izZx/r8CEXSpABwkFKkxbzUg1I5c5W1fuYnDB5W/Cu8UNi/wrVBDM2DZyGQWMzb4Q4Y7y4h7Wgs
	FygkyhxxYXxYNmStc/zR1MeBzFci7UZBuUrqhD0qIC0ehlQ+pVgyxYR4ig7l+qF44t2Cbs5MAgV57
	SnyhA63Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj3do-0007u2-6h; Mon, 14 Jan 2019 14:55:04 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj3di-0007es-UR
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 14:55:01 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so9230956wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=dUKtJ0j5SOTZ8jJQ2h3d355rKTwlx53nMkQo87lwwho=;
 b=Q+I4rAoxWfiwNcw4eJ5LNisFV+V93y0bjr0VIOJ91pFqlfip9teIA4v4DorELVatbt
 A/8PBVHr6Atz3jPkoOAEDf8tFlg7rZ8AH4LlkpRefLbxa7cLYks1iEDxXb1yRPm+huIz
 iv1adYxzWjOkR31eGfDYZbVlv8M6KoQ56i5L8t4mOyfNIYxSyC4H9Q1Mha+TtS+FBKLU
 V4zLNeMIFt01Aho3sOeEWBHnez60TimaOng/baxGn1GILOQ7kGkETRdvhmxmx+gHXTGz
 9lo5aQZXw1ouafo4KkC+oDFrSuyX/yvze50/JxvBhXjPMP5a7Z9O+pqOppdRzVscfRHp
 Oy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=dUKtJ0j5SOTZ8jJQ2h3d355rKTwlx53nMkQo87lwwho=;
 b=dN7nrhYaE/9oDC7aEo1/qEZUok5FVy+n7K3kKlkPHkz/f+jJmiXP33x6641b8x5M7X
 8SwyOaoO17+CCn7QLLHLPlGFNyMk/Pg4Hv6NSfXTioamd3yHSsXQbsB2Evm3jmm55D3T
 MOZmqslgSClglwsOLmbeCc0nU9jAHK0Z7YRXrMqTBxAi9B8KtKerLoCw3DnvcywsM8n2
 3V7g3nYsP5nLMdRTONxTyI28MU0FbiopOnx4dZNZh6Px1Aqb1ueN9tj4/xW2SaNoGIgq
 1qgB/G24BqN9bNMTLn4xoG5qe5vZJ0iziJzYyzZlwd5w+43YHpXD/0QwY+21FVtBUtHb
 9aow==
X-Gm-Message-State: AJcUukdZtwW1C13I4RHSTSTOvKkOiWxVNfoNHDLndaIzgJ7HixAmKju7
 IWNzWn+I61YelK4qIGfzkFd1xA==
X-Google-Smtp-Source: ALg8bN5yT0+tLutbIiD/RqooYANaNjtiE2XDSHwIElREg/SKxQEMRBnIMw4e3CiMNCZ8EjNAAu+NEA==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr12136175wmf.3.1547477697115; 
 Mon, 14 Jan 2019 06:54:57 -0800 (PST)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id l15sm60070983wrw.4.2019.01.14.06.54.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 06:54:56 -0800 (PST)
References: <1547477061-31543-1-git-send-email-lollivier@baylibre.com>
User-agent: mu4e 1.0; emacs 25.3.2
From: Loys Ollivier <lollivier@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v4] arm64: dts: meson: Fix mmc cd-gpios polarity
In-reply-to: <1547477061-31543-1-git-send-email-lollivier@baylibre.com>
Date: Mon, 14 Jan 2019 15:54:54 +0100
Message-ID: <86zhs3l269.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_065459_042986_72F58D7C 
X-CRM114-Status: GOOD (  15.09  )
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
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Loys Ollivier <lollivier@baylibre.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


Martin,

On Mon 14 Jan 2019 at 14:44, Loys Ollivier wrote:

> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> changed the behavior of "cd-inverted" to follow the device tree bindings
> specification:
> According to SDHCI standard, CD lines are specified as "active low".
> Using the "cd-inverted" property means that the CD line is "active high".
>
> Fix the SD card description for meson by setting the cd-gpios as
> "active low", according to the boards specifications, and dropping the
> "cd-inverted" property.
>
I understood your point on the double op making it a no-op. I chose not
to mention it as it can be somewhat misleading on the reason of this
patch.
That DT code is probably how you found the no-op bug. And that's how I
noticed that the SD description was not perfect.

But imho, that is not why the DTs should be changed. The main
reason is because the previous description is not configuring the CD
lines correctly, according to the specification.

I hope this version is fine for everyone :)
> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
>
> v4: commit message clarification on the "cd-inverted" property and usage.
>
> v3: fix typos in the commit message.
>
> v2: fix more occurences, also in other meson boards.
>
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi              | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts          | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             | 3 +--
>  14 files changed, 14 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi 
> b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> index e14e0ce7e89f..016641a41694 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> @@ -187,8 +187,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> index 8cd50b75171d..ade2ee09ae96 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> @@ -305,8 +305,7 @@
>  	max-frequency = <200000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddio_ao3v3>;
>  	vqmmc-supply = <&vddio_tf>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> index 4cf7f6e80c6a..25105ac96d55 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> @@ -238,8 +238,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 2e1cd5e3a246..1cc9dc68ef00 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -258,8 +258,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&tflash_vdd>;
>  	vqmmc-supply = <&tf_io>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> index ce862266b9aa..0be0f2a5d2fe 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> @@ -196,8 +196,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> index 93a4acf2c46c..ad4d50bd9d77 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> @@ -154,8 +154,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vcc_3v3>;
>  };
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi 
> b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> index ec09bb5792b7..2d2db783c44c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> @@ -211,8 +211,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vcc_3v3>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
> index f1c410e2da2b..796baea7a0bf 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
> @@ -131,8 +131,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> index db293440e4ca..255cede7b447 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> @@ -238,8 +238,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vcc_3v3>;
>  	vqmmc-supply = <&vcc_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
> index 6739697be1de..9cbdb85fb591 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
> @@ -183,8 +183,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi 
> b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> index a1b31013ab6e..bc811a2faf42 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> @@ -137,8 +137,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 3c3a667a8df8..3f086ed7de05 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -356,8 +356,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> index f7a1cffab4a8..8acfd40090d2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> @@ -147,8 +147,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts 
> b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> index 7212dc4531e4..7fa20a8ede17 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> @@ -170,8 +170,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;


-- 
-L

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
