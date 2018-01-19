From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Fri, 19 Jan 2018 14:15:18 +0100
Subject: [PATCH-next] IIO: ADC: drop unused 'of_id' struct
In-Reply-To: <20180118234415.32410-1-chrisadr@gentoo.org>
References: <20180118234415.32410-1-chrisadr@gentoo.org>
Message-ID: <667a16d3-5b23-76d7-0206-6ebd5a001c79@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On 01/19/2018 12:44 AM, Christopher D?az Riveros wrote:
> When CONFIG_STM32_DFSDM_CORE is enabled, stm32-dfsdm-core.o is compiled,
> which raises a next warning:
> 
> drivers/iio/adc/stm32-dfsdm-core.c: In function ?stm32_dfsdm_probe?:
> drivers/iio/adc/stm32-dfsdm-core.c:245:29: warning: unused variable ?of_id? [-Wunused-variable]
>   const struct of_device_id *of_id;
>                              ^~~~~
> 
> Signed-off-by: Christopher D?az Riveros <chrisadr@gentoo.org>
> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 84277bcc465f..6290332cfd3f 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
>  static int stm32_dfsdm_probe(struct platform_device *pdev)
>  {
>  	struct dfsdm_priv *priv;
> -	const struct of_device_id *of_id;
>  	const struct stm32_dfsdm_dev_data *dev_data;
>  	struct stm32_dfsdm *dfsdm;
>  	int ret;
> 
Arnd was faster :)
https://patchwork.kernel.org/patch/10172885/

Regards
Arnaud
