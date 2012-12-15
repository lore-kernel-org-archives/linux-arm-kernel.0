From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 15 Dec 2012 10:32:22 +0000
Subject: [PATCH 1/1] iio: at91: fix dev var name in
 at91_adc_trigger_handler
In-Reply-To: <1355325472-31836-1-git-send-email-plagnioj@jcrosoft.com>
References: <1355325472-31836-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <50CC51B6.4090107@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2012 03:17 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> /opt/work/linux-2.6/drivers/iio/adc/at91_adc.c: In function 'at91_adc_trigger_handler':
> /opt/work/linux-2.6/drivers/iio/adc/at91_adc.c:83:22: error: 'indio_dev' undeclared (first use in this function)
> /opt/work/linux-2.6/drivers/iio/adc/at91_adc.c:83:22: note: each undeclared identifier is reported only once for each function it appears in
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-iio at vger.kernel.org

oops. sorry about that. Added to fixes-togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

> ---
>  drivers/iio/adc/at91_adc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 03b8594..315bed1 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -80,7 +80,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>  		*timestamp = pf->timestamp;
>  	}
>  
> -	iio_push_to_buffers(indio_dev, (u8 *)st->buffer);
> +	iio_push_to_buffers(idev, (u8 *)st->buffer);
>  
>  	iio_trigger_notify_done(idev->trig);
>  
> 
