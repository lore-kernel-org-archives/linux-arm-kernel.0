From: jlenz2@math.uiuc.edu (John Lenz)
Date: Wed, 16 Sep 2009 21:06:09 -0500
Subject: [PATCH] locomo.c: CodingStyle cleanups
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901CBF46C@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF46C@mi8nycmail19.Mi8.com>
Message-ID: <4AB19991.5050107@math.uiuc.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> EXPORT* macros should follow immediately after the closing function
> brace line.
> 
> The prototype for locomo_chip_driver() is not needed since the static
> (inline) function is located earlier in the file.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: John Lenz <lenz@cs.wisc.edu>
> 

Patch looks ok, although I am no longer active in linux development.
Patch should be sent to Pavel.

> ---
> 
> I originally sent this to the wrong list...
> 
> 
> diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> index 2293f0c..bd36c77 100644
> --- a/arch/arm/common/locomo.c
> +++ b/arch/arm/common/locomo.c
> @@ -865,6 +865,7 @@ void locomo_gpio_set_dir(struct device *dev, unsigned int bits, unsigned int dir
>  
>  	spin_unlock_irqrestore(&lchip->lock, flags);
>  }
> +EXPORT_SYMBOL(locomo_gpio_set_dir);
>  
>  int locomo_gpio_read_level(struct device *dev, unsigned int bits)
>  {
> @@ -882,6 +883,7 @@ int locomo_gpio_read_level(struct device *dev, unsigned int bits)
>  	ret &= bits;
>  	return ret;
>  }
> +EXPORT_SYMBOL(locomo_gpio_read_level);
>  
>  int locomo_gpio_read_output(struct device *dev, unsigned int bits)
>  {
> @@ -899,6 +901,7 @@ int locomo_gpio_read_output(struct device *dev, unsigned int bits)
>  	ret &= bits;
>  	return ret;
>  }
> +EXPORT_SYMBOL(locomo_gpio_read_output);
>  
>  void locomo_gpio_write(struct device *dev, unsigned int bits, unsigned int set)
>  {
> @@ -920,6 +923,7 @@ void locomo_gpio_write(struct device *dev, unsigned int bits, unsigned int set)
>  
>  	spin_unlock_irqrestore(&lchip->lock, flags);
>  }
> +EXPORT_SYMBOL(locomo_gpio_write);
>  
>  static void locomo_m62332_sendbit(void *mapbase, int bit)
>  {
> @@ -1084,13 +1088,12 @@ void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int
>  
>  	spin_unlock_irqrestore(&lchip->lock, flags);
>  }
> +EXPORT_SYMBOL(locomo_m62332_senddata);
>  
>  /*
>   *	Frontlight control
>   */
>  
> -static struct locomo *locomo_chip_driver(struct locomo_dev *ldev);
> -
>  void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf)
>  {
>  	unsigned long flags;
> @@ -1182,11 +1185,13 @@ int locomo_driver_register(struct locomo_driver *driver)
>  	driver->drv.bus = &locomo_bus_type;
>  	return driver_register(&driver->drv);
>  }
> +EXPORT_SYMBOL(locomo_driver_register);
>  
>  void locomo_driver_unregister(struct locomo_driver *driver)
>  {
>  	driver_unregister(&driver->drv);
>  }
> +EXPORT_SYMBOL(locomo_driver_unregister);
>  
>  static int __init locomo_init(void)
>  {
> @@ -1208,11 +1213,3 @@ module_exit(locomo_exit);
>  MODULE_DESCRIPTION("Sharp LoCoMo core driver");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>");
> -
> -EXPORT_SYMBOL(locomo_driver_register);
> -EXPORT_SYMBOL(locomo_driver_unregister);
> -EXPORT_SYMBOL(locomo_gpio_set_dir);
> -EXPORT_SYMBOL(locomo_gpio_read_level);
> -EXPORT_SYMBOL(locomo_gpio_read_output);
> -EXPORT_SYMBOL(locomo_gpio_write);
> -EXPORT_SYMBOL(locomo_m62332_senddata); 
