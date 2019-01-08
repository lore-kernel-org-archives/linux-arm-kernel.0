Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8C4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:16:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C69720645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XsTLRl0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C69720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DQll5f25LREkEewPh2m/BOua52n81ql0OpQHCzp6WEU=; b=XsTLRl0EndaYgW
	ct8XrHnQJMHuIEK4OwfZm+U8udhNKXaXhv9nK1fpSiq26M1BYl/50BkT9VnTL9tU/tE/C4k1q6L2s
	NGHwGUsD2PaNR+o4nEXaMVOcpX45Iw8Nav9JH0h9LrjiqkBV6JYrANrRHvW53KO9VrTnj55x078W7
	8dKLPAZ3eGJyl/WLfwisSMFdKxoU1ZGcX5WHes1qafkYBoNvEMwQ3NnhK7JbFqT4Sd6WxQg3e2nX4
	8VopHmuZo9xWJToAaA/7F037jQx5rxp8uNoTy0k0DmiG7i6IlioyGMFwMxOctldIJFEJMorM9augC
	SE34BQVtDtKa/Yzdse/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvuy-0003dN-4B; Tue, 08 Jan 2019 18:16:00 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvus-0003ca-Uv; Tue, 08 Jan 2019 18:15:57 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id DF6772078F; Tue,  8 Jan 2019 19:15:53 +0100 (CET)
Received: from localhost (alyon-652-1-61-72.w109-213.abo.wanadoo.fr
 [109.213.84.72])
 by mail.bootlin.com (Postfix) with ESMTPSA id AB3112074F;
 Tue,  8 Jan 2019 19:15:53 +0100 (CET)
Date: Tue, 8 Jan 2019 19:15:53 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Tudor.Ambarus@microchip.com
Subject: Re: [PATCH 2/2] ARM: dts: at91: at91-sama5d27_som1_ek: enable qspi1
 memory
Message-ID: <20190108181553.GG10218@piout.net>
References: <20181212163057.22183-1-tudor.ambarus@microchip.com>
 <20181212163057.22183-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212163057.22183-2-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_101555_251020_F16963FF 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, broonie@kernel.org,
 linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
 Ludovic.Desroches@microchip.com, robh+dt@kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/12/2018 16:31:11+0000, Tudor.Ambarus@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Enable qspi1.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Note that this should have your SoB too as you are sending a patch that
is not from you.

> ---
>  arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> index 363a43d77424..73d16d98bf9c 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> @@ -109,6 +109,10 @@
>  				status = "okay";
>  			};
>  
> +			qspi1: spi@f0024000 {
> +				status = "okay";
> +			};
> +
>  			spi0: spi@f8000000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_spi0_default>;
> -- 
> 2.9.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
