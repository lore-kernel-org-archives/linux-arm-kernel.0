From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Jun 2013 14:49:05 +0530
Subject: [PATCH v2 7/7] ARM: davinci: Start using gpiolib API inplace
 of inline functions
In-Reply-To: <1371202532-14628-8-git-send-email-avinashphilip@ti.com>
References: <1371202532-14628-1-git-send-email-avinashphilip@ti.com>
 <1371202532-14628-8-git-send-email-avinashphilip@ti.com>
Message-ID: <51C2C909.7060001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/14/2013 3:05 PM, Philip Avinash wrote:
> Remove NEED_MACH_GPIO_H config select option for ARCH_DAVINCI to start
> use gpiolib interface for davinci platforms. However with this software
> latencies for gpio_get/set APIs will affect. Latency has increased by 18
> microsecond with gpiolib API as compared with inline API's.
> 
> Software latency is calculated on da850 EVM for gpio_get_value API by
> taking the printk timing for API execution with interrupts disabled.
> Experiment has done for inline and gpiolib API interface.
> 
>   inline gpio API with interrupt disabled
>   [   29.734337] before gpio_get
>   [   29.736847] after gpio_get
> 
>   Time difference 0.00251
> 
>   gpio library with interrupt disabled
>   [  272.876763] before gpio_get
>   [  272.879291] after gpio_get
> 
>   Time difference 0.002528
>   Latency increased by (0.002528 -  0.00251) = 18 microsecond.
> 
> Also being here
> - Moved following definitions from mach folder to include directory
> 	struct davinci_gpio_controller
> 	Macro GPIO(x)
> 	inline function __gpio_mask

> - Removed GPIO_TYPE_DAVINCI enum definition as GPIO Davinci is converted
>   to Linux device driver model.

This is bit out-of-place here. Why not do it along with removal of its
last usage in <soc>.c files?

Rest of the patch looks good to me.

Thanks,
Sekhar
