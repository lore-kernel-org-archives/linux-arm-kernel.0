From: rumjantsev@papillon.ru (237 Rumjantsev Egor (PROG))
Date: Wed, 26 May 2010 16:43:51 +0600
Subject: vpack270 and sleep mode
In-Reply-To: <19452.61138.172496.920965@ipc1.ka-ro>
References: <1272311167-576-1-git-send-email-marek.vasut@gmail.com>	<4BFBD01E.8010101@papillon.ru>	<20100525202447.GD16204@n2100.arm.linux.org.uk>	<201005252247.57688.marek.vasut@gmail.com>	<4BFC99CB.2090902@papillon.ru>	<20100526090748.GB25435@n2100.arm.linux.org.uk>	<4BFCE794.9000306@papillon.ru>
	<19452.61138.172496.920965@ipc1.ka-ro>
Message-ID: <4BFCFB67.6040104@papillon.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

26.05.2010 15:50, Lothar Wa?mann ?????:
> Hi,
>
>> static struct device_driver pxa2xx_flash_driver = {
>                  ^^^^^^^^^^^^1
>>           .name           = "pxa2xx-flash",
>>           .bus            =&platform_bus_type,
>                               ^^^^^^^^^^^^^^^^^^
> This is WRONG!
> platform drivers require a struct platform_driver and MUST be
> registered using platform_driver_register()!
> The platform suspend/resume expects the struct device_driver to be
> embedded within a struct platform_driver.
>
> See https://patchwork.kernel.org/patch/5894/
>
> We should probably add some code to driver_register() to let it refuse
> to register drivers with a 'platform_bus_type'.
>
>
> Lothar Wa?mann

Thank you! This patch helped to pass core test but my board still 
doesn't resume from sleep mode

May be some of Power Manager registers set up not correctly ?

dm9000 dm9000.0: LATE suspend
platform pxa27x-pwm.1: LATE suspend
platform pxa27x-pwm.0: LATE suspend
platform pxa27x-ssp.2: LATE suspend
platform pxa27x-ssp.1: LATE suspend
platform pxa27x-ssp.0: LATE suspend
platform pxa2xx-i2c.1: LATE suspend
platform sa1100-rtc: LATE suspend
platform pxa2xx-i2s: LATE suspend
pxa2xx-uart pxa2xx-uart.2: LATE suspend
pxa2xx-uart pxa2xx-uart.1: LATE suspend
pxa2xx-uart pxa2xx-uart.0: LATE suspend
platform pxa27x-udc: LATE suspend
pxa_pm_enter(): RCSR value: 0x00000000
pxa_pm_enter(): state: 3
pxa_pm_enter(): Power regs:
pxa_pm_enter(): GPDR0: 0x0070E200
pxa_pm_enter(): PWER: 0x00000001
pxa_pm_enter(): PFER: 0x00000000
pxa_pm_enter(): PRER: 0x00000001
pxa_pm_enter(): PGSR0: 0x00010000
pxa_pm_enter(): PGSR1: 0x000F2000
pxa_pm_enter(): PGSR2: 0x0404C000
pxa_pm_enter(): PGSR3: 0x00000020
pxa27x_cpu_pm_enter(): go to suspend : 3
pxa27x_cpu_pm_enter(): PCFR: 0x21
pxa27x_cpu_pm_enter(): PSSR: 0x0
pxa27x_cpu_pm_enter(): PSLR: 0xCC100004
pxa27x_cpu_pm_enter(): PSPR: 0x803503E0
pxa27x_cpu_pm_enter(): CKEN: 0x500226
pxa27x_cpu_pm_enter(): OSCC: 0x3


-- 
Rumjantsev Egor
