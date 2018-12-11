Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A55C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:40:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9F32054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f/uqOHQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9F32054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b1PuVukWgYvKHNlUyIvuMFcauPDJE1fDzmMbdAC3Mq4=; b=f/uqOHQDSZXBSh
	lYnV2b/sHtLc6Vcqfj8+sVHdWmGD1hkTQRwlSQTbjUWqVDCjCvmf3j/CRc8t2dWHmp7DICoOapZ9P
	joTmP0Zadt62akp/8r+n8aaki93uLyHJGavSi1LNSiV8/MTfUn5jO0MGNR1OSeqEKZxNCtox6S2RI
	sDHclqTpXd+0Mdk8VhRZj4VZqsJwvw/x773Du1tngDD0b2Co5MR2prHwCeoWPN0+n+nPGCvmPceu9
	5S/QyyMYgujCb5U2a5nSxFFMKfMZn+1ZSKtydxGkKopurDNd5+mRfDXc304xQYfd1ggZN0Z2ges8I
	+mENn/mIgJsLEFi7v2XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjDO-0001pN-1R; Tue, 11 Dec 2018 14:40:50 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjDI-0001mH-UC; Tue, 11 Dec 2018 14:40:47 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 91F8020CDB; Tue, 11 Dec 2018 15:40:33 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 43018207B8;
 Tue, 11 Dec 2018 15:40:33 +0100 (CET)
Date: Tue, 11 Dec 2018 15:40:33 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Message-ID: <20181211154033.076506aa@bbrezillon>
In-Reply-To: <20181210171511.21002-1-tudor.ambarus@microchip.com>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_064045_155436_91435ED6 
X-CRM114-Status: GOOD (  15.91  )
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
 alexandre.belloni@bootlin.com, broonie@kernel.org,
 Cyrille.Pitchen@microchip.com, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, robh+dt@kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018 17:15:29 +0000
<Tudor.Ambarus@microchip.com> wrote:

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
> +
> +				flash@0 {
> +					compatible = "jedec,spi-nor";
> +					reg = <0>;
> +					spi-max-frequency = <80000000>;
> +					spi-tx-bus-width = <4>;
> +					spi-rx-bus-width = <4>;
> +					m25p,fast-read;
> +				};

I'm a bit lost. What's the point of defining this if the QSPI
controller is not enabled?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
