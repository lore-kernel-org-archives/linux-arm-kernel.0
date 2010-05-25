From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 25 May 2010 14:39:50 +0200
Subject: vpack270 and sleep mode
In-Reply-To: <201005251438.09494.marek.vasut@gmail.com>
References: <1272311167-576-1-git-send-email-marek.vasut@gmail.com>
	<4BFBBECD.70803@papillon.ru>
	<201005251438.09494.marek.vasut@gmail.com>
Message-ID: <201005251439.50508.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 25. kv?tna 2010 14:38:09 Marek Vasut napsal(a):
> Dne ?t 25. kv?tna 2010 14:13:01 237 Rumjantsev Egor (PROG) napsal(a):
> > Hello, Marek
> 
> Hi,
> 
> > Could you help to solve the following problem:
> > I try to move my board based on Voipac PXA270 module to sleep state.
> > I'm running kernel 2.6.28.10 on it.
> 
> CCed Voipac and linux-arm-kernel. Btw. that's not Voipac official kernel,
> is it?

My bad, CCed wrong linux-arm-kernel, fixed now :)
> 
> > When i try echo mem > /sys/power/state i see messages that system goes
> > to sleep state but after pushing wake-up button (GPIO0) i don't see that
> > a bootloader is running (i set up some GPIOs as flags in bootloader and
> > see on them whith oscilloscope).
> 
> The bootloader checks RCSR once you wake it up and it sets-up SDRAM. If
> there's a sleep-wakeup bit, it branches to location in PSPR and there's
> linux kernel already.
> 
> > This is a part of kernel output when the system goes to sleep mode:
> > 
> > dm9000 dm9000.0: LATE suspend
> > platform pxa27x-pwm.1: LATE suspend
> > platform pxa27x-pwm.0: LATE suspend
> > platform pxa27x-ssp.2: LATE suspend
> > platform pxa27x-ssp.1: LATE suspend
> > platform pxa27x-ssp.0: LATE suspend
> > pxa2xx-i2c pxa2xx-i2c.1: LATE suspend
> > platform sa1100-rtc: LATE suspend
> > platform pxa2xx-i2s: LATE suspend
> > pxa2xx-uart pxa2xx-uart.2: LATE suspend
> > pxa2xx-uart pxa2xx-uart.1: LATE suspend
> > pxa2xx-uart pxa2xx-uart.0: LATE suspend
> > platform pxa27x-udc: LATE suspend
> > pxa_pm_enter(): RCSR value: 0x00000000
> > pxa_pm_enter(): state: 3
> > pxa_pm_enter(): Power regs:
> > pxa_pm_enter(): GPDR0: 0x0070E200
> > pxa_pm_enter(): PWER: 0x00000001
> > pxa_pm_enter(): PFER: 0x00000000
> > pxa_pm_enter(): PRER: 0x00000001
> > pxa_pm_enter(): PGSR0: 0x00010000
> > pxa_pm_enter(): PGSR1: 0x000F2000
> > pxa_pm_enter(): PGSR2: 0x0404C000
> > pxa_pm_enter(): PGSR3: 0x00000020
> > pxa27x_cpu_pm_enter(): go to suspend : 3
> > pxa27x_cpu_pm_enter(): PCFR : 0x61
> > pxa27x_cpu_pm_enter(): PSSR : 0x0
> > pxa27x_cpu_pm_enter(): PSLR : 0xCC100004
> > pxa27x_cpu_pm_enter(): OSCC : 0x3
> > 
> > but if i type command echo standby > /sys/power/state
> > the system reacts on wake-up button but hangs after some messages about
> > null dereferencing pointers.
> > 
> > is there any possibility to trace such problem?
> 
> Try CONFIG_PM_ADVANCED_DEBUG. Enable that and check if the tests work, one
> by one. What are the messages you get once the kernel crashes?
> 
> There was also a way to keep the console enabled until the kernel didn't
> totally suspend, but I can't find that option now, maybe someone will be
> more successful. And maybe I'm mistaking this with an option to don't
> blank consoles until then, it's been some time since I needed that.
> 
> > P.S.: sorry if i disturb you, but you the only man in ARM linux mailing
> > list who posted messages about Voipac modules.
> 
> You're welcome.
> 
> > Best regards !!!
