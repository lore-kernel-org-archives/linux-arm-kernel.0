From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jul 2014 10:57:35 +0200
Subject: [PATCHv7 0/4] iio: adc: exynos_adc: Support Exynos3250 ADC and
 code clean
In-Reply-To: <53CCCB20.50802@samsung.com>
References: <1405909068-22539-1-git-send-email-cw00.choi@samsung.com>
 <14522743.f6oFhEQVv4@wuerfel> <53CCCB20.50802@samsung.com>
Message-ID: <10938575.0qbHyHWX4J@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 July 2014 17:11:12 Chanwoo Choi wrote:
> >    work to address the comments and do testing.
> 
> OK, I'll add this patch.
> But, I have a question.
> 
> Your patch add following compatible string.
> "s3c64100-adc" is right?
> 
>  static const struct of_device_id exynos_adc_match[] = {
>         {
> +               .compatible = "samsung,s3c64100-adc",
> +               .data = &exynos_adc_s3c64xx_data,
> +       }, {

There is a typo, thanks for spotting this. It should be
"samsung,s3c6410-adc", not "samsung,s3c64100-adc".

> > b) For the "compatible" string, I think it makes sense to set a fallback to
> >    "samsung,exynos-adc-v2" in the case for exynos3250, making the DT
> >    representation
> > 
> >       compatible = "samsung,exynos3250-adc", "samsung,exynos-adc-v2";
> > 
> >    It's not entirely compatible because of the addition of the clock, but
> >    since the register layout is the same, I think it still make sense.
> 
> OK, I'll add it in exynos3250.dtsi as following:
> 
>                 adc: adc at 126C0000 {
> -                       compatible = "samsung,exynos-adc-v3";
> +                       compatible = "samsung,exynos3250-adc",
> +                                    "samsung,exynos-adc-v2";
>                         reg = <0x126C0000 0x100>, <0x10020718 0x4>;
>                         interrupts = <0 137 0>;
> -                       clock-names = "adc", "sclk_tsadc";
> +                       clock-names = "adc", "sclk";
>                         clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
>                         #io-channel-cells = <1>;
>                         io-channel-ranges;

Ok, looks good.

	Arnd
