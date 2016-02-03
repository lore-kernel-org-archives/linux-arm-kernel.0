From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 03 Feb 2016 20:12:59 +0200
Subject: [PATCH 0/7] USB changes for rare warnings
In-Reply-To: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
Message-ID: <87oabxpsr8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd,

Arnd Bergmann <arnd@arndb.de> writes:
> Hi Felipe,
>
> This set of patches addresses warnings I got in randconfig builds,
> in the USB drivers. The first three patches are for the pxa25x
> UDC driver and are a larger scale cleanup triggered by finding
> the initial bug. The other four are relatively simple but still
> need to be reviewed properly, as I have done only compile-time
> testing. After these patches, I get no other warnings for USB
> drivers at the moment.
>
> Arnd Bergmann (7):
>   usb: gadget: pxa25x_udc: move register definitions from arch
>   usb: gadget: pxa25x_udc cleanup
>   usb: gadget: pxa25x_udc: use readl/writel for mmio
>   usb: fsl: drop USB_FSL_MPH_DR_OF Kconfig symbol
>   usb: isp1301-omap: mark power_up as __maybe_unused
>   usb: musb: use %pad format string from dma_addr_t
>   usb: musb/ux500: remove duplicate check for dma_is_compatible
>
>  arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h | 198 ---------
>  arch/arm/mach-pxa/include/mach/pxa25x-udc.h     | 163 --------

for arch/arm I need Acked-by from relevant folks.

Also, do you think we need this during the -rc or can we consider it
non-critical fixes for v4.6 merge window ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/a9a73c4d/attachment-0001.sig>
