From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 8 May 2014 19:22:43 +0200
Subject: [PATCH 2/2] iio:adc: at91 requires the input subsystem
In-Reply-To: <1399560990-1402858-13-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-13-git-send-email-arnd@arndb.de>
Message-ID: <20140508172243.GC6095@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/05/2014 at 16:56:24 +0200, Arnd Bergmann wrote :
> Building the at91 adc driver with CONFIG_INPUT disabled results in this
> build error:
> 
> ERROR: "input_event" [drivers/iio/adc/at91_adc.ko] undefined!
> ERROR: "input_unregister_device" [drivers/iio/adc/at91_adc.ko] undefined!
> ERROR: "input_free_device" [drivers/iio/adc/at91_adc.ko] undefined!
> ERROR: "input_register_device" [drivers/iio/adc/at91_adc.ko] undefined!
> ERROR: "input_set_abs_params" [drivers/iio/adc/at91_adc.ko] undefined!
> ERROR: "input_allocate_device" [drivers/iio/adc/at91_adc.ko] undefined!
> 
> To make sure we can build random configurations, this turns on CONFIG_INPUT
> whenever CONFIG_AT91_ADC is enabled.
> 

I'm wondering wether we should make part of the driver compile only if
CONFIG_INPUT is defined. Maybe some user will want to use the ADC and
not have any input on their board.

What do you think ?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
