From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 17 Feb 2016 17:08:27 +0200
Subject: [PATCH 1/7] usb: gadget: pxa25x_udc: move register definitions
 from arch
In-Reply-To: <1453997843-3489728-1-git-send-email-arnd@arndb.de>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-1-git-send-email-arnd@arndb.de>
Message-ID: <87oabfgys4.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

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
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

FYI, this series now sits in my testing/next. If you could just check
that I didn't mess anything up, I'd be glad.

Thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/03af8ac6/attachment.sig>
