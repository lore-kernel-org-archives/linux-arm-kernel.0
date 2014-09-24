From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 24 Sep 2014 17:59:32 +0200
Subject: [RESEND PATCH] misc: atmel-ssc: prepare clock only when request
In-Reply-To: <1411551235-16502-1-git-send-email-voice.shen@atmel.com>
References: <1411551235-16502-1-git-send-email-voice.shen@atmel.com>
Message-ID: <5422EA64.1070907@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/2014 11:33, Bo Shen :
> Prepare SSC clock only when request SSC channel, the clock will be
> enabled when initialize the SSC.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

okay: it is the driver that uses the ssc that would enable the clock as
it is done in sound/soc/atmel/atmel_ssc_dai.c

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Bye,

> ---
> Send this patch to driver/misc maintainer as Mark Brown suggested.
> 
>  drivers/misc/atmel-ssc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index 60843a2..f9807a7 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -57,7 +57,7 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
>  	ssc->user++;
>  	spin_unlock(&user_lock);
>  
> -	clk_prepare_enable(ssc->clk);
> +	clk_prepare(ssc->clk);
>  
>  	return ssc;
>  }
> @@ -77,7 +77,7 @@ void ssc_free(struct ssc_device *ssc)
>  	spin_unlock(&user_lock);
>  
>  	if (disable_clk)
> -		clk_disable_unprepare(ssc->clk);
> +		clk_unprepare(ssc->clk);
>  }
>  EXPORT_SYMBOL(ssc_free);
>  
> 


-- 
Nicolas Ferre
