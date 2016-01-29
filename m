From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 29 Jan 2016 10:32:07 +0100
Subject: [PATCH 1/7] usb: gadget: pxa25x_udc: move register definitions
 from arch
In-Reply-To: <1453997843-3489728-1-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Thu, 28 Jan 2016 17:17:02 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-1-git-send-email-arnd@arndb.de>
Message-ID: <87vb6c7mug.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> ixp4xx and pxa25x both use this driver and provide a slightly
> different set of register definitions for it. Aside from that,
> the definition in the ixp4xx-regs.h header conflicts with the
> on in the pxa27x device driver when compile-testing that:
>
> In file included from ../drivers/usb/gadget/udc/pxa27x_udc.c:37:0:
> ../drivers/usb/gadget/udc/pxa27x_udc.h:26:0: warning: "UDCCR" redefined
>  #define UDCCR  0x0000  /* UDC Control Register */
>  ^
> In file included from ../arch/arm/mach-ixp4xx/include/mach/hardware.h:27:0,
>                  from ../arch/arm/mach-ixp4xx/include/mach/io.h:18,
>                  from ../arch/arm/include/asm/io.h:194,
>                  from ../include/linux/io.h:25,
>                  from ../include/linux/irq.h:24,
>                  from ../drivers/usb/gadget/udc/pxa27x_udc.c:23:
> ../arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h:415:0: note: this is the location of the previous definition
>  #define UDCCR  IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0000)
>
> This addresses both issues by moving all the definitions into the
> pxa25x_udc driver itself. It turns out the only difference between
> them was 'UDCCS_IO_ROF', and that could well be a mistake when it
> was incorrectly copied from pxa25x to ixp4xx.
Hi Arnd,

Is there a reason to have chosen to move into pxa25_udc.c instead of
drivers/usb/gadget/udc/pxa25x_udc.h ? pxa27x_udc has a .h in the same directory
with register definitions, hence the question.

Cheers.

--
Robert
