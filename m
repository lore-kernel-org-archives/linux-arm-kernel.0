From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 13 Mar 2013 12:22:27 +0100
Subject: ARM: at-91: ARCH_AT91SAM9X5 went missing
In-Reply-To: <51405F0D.40102@atmel.com>
References: <1363171688.3137.196.camel@x61.thuisdomein>
 <51405F0D.40102@atmel.com>
Message-ID: <1363173747.3137.202.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 12:12 +0100, Nicolas Ferre wrote:
> These ARCH_AT91xxx variables are not used anymore for pure Device Tree
> SoCs (I mean: at91sam9x5, at91sam9n12, sama5d3 families). They are used
> for non-DT SoCs and for chips that support both legacy board files and DT.
> The old ARCH_AT91xxx symbols are selecting the corresponding SOC_AT91xxx
> symbol.
> 
> ARCH_AT91xxx in Kconfig that are specific to a particular SoC are going
> to disappear as we tend to allow the compilation of a particular driver
> for a wider range of configurations.

So setting one of the SOC_* symbols will not generate the corresponding
ARCH_* symbol, will it? To be specific, for the people entering the
configuration from the new SOC_* side none of this is relevant anymore
(this is all the stuff outside of arch/arm):

drivers/misc/Kconfig:87:        prompt "TC Block" if ARCH_AT91RM9200 || ARCH_AT91SAM9260 || CPU_AT32AP700X
drivers/pcmcia/Kconfig:291:     depends on PCMCIA && ARCH_AT91RM9200
drivers/rtc/Kconfig:977:        depends on ARCH_AT91 && !(ARCH_AT91RM9200 || ARCH_AT91X40)
drivers/tty/serial/atmel_serial.c:268:#ifdef CONFIG_ARCH_AT91RM9200
drivers/watchdog/Kconfig:127:   depends on ARCH_AT91 && !ARCH_AT91RM9200
drivers/misc/Kconfig:87:        prompt "TC Block" if ARCH_AT91RM9200 || ARCH_AT91SAM9260 || CPU_AT32AP700X
drivers/video/Kconfig:1026:     depends on FB_ATMEL && ARCH_AT91SAM9261
drivers/net/can/Kconfig:68:     depends on ARCH_AT91SAM9263 || ARCH_AT91SAM9X5
drivers/rtc/Kconfig:991:        prompt "RTT module Number" if ARCH_AT91SAM9263
drivers/rtc/Kconfig:1000:       range 0 3 if !ARCH_AT91SAM9263
drivers/rtc/Kconfig:1001:       range 0 15 if ARCH_AT91SAM9263
drivers/usb/gadget/Kconfig:157: depends on AVR32 || ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
drivers/usb/gadget/atmel_usba_udc.c:329:#if defined(CONFIG_ARCH_AT91SAM9RL)
drivers/usb/gadget/atmel_usba_udc.c:349:#endif /* CONFIG_ARCH_AT91SAM9RL */
drivers/mmc/host/Kconfig:305:   depends on MMC_ATMELMCI && (AVR32 || ARCH_AT91SAM9G45) && DMA_ENGINE
drivers/usb/gadget/Kconfig:157: depends on AVR32 || ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
drivers/net/can/Kconfig:68:     depends on ARCH_AT91SAM9263 || ARCH_AT91SAM9X5


Paul Bolle
