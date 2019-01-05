Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CEAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:44:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976BE2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JlD6XNUL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzZappER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976BE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xfa2L7gWqE2Xxmz3MnDSajB3tU3WBgpHXHvJm0wEpxA=; b=JlD6XNUL7S28WL
	NkuYrcE3A72gh+6tDFOslcIkAZjeGx95yGs7bamVR2Zw+buYQmVla2eL69YzWmCU3GVPNO1EUzBBr
	/+erQIk8M1KeXXApcJk0DMqaqGSAPJq7fc0BqcxsqEtmFbn+bdpZEEZco3Cnjyhjkr+V0HNkNX2V4
	6y3GpnYpcva4TTWJCZISyhiWRHXe/UzaUEvFten0lJNXLIGIAK8x6wOLosb5E3Qwtcu5RaZo0Gsat
	mowKzcWNlmwHlbDOnzf3rm71PhI4rC+9JBb4R0dZFtfmBsCOZp008NVNeVQFsDdtaSoFett8K+x2H
	fJhUCzillJph8xrGW0Kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfp3t-0003SF-7L; Sat, 05 Jan 2019 16:44:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfp3p-0003RM-4I; Sat, 05 Jan 2019 16:44:35 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2CF020868;
 Sat,  5 Jan 2019 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546706672;
 bh=y6g3RC2jupLKkYvU50Kw8dU3yHjiAEgyUOv6lo+XkOo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fzZappERtnQP9KuQ5fMhPitA0oHB5+b9fwrz28GoS+iOfXL+Pr/rtPyf/uR5q9uv6
 Og9Fxp7c57oB/EMsR18oiIfthR3a980t7Rk/9X6RRwisVm5fEqIExFY4sFNE8m5UyW
 BjsCZg3VMJp0uXYUy0rQadR118JSTx6tihcySmOY=
Date: Sat, 5 Jan 2019 16:44:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 2/2] iio: adc: meson-saradc: enable the temperature
 sensor two more SoCs
Message-ID: <20190105164427.03e2a013@archlinux>
In-Reply-To: <20181227215020.9803-3-martin.blumenstingl@googlemail.com>
References: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
 <20181227215020.9803-3-martin.blumenstingl@googlemail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_084433_624710_2ED263DF 
X-CRM114-Status: GOOD (  22.37  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, balbes-150@yandex.ru,
 robh+dt@kernel.org, pmeerw@pmeerw.net, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 27 Dec 2018 22:50:20 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Meson8b and Meson8m2 use the same logic to convert the ADC register
> value to celsius, which is different from Meson8:
> - Meson8 has different multiplier and divider values
> - Meson8 uses a 4-bit TSC (temperature sensor coefficient) which fits
>   into the 4-bit field in the MESON_SAR_ADC_DELTA_10 register:
>   MESON_SAR_ADC_DELTA_10_TS_C_MASK. Meson8b and Meson8m2 have a 5-bit
>   TSC which requires writing the upper-most bit into the
>   MESON_HHI_DPLL_TOP_0[9] register from the HHI register area.
> 
> This adds support for the temperature sensor on the Meson8b and Meson8m2
> SoCs by implementing the logic to write the upper-most TSC bit into the
> HHI register area. The SoC-specific values (temperature_trimming_bits,
> temperature_multiplier, temperature_divider) are added - these simply
> integrate into the existing infrastructure (which was implemented for
> Meson8) and thus require no further changes to the existing temperature
> calculation logic.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 729becb2d3d9..f8600fbcdfe3 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -26,6 +26,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/mfd/syscon.h>
>  
>  #define MESON_SAR_ADC_REG0					0x00
>  	#define MESON_SAR_ADC_REG0_PANEL_DETECT			BIT(31)
> @@ -174,6 +175,9 @@
>  #define MESON_SAR_ADC_EFUSE_BYTE3_UPPER_ADC_VAL			GENMASK(6, 0)
>  #define MESON_SAR_ADC_EFUSE_BYTE3_IS_CALIBRATED			BIT(7)
>  
> +#define MESON_HHI_DPLL_TOP_0					0x318
> +#define MESON_HHI_DPLL_TOP_0_TSC_BIT4				BIT(9)
> +
>  /* for use with IIO_VAL_INT_PLUS_MICRO */
>  #define MILLION							1000000
>  
> @@ -280,6 +284,7 @@ struct meson_sar_adc_priv {
>  	struct completion			done;
>  	int					calibbias;
>  	int					calibscale;
> +	struct regmap				*tsc_regmap;
>  	bool					temperature_sensor_calibrated;
>  	u8					temperature_sensor_coefficient;
>  	u16					temperature_sensor_adc_val;
> @@ -727,6 +732,15 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> +	priv->tsc_regmap =
> +		syscon_regmap_lookup_by_phandle(indio_dev->dev.parent->of_node,
> +						"amlogic,hhi-sysctrl");
> +	if (IS_ERR(priv->tsc_regmap)) {
> +		dev_err(indio_dev->dev.parent,
> +			"failed to get amlogic,hhi-sysctrl regmap\n");
> +		return PTR_ERR(priv->tsc_regmap);
> +	}
> +
>  	read_len = MESON_SAR_ADC_EFUSE_BYTES;
>  	buf = nvmem_cell_read(temperature_calib, &read_len);
>  	if (IS_ERR(buf)) {
> @@ -861,6 +875,22 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  				    priv->temperature_sensor_coefficient);
>  		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
>  				   MESON_SAR_ADC_DELTA_10_TS_C_MASK, regval);
> +
> +		if (priv->param->temperature_trimming_bits == 5) {
> +			if (priv->temperature_sensor_coefficient & BIT(4))
> +				regval = MESON_HHI_DPLL_TOP_0_TSC_BIT4;
> +			else
> +				regval = 0;
> +
> +			/*
> +			 * bit [4] (the 5th bit when starting to count at 1)
> +			 * of the TSC is located in the HHI register area.
> +			 */
> +			regmap_update_bits(priv->tsc_regmap,
> +					   MESON_HHI_DPLL_TOP_0,
> +					   MESON_HHI_DPLL_TOP_0_TSC_BIT4,
> +					   regval);
> +		}
>  	} else {
>  		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
>  				   MESON_SAR_ADC_DELTA_10_TS_REVE1, 0);
> @@ -1064,6 +1094,9 @@ static const struct meson_sar_adc_param meson_sar_adc_meson8b_param = {
>  	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
>  	.regmap_config = &meson_sar_adc_regmap_config_meson8,
>  	.resolution = 10,
> +	.temperature_trimming_bits = 5,
> +	.temperature_multiplier = 10,
> +	.temperature_divider = 32,
>  };
>  
>  static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
