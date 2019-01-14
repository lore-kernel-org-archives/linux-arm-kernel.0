Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368FDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:02:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0352086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ob2Yr4qY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u6LF4EnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0352086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8UXIl2c1JnFcVu19p7pb+ib5QuVRxL70lt5SGzNUOfs=; b=Ob2Yr4qYdpYOOp
	dFwd/KdFQ8T0LDbrSg/ANcbGy+DCWDpEnaQixGy0fqc7KROLoNJYKY683Sxoo3mnDZkdUpRo7Ukwr
	dpFRXg1ApQAvZvGZ+u38B2/50pbhf5u84e7K7BVZiYLJrvdgI5bbefQUOr2ff2j47HZMRh5o5rxED
	TLew63jGNDDJile66W2NXPHBBZhJOJmhw8tv7uRSx1qfcrou8n4GmyxzKNTgRNc7nSNErDJn8eOLX
	qrxGO2jf+skdrvLJ0pKrDku5Gp4ZEmYhtT3GlDbbPFQmmRXvANVXdNLSDxfZDeKz3lVnbbkx0pUpa
	r7umnT7Wy3xaobXpPLMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj4gg-0002X9-Ls; Mon, 14 Jan 2019 16:02:06 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj4gb-0002Vt-5I
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:02:04 +0000
Received: by mail-pf1-x444.google.com with SMTP id c73so10521741pfe.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=gxQ9Aw15DeoI4moC2VJqIEkTVG5aPdFcj18MDxQPjp8=;
 b=u6LF4EnMcOiNZleiyUm60OYosTyyMBuTJkgzetBREixHUihHy64QhffGHhRwVYZOgn
 713kL5F9xO9dm89eF9WjAHzRAo9ySU30/Xor0qQgljNkKYtirlBr2ctPAKNtRyu3GZ0g
 0lu9ZM3YTFTMje+A5P2sB32oliaBRbEHr9cvFx1wmBQ/pxXarJjPUN+xQKGCEmsNbsNr
 xFsYBusxfz0mf+1RZ0NRi3aDJa+eB2wXksZzBvsBggLpJXs+aB5ya90qjxEH/rAsbNZH
 MqZiodIr8P1grE54/VuD2RiwDlRCr6hvQXvqXHfxEZQshHJlLluiltwfu7OAyQMkKI4J
 u62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=gxQ9Aw15DeoI4moC2VJqIEkTVG5aPdFcj18MDxQPjp8=;
 b=mP2JOurkZ1C5sCecqUML50+KQT9IEEB3E/48thFcK1Er6E9zXBWWzD67ef5t8YpnOK
 BDpFQs/mNk5IgSIEl7oUT+2RN0VWvzRxxHLqXMEQTVcCPcs6rgPn2saLY5RHmHVm0X9A
 ALoubSA5eKsQHFVOmDO0IIfRWwUppsGqHhxVv23thxdQLwioJf/ZcXk3ReGlGgn0DHWd
 Vnt2yg0PoVuRt2rzLXgz44Tfll2C+LHbJneLZdjjOZMnF+jb2R3jd9qz3YvpjOaQdoNr
 5fNmmDqo9SrPZXhYAltipBWYJtM4L8plYWXy884SsIeXfsXaIwLKeKcWRCpjQ4ck5AJw
 Jq5g==
X-Gm-Message-State: AJcUukdCesbcsEqrwjQUuCd7jO9qMEbhdSPISMXOQMmjIWYWICtIXq25
 DR9hFWNhrsJ8MI0aQB/TyVecQQ==
X-Google-Smtp-Source: ALg8bN7V4VHmna7sTIrCzjOgXoN+d6ul2XCD6IFFD9PFMk7wYXCXYda1AUSEEWorhVnYNT+v2bGFng==
X-Received: by 2002:a62:3141:: with SMTP id x62mr25828025pfx.12.1547481719762; 
 Mon, 14 Jan 2019 08:01:59 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:55a3:6ea4:4b91:28a5])
 by smtp.googlemail.com with ESMTPSA id 5sm977151pfz.149.2019.01.14.08.01.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 08:01:58 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4] arm64: dts: meson: Fix mmc cd-gpios polarity
In-Reply-To: <1547477061-31543-1-git-send-email-lollivier@baylibre.com>
References: <1547477061-31543-1-git-send-email-lollivier@baylibre.com>
Date: Mon, 14 Jan 2019 08:01:58 -0800
Message-ID: <7hh8ebmdmx.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_080201_205351_0E2D9475 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Loys Ollivier <lollivier@baylibre.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Loys Ollivier <lollivier@baylibre.com> writes:

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
> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>

Queued as fix for v5.0-rc. (I replaced v3 in my fixes branch with this
one)

Kevin

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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
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
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
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
> -- 
> 2.7.4

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
