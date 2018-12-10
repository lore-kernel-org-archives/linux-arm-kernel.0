Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE046C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:36:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD8C2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m2Oe8nG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD8C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=54JNKyyauMLZqov4SQ42RWcPFbRBy608v0bCSkiIVwU=; b=m2Oe8nG2mcAR5S
	TejcthKymodTjN0csi4cApO8U/7uJAHvaLpT2FDBwhbacQJHMXnbK1I8p0mn+h+tqwim6Elks5/vJ
	uvvzUEmHxNI/42IAAq2S4ul0jrlSpF9rF4/J39amRUw4BDCm5i1DEogdn0GScOEYiyvHptgFDTczx
	mre626NavZrQWMhdRhTQUO7ZpmyiN9PZTnUgty0UvDtTppgQgwRR7nHkpQpfbqvumnJZdIIBP33oI
	NAxv9BU8n6R+Zy3QMdB66jYfBAk+vuHipYTCvCoOrrKT4XhbDECUDfggaWcpwTcsaa3T1ppOZLWGs
	gGKD8iMtYiocN7LOYnJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTDm-0007IM-VU; Mon, 10 Dec 2018 21:36:10 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTDj-0007HT-AH; Mon, 10 Dec 2018 21:36:09 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0B9F520733; Mon, 10 Dec 2018 22:35:54 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
 by mail.bootlin.com (Postfix) with ESMTPSA id AB6EC20510;
 Mon, 10 Dec 2018 22:35:53 +0100 (CET)
Date: Mon, 10 Dec 2018 22:35:53 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Tudor.Ambarus@microchip.com
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Message-ID: <20181210213553.GK8952@piout.net>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210171511.21002-1-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_133607_488169_187B13D8 
X-CRM114-Status: GOOD (  16.76  )
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
 Cyrille.Pitchen@microchip.com, linux-kernel@vger.kernel.org,
 boris.brezillon@bootlin.com, Ludovic.Desroches@microchip.com,
 robh+dt@kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 10/12/2018 17:15:29+0000, Tudor.Ambarus@microchip.com wrote:
> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> 
> This patch configures the QSPI0 controller pin muxing and declares
> a jedec,spi-nor memory.
> 
> sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
> memory which advertises a maximum frequency of 80MHz for Quad IO
> Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
> the QSPI drver will set the SPI bus clock to 166MHz / 3 = 55.3MHz.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> [tudor.ambarus@microchip.com:
> - drop partitions,
> - add spi-rx/tx-bus-width
> - change spi-max-frequency to match the 80MHz limit advertised by
>   MX25L25673G for Quad IO Fast Read,
> - reword commit message and subject.]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 31 +++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 518e2b095ccf..171bc82cfbbf 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -108,6 +108,21 @@
>  		};
>  
>  		apb {
> +			qspi0: spi@f0020000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_qspi0_default>;
> +				/* status = "okay"; */ /* conflict with sdmmc1 */

Isn't that conflicting then because I think the default is okay.

> +
> +				flash@0 {
> +					compatible = "jedec,spi-nor";
> +					reg = <0>;
> +					spi-max-frequency = <80000000>;
> +					spi-tx-bus-width = <4>;
> +					spi-rx-bus-width = <4>;
> +					m25p,fast-read;
> +				};
> +			};
> +
>  			spi0: spi@f8000000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_spi0_default>;
> @@ -485,6 +500,22 @@
>  					bias-disable;
>  				};
>  
> +				pinctrl_qspi0_default: qspi0_default {
> +					sck_cs {
> +						pinmux = <PIN_PA22__QSPI0_SCK>,
> +							 <PIN_PA23__QSPI0_CS>;
> +						bias-disable;
> +					};
> +
> +					data {
> +						pinmux = <PIN_PA24__QSPI0_IO0>,
> +							 <PIN_PA25__QSPI0_IO1>,
> +							 <PIN_PA26__QSPI0_IO2>,
> +							 <PIN_PA27__QSPI0_IO3>;
> +						bias-pull-up;
> +					};
> +				};
> +
>  				pinctrl_sdmmc0_default: sdmmc0_default {
>  					cmd_data {
>  						pinmux = <PIN_PA1__SDMMC0_CMD>,
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
