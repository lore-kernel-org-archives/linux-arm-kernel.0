From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 5 Feb 2010 16:40:30 +0100
Subject: [PATCH 1/5] mfd: clean code in max8925
In-Reply-To: <771cded01002030501n698321ddw797aa29372afa744@mail.gmail.com>
References: <771cded01002030501n698321ddw797aa29372afa744@mail.gmail.com>
Message-ID: <20100205154029.GC3448@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 08:01:55AM -0500, Haojian Zhuang wrote:
> From eb0e868d65ec3b5ec01dad8d55899c906159dbf1 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 3 Feb 2010 15:37:23 -0500
> Subject: [PATCH] mfd: clean code in max8925
Patch applied, thanks. In the future, please add some more verbose changelogs.

Cheers,
Samuel.

 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  include/linux/mfd/max8925.h |   17 -----------------
>  1 files changed, 0 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mfd/max8925.h b/include/linux/mfd/max8925.h
> index 18c1844..5259dfe 100644
> --- a/include/linux/mfd/max8925.h
> +++ b/include/linux/mfd/max8925.h
> @@ -158,11 +158,6 @@ enum {
>  #define TSC_IRQ_MASK			(0x03)
>  #define RTC_IRQ_MASK			(0x0c)
> 
> -#define MAX8925_GPM_NUM_IRQ		(40)
> -#define MAX8925_ADC_NUM_IRQ		(8)
> -#define MAX8925_NUM_IRQ			(MAX8925_GPM_NUM_IRQ	\
> -					+ MAX8925_ADC_NUM_IRQ)
> -
>  #define MAX8925_MAX_REGULATOR		(23)
> 
>  #define MAX8925_NAME_SIZE		(32)
> @@ -200,17 +195,11 @@ enum {
>  	MAX8925_NR_IRQS,
>  };
> 
> -struct max8925_irq {
> -	irq_handler_t		handler;
> -	void			*data;
> -};
> -
>  struct max8925_chip {
>  	struct device		*dev;
>  	struct i2c_client	*i2c;
>  	struct i2c_client	*adc;
>  	struct i2c_client	*rtc;
> -	struct max8925_irq	irqs[MAX8925_NUM_IRQ];
>  	struct mutex		io_lock;
>  	struct mutex		irq_lock;
> 
> @@ -257,12 +246,6 @@ extern int max8925_bulk_write(struct i2c_client
> *, int, int, unsigned char *);
>  extern int max8925_set_bits(struct i2c_client *, int, unsigned char,
>  			unsigned char);
> 
> -extern int max8925_request_irq(struct max8925_chip *, int,
> -			irq_handler_t, void *);
> -extern int max8925_free_irq(struct max8925_chip *, int);
> -extern int max8925_mask_irq(struct max8925_chip *, int);
> -extern int max8925_unmask_irq(struct max8925_chip *, int);
> -
>  extern int max8925_device_init(struct max8925_chip *,
>  				struct max8925_platform_data *);
>  extern void max8925_device_exit(struct max8925_chip *);
> -- 
> 1.5.6.5

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
