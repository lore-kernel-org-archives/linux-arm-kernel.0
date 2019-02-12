Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C694C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:57:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF09222C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UxffIwRH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdXACQ23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF09222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cqq5THCQfM14QprAiKhYQH6slbALyjqfmSzDombel+Y=; b=UxffIwRHweDHhC
	Dgg8PGldf9ciMVlgBedKciALpY/WTXYXv945Jhg6st6CVxMYFQ+MfUceQyjwLk+zmhYkeCYd6U1Kd
	n00YuDdDHYjy69PgpqNLZ6T/Atjhaz8FEsXxLmo1plsPw8q9LMEnNaS5tC1e9XO2NzArStIoQAVeG
	0TucbZlkj7lDvfwndfLDTU7f5/MgZfMQ2ClWLJNojH0J6adXXHZpracDBdcZ5AK7MPLW+iUFv/7OA
	Q6m8Ri3CBszbEhv7/so5nO48DgDlHyDMhqKxLMK4TWFe5jAwrwgGtXAjK4hSA1SPQ2qwnNL1zsHKh
	M4sfxUfO4bSwyDPZnAuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtf79-0005RT-1q; Tue, 12 Feb 2019 20:57:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtf76-0005Qg-3T
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:57:09 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EB1CA222C0;
 Tue, 12 Feb 2019 20:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550005027;
 bh=98rjWiStFkBn6SS6Uevu+Z3ZheXFAbV83L6MrRwEkEU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PdXACQ23/cNTpis18t5R7I0ewz21izMr4S3znikocQp7cLXeklxqkasXtjxOi+nkk
 +ny/KVyuBcZ6TjGFX10uTgruzBBMNEmWPeUx6GyI23GQNe16t7MIf5LLn+key9mvg5
 5wZd0SVGYMn5PXBZ3l/qhxdzV5Z6vAxBMdzbxlJ0=
Date: Tue, 12 Feb 2019 20:57:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: exynos-adc: Use proper number of channels
 for Exynos4x12
Message-ID: <20190212205701.4cf66d68@archlinux>
In-Reply-To: <20190212174550.4383-2-krzk@kernel.org>
References: <20190212174550.4383-1-krzk@kernel.org>
 <20190212174550.4383-2-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_125708_181762_386283CB 
X-CRM114-Status: GOOD (  20.95  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 12 Feb 2019 18:45:49 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Exynos4212 and Exynos4412 have only four ADC channels so using
> "samsung,exynos-adc-v1" compatible (for eight channels ADCv1) on them is
> wrong.  Add a new compatible for Exynos4x12.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
I'll sneak this in as my last patch for this cycle (lucky timing ;).
It could have done with a fixes tag. I'll mark it for stable as sounds
and looks safe and simple.

Looks like it goes all the way back so I'll leave it without one.

Applied to the togreg branch of iio.git. This will be queued for the
next merge window given how late we are in the cycle.

Thanks,

Jonathan


> ---
>  .../bindings/iio/adc/samsung,exynos-adc.txt     |  4 +++-
>  drivers/iio/adc/exynos_adc.c                    | 17 +++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
> index a10c1f89037d..e1fe02f3e3e9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
> @@ -11,11 +11,13 @@ New driver handles the following
>  
>  Required properties:
>  - compatible:		Must be "samsung,exynos-adc-v1"
> -				for exynos4412/5250 controllers.
> +				for Exynos5250 controllers.
>  			Must be "samsung,exynos-adc-v2" for
>  				future controllers.
>  			Must be "samsung,exynos3250-adc" for
>  				controllers compatible with ADC of Exynos3250.
> +			Must be "samsung,exynos4212-adc" for
> +				controllers compatible with ADC of Exynos4212 and Exynos4412.
>  			Must be "samsung,exynos7-adc" for
>  				the ADC in Exynos7 and compatibles
>  			Must be "samsung,s3c2410-adc" for
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index fa2d2b5767f3..01f7c2570a1e 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -115,6 +115,7 @@
>  #define MAX_ADC_V2_CHANNELS		10
>  #define MAX_ADC_V1_CHANNELS		8
>  #define MAX_EXYNOS3250_ADC_CHANNELS	2
> +#define MAX_EXYNOS4212_ADC_CHANNELS	4
>  #define MAX_S5PV210_ADC_CHANNELS	10
>  
>  /* Bit definitions common for ADC_V1 and ADC_V2 */
> @@ -271,6 +272,19 @@ static void exynos_adc_v1_start_conv(struct exynos_adc *info,
>  	writel(con1 | ADC_CON_EN_START, ADC_V1_CON(info->regs));
>  }
>  
> +/* Exynos4212 and 4412 is like ADCv1 but with four channels only */
> +static const struct exynos_adc_data exynos4212_adc_data = {
> +	.num_channels	= MAX_EXYNOS4212_ADC_CHANNELS,
> +	.mask		= ADC_DATX_MASK,	/* 12 bit ADC resolution */
> +	.needs_adc_phy	= true,
> +	.phy_offset	= EXYNOS_ADCV1_PHY_OFFSET,
> +
> +	.init_hw	= exynos_adc_v1_init_hw,
> +	.exit_hw	= exynos_adc_v1_exit_hw,
> +	.clear_irq	= exynos_adc_v1_clear_irq,
> +	.start_conv	= exynos_adc_v1_start_conv,
> +};
> +
>  static const struct exynos_adc_data exynos_adc_v1_data = {
>  	.num_channels	= MAX_ADC_V1_CHANNELS,
>  	.mask		= ADC_DATX_MASK,	/* 12 bit ADC resolution */
> @@ -492,6 +506,9 @@ static const struct of_device_id exynos_adc_match[] = {
>  	}, {
>  		.compatible = "samsung,s5pv210-adc",
>  		.data = &exynos_adc_s5pv210_data,
> +	}, {
> +		.compatible = "samsung,exynos4212-adc",
> +		.data = &exynos4212_adc_data,
>  	}, {
>  		.compatible = "samsung,exynos-adc-v1",
>  		.data = &exynos_adc_v1_data,


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
