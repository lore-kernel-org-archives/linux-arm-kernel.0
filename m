Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DA4C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:52:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB742082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J9NuZXsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB742082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=epigenesys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KzJoH2Y2G8kQd5/RsHdMq4jBQWmzXZ4lI23lZLN9jxw=; b=J9NuZXsGEauozO
	FoGAbofLmqe8HGDit34d4FnxWQBoeEHAYPMK0epcr5Qi5Xahy4UPIP9h/PQWufnZi/vA7Oo8fAmdH
	MevtH51kbXvUBJLXm2qU/BNMWyFjJdD/Gz0maWA+HocExwbCdmneifR/sBIWIkqQCpCywNyefO0oJ
	VGLAvS89hCpujac7EQFq30jnfqDkb/2zyd28+xgycp3UvS/F3C4UBLlP0eEvykCTOjk6avx0DPixm
	S2cJugkqsNazDH2M0EIurVlMbIPbFTODoL3rEJrrhrrM/3tAsqeobZzL3ut434/v7Yb+urnYb8x7l
	yhMdEGbguDNwQSer2+Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLEI-0006nf-Fk; Fri, 07 Dec 2018 18:52:02 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLE7-0006QN-No; Fri, 07 Dec 2018 18:51:56 +0000
Received: by mail-wr1-f67.google.com with SMTP id z5so4716610wrt.11;
 Fri, 07 Dec 2018 10:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zD4+PzSfzyXELGonahFcmTtfUbf7cR/WgUbyXdKvc7k=;
 b=KaepYrGvxdYv5hl7xNId1JlSPXF2BHuWSLh+rCq3qE1UsEJsuVxw7UZK2WukUWMjOk
 Jzny4JTD27X9Ta3SM23RcrPKjzGkB4mqCyFFHVLuyxOo36EHiojXkk25PksNNn7iyzdK
 S/5Gxdiqt1iob9Jc4rsdWgE+5kwAMsMTEr5MUTrzJ8ra8Z3hVqHODWSkcXgLAY3j17MR
 ROE2jM36mjfUlKjyP6oOX7hQUK5ZYR4GJvhFbmLKXRQ7pLUTo+VKK6ha/jMhiitoBHa3
 4IMEsqq+482F/J3k5pwV8J3pf4lEtw+4j+GZ/0s+41WVJP6eqRJ/xPvqjX2DArgP8Th0
 2Jeg==
X-Gm-Message-State: AA+aEWZ4Vb8NwNbDOaLsSZd/N4EEXnuUQKLLDF5MOMss2f+HXF5tvL/l
 AEhK81zwe2AIKnJp+Q0EA5g=
X-Google-Smtp-Source: AFSGD/XIwAHB+Ov5ak3IuGDlSkdv+lzswz7YpnmAO8V8m/Em7cFHC9YhPQsMqBMnXKNpFnjyzQf3sA==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr2670000wrm.309.1544208699763; 
 Fri, 07 Dec 2018 10:51:39 -0800 (PST)
Received: from ingrassia.epigenesys.com
 (host194-85-static.3-79-b.business.telecomitalia.it. [79.3.85.194])
 by smtp.gmail.com with ESMTPSA id v132sm4796637wme.20.2018.12.07.10.51.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 10:51:39 -0800 (PST)
Date: Fri, 7 Dec 2018 19:51:36 +0100
From: Emiliano Ingrassia <ingrassia@epigenesys.com>
To: Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH v2 2/2] arm: dts: meson: Fix IRQ trigger type for macirq
Message-ID: <20181207185136.GB17435@ingrassia.epigenesys.com>
References: <20181207105231.25593-1-ccaione@baylibre.com>
 <20181207105231.25593-3-ccaione@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207105231.25593-3-ccaione@baylibre.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_105152_245556_06F9E736 
X-CRM114-Status: GOOD (  20.71  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 martin.blumenstingl@googlemail.com, khilman@baylibre.com, robh+dt@kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Carlo,

tests[0] conducted on an Odroid-C1+ board equipped with a Meson8b SoC
have shown an high packet loss (90% and more) during a simple ping
test from a laptop to the board.
Testing the two patches separately clearly showed that this depends on the
removal of the "eee-broken-1000t" flag from the board PHY description
in the relative device tree.

About the first patch (MAC IRQ type), no tests have shown an evidence
that it is needed. I suggest you to conduct some test on real hardware
as I do to confirm or disprove my tests.

Thanks for your work,

Emiliano

[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009397.html

On Fri, Dec 07, 2018 at 10:52:31AM +0000, Carlo Caione wrote:
> A long running stress test on a custom board shipping an AXG SoCs and a
> Realtek RTL8211F PHY revealed that after a few hours the connection
> speed would drop drastically, from ~1000Mbps to ~3Mbps. At the same time
> the 'macirq' (eth0) IRQ would stop being triggered at all and as
> consequence the GMAC IRQs never ACKed.
>
> After a painful investigation the problem seemed to be due to a wrong
> defined IRQ type for the GMAC IRQ that should be LEVEL_HIGH instead of
> EDGE_RISING.
>
> The change in the macirq IRQ type also solved another long standing
> issue affecting this SoC/PHY where EEE was causing the network
> connection to die after stressing it with iperf3 (even though much
> sooner). It's now possible to remove the 'eee-broken-1000t' quirk as
> well.
>
> Fixes: 9c15795a4f96 ("ARM: dts: meson8b-odroidc1: ethernet support")
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/boot/dts/meson.dtsi           | 2 +-
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
> index 0d9faf1a51ea..a86b89086334 100644
> --- a/arch/arm/boot/dts/meson.dtsi
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -263,7 +263,7 @@
>  			compatible = "amlogic,meson6-dwmac", "snps,dwmac";
>  			reg = <0xc9410000 0x10000
>  			       0xc1108108 0x4>;
> -			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
> +			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "macirq";
>  			status = "disabled";
>  		};
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index 58669abda259..a951a6632d0c 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -221,7 +221,6 @@
>  		/* Realtek RTL8211F (0x001cc916) */
>  		eth_phy: ethernet-phy@0 {
>  			reg = <0>;
> -			eee-broken-1000t;
>  			interrupt-parent = <&gpio_intc>;
>  			/* GPIOH_3 */
>  			interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> --
> 2.19.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
