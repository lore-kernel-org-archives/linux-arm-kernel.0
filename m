From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 15 Nov 2015 21:19:38 +0100
Subject: [PATCH] iio: adc: xilinx: constify iio_buffer_setup_ops structure
In-Reply-To: <1447617602-12922-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1447617602-12922-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <5648E8DA.3070509@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2015 09:00 PM, Julia Lawall wrote:
> The iio_buffer_setup_ops structures are never modified, so declare this one
> as const, like the others.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> 
> ---
>  drivers/iio/adc/xilinx-xadc-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 0370624..c2b5f10 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -803,7 +803,7 @@ err:
>  	return ret;
>  }
>  
> -static struct iio_buffer_setup_ops xadc_buffer_ops = {
> +static const struct iio_buffer_setup_ops xadc_buffer_ops = {
>  	.preenable = &xadc_preenable,
>  	.postenable = &iio_triggered_buffer_postenable,
>  	.predisable = &iio_triggered_buffer_predisable,
> 
