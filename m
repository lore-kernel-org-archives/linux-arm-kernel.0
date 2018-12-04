Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E2C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:53:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3159B20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fdpui8Rv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0BrZdJgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3159B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:To:
	MIME-Version:From:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QAwcHOpjOae6C595XGgieJT428V5t11vDHfXwVVE3fQ=; b=Fdpui8RvcWvlP9
	lZEyPzbem9n07/4JGzubQcChixVDy7Rsbyyka/BBzTga6+vzYEnZqkaREz3URpRYkk/fE5bqrQ8bd
	tcE7XHgO8jLJEEYQ9Bd3j43CZr/K+SEifwiFegNwzkf9I/tpJ447I4FARwemthXLwtyZ6uHdG6+On
	0g1Y1Lr08ZOnY3cgCbls4qavupud6N12+9xXZV72VCBm9/MSrkj2YAsQtTU44aOuJ3LPAaLeRdM6k
	yewHMqraYdKbLVjigLFEVOWe9C26kCmkNUB9T3CQrO+4QiaqQEORz1RpKib+Bu3Dw02uawLrkLQNG
	sD6YI1rSTr64RI7s/0Rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGkj-0005cL-5m; Tue, 04 Dec 2018 19:53:05 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGkd-0005b3-Rr
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:53:01 +0000
Received: by mail-wm1-x342.google.com with SMTP id a18so10634094wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 11:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:from:user-agent:mime-version:to:subject:references
 :in-reply-to:content-transfer-encoding;
 bh=3xd1Bg6itxV2aJ5QBPr+TjLD9YHOJAmHH09WUH85rfA=;
 b=0BrZdJgFtcSqJ2jctmdnZO+eX03Uiio0rIUDX5aKg4G5qZZjh13jWNEwhq7QHdtHkS
 8yWUqIJ6bnLMSraKfXzhZebuqj7gt7q/p9nY+i7B9uibQ5K6vRXZPknGA9Fv0iuXuxOa
 b0Hb0rSwbIo/8/pYz0aferaeeYr+S7DJjpZvn+26EXAniZlDiJlk2vO1w6d+mMtoEiqo
 BgDlNFIyqR7WP2pAGNBfl8mZHP10nuvX8meNmE+lNgqVIOY9WXa8Ad4w9E4aUBKRSYh+
 1+9XkzA6GiE34hdYZIQBFC3lWJ048ByLAeCr025zlc7vEam8ge3XGX20o2VF85OWLzCt
 kcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
 :subject:references:in-reply-to:content-transfer-encoding;
 bh=3xd1Bg6itxV2aJ5QBPr+TjLD9YHOJAmHH09WUH85rfA=;
 b=BChuJfytG5+U0Q9QEJZZUULmGjbk/HWytWpm+zxMh24MgTC8fhrKagsn/3oRz5FLOP
 /HwDFQ9YWh0VW+vVvEXcz9t9PsPpm4j9kw60TI1HnPsn1Q5bDz3GCiU9wNyqYDeWtVMM
 i4zHXdzJpUVaSbg06BN1nRJarihn6BvpC2pcHnZa8SttssZF4mH79EjhdFUjWSWTXijv
 IQBvmk5C8xgiS0k2kK8rnm+XCegkxcGv+KH751wFEg01V07Qe47vCSBMxbT2wr7crg85
 V25s+R6Ct9n5l0weeM8K0/z6qdlrpyqm2tgog+KEWRjRBvaxEJ3L9WKGUY7FW/gEwjIf
 acyQ==
X-Gm-Message-State: AA+aEWYzczt9pQgQrBv2MsO1v7kHQOhktF8F9Q9WrhonnpcaJd+y9oAC
 qtVvGEQ0Qxx12gCunnmu/otQhA==
X-Google-Smtp-Source: AFSGD/UMfOxBoy8H0Z1CxMymZZ9V9NFEb5PwSviNV9EOdrbwBtiDYPGkAeygdu+kpg12cFrdQIHBZQ==
X-Received: by 2002:a1c:d988:: with SMTP id q130mr14238437wmg.41.1543953167753; 
 Tue, 04 Dec 2018 11:52:47 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local
 ([2a01:cb1d:4ce:ea00:457b:c7f4:7108:f8c4])
 by smtp.gmail.com with ESMTPSA id v19sm25411386wrd.46.2018.12.04.11.52.46
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 04 Dec 2018 11:52:47 -0800 (PST)
Message-ID: <5C06DB0D.3010306@baylibre.com>
Date: Tue, 04 Dec 2018 20:52:45 +0100
From: Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13;
 rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, 
 mark.rutland@arm.com, khilman@baylibre.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 martin.blumenstingl@googlemail.com
Subject: Re: [PATCH 1/2] arm64: dts: meson: Fix IRQ trigger type for macirq
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <20181204160447.27869-2-ccaione@baylibre.com>
In-Reply-To: <20181204160447.27869-2-ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_115259_899380_00DAFD27 
X-CRM114-Status: GOOD (  18.03  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Carlo,

Le 04/12/2018 17:04, Carlo Caione a =E9crit :
> A long running stress test on a custom board shipping an AXG SoCs and a
> Realtek RTL8211F PHY revealed that after a few hours the connection
> speed would drop drastically, from ~1000Mbps to ~3Mbps. At the same time
> the 'macirq' (eth0) IRQ would stop being triggered at all and as
> consequence the GMAC IRQs never ACKed.
> =

> After a painful investigation the problem seemed to be due to a wrong
> defined IRQ type for the GMAC IRQ that should be LEVEL_HIGH instead of
> EDGE_RISING.

This is a good news !

Kevin,
What's the best procedure here to make it apply on the 4.19, 4.14 and 4.9 s=
table
trees ? for 4.14 and 4.9 it will need to be reworked to apply correctly.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

> =

> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/boot/dts/meson.dtsi               | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
> index 0d9faf1a51ea..a86b89086334 100644
> --- a/arch/arm/boot/dts/meson.dtsi
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -263,7 +263,7 @@
>  			compatible =3D "amlogic,meson6-dwmac", "snps,dwmac";
>  			reg =3D <0xc9410000 0x10000
>  			       0xc1108108 0x4>;
> -			interrupts =3D <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
> +			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "macirq";
>  			status =3D "disabled";
>  		};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot=
/dts/amlogic/meson-axg.dtsi
> index df017dbd2e57..b1a42e99cb67 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -143,7 +143,7 @@
>  			compatible =3D "amlogic,meson-axg-dwmac", "snps,dwmac";
>  			reg =3D <0x0 0xff3f0000 0x0 0x10000
>  			       0x0 0xff634540 0x0 0x8>;
> -			interrupts =3D <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
> +			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "macirq";
>  			clocks =3D <&clkc CLKID_ETH>,
>  				 <&clkc CLKID_FCLK_DIV2>,
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/=
dts/amlogic/meson-gx.dtsi
> index f1e5cdbade5e..58e6bcaac1d8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -462,7 +462,7 @@
>  			compatible =3D "amlogic,meson-gx-dwmac", "amlogic,meson-gxbb-dwmac", =
"snps,dwmac";
>  			reg =3D <0x0 0xc9410000 0x0 0x10000
>  			       0x0 0xc8834540 0x0 0x4>;
> -			interrupts =3D <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
> +			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "macirq";
>  			status =3D "disabled";
>  		};
> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
