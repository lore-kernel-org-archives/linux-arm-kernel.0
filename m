From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 18 Jun 2015 13:24:48 +0200
Subject: [PATCH] gpio: zynq: add missing module_exit function
In-Reply-To: <1434531101-2585-1-git-send-email-yamada.masahiro@socionext.com>
References: <1434531101-2585-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <5582AA80.8090603@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2015 10:51 AM, Masahiro Yamada wrote:
> This driver is tristate, so it should be cleanable.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/gpio/gpio-zynq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
> index 184c4b1..1d38da7 100644
> --- a/drivers/gpio/gpio-zynq.c
> +++ b/drivers/gpio/gpio-zynq.c
> @@ -722,6 +722,12 @@ static int __init zynq_gpio_init(void)
>  }
>  postcore_initcall(zynq_gpio_init);
>  
> +static void __exit zynq_gpio_exit(void)
> +{
> +	platform_driver_unregister(&zynq_gpio_driver);
> +}
> +module_exit(zynq_gpio_exit);
> +
>  MODULE_AUTHOR("Xilinx Inc.");
>  MODULE_DESCRIPTION("Zynq GPIO driver");
>  MODULE_LICENSE("GPL");
> 

Looks reasonable to me.

Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
