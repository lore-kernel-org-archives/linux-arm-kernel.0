From: stigge@antcom.de (Roland Stigge)
Date: Wed, 04 Apr 2012 01:52:23 +0200
Subject: [PATCH] gpio: Device tree support for LPC32xx
In-Reply-To: <4F7B8A39.5000701@antcom.de>
References: <1333407513-18231-1-git-send-email-stigge@antcom.de>
 <20120403150430.EBA423E0436@localhost> <4F7B8A39.5000701@antcom.de>
Message-ID: <4F7B8D37.6020306@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/12 01:39, Roland Stigge wrote:
> ===============================================================
> Error requesting gpio 50
> ...
> gpiochip_add: registered GPIOs 0 to 7 on device: gpio_p0
> gpiochip_add: registered GPIOs 8 to 31 on device: gpio_p1
> gpiochip_add: registered GPIOs 32 to 44 on device: gpio_p2
> gpiochip_add: registered GPIOs 45 to 50 on device: gpio_p3
> gpiochip_add: registered GPIOs 51 to 78 on device: gpi_p3
> gpiochip_add: registered GPIOs 79 to 102 on device: gpo_p3
> ===============================================================
> 
> Seems to be caused by this device tree:
> 
>         leds {
>                 compatible = "gpio-leds";
>                 led0 {  
>                         gpios = <&gpo_p3 1 1>; /* GPO_P3 1, GPIO 80, active low */
>                         linux,default-trigger = "heartbeat";
>                         default-state = "keep";
>                 };
>         };

No, it was "another" 50 (decimal, not hex). :-) Was caused by old early
board init code, eliminated anyway.

Thanks,

Roland
