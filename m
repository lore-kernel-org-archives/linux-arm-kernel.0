From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Nov 2013 11:55:39 -0600
Subject: OMAP build failure after this merge window - caused by usb or
 phy Kconfig krap
In-Reply-To: <20131125140927.GP16735@n2100.arm.linux.org.uk>
References: <20131125140927.GP16735@n2100.arm.linux.org.uk>
Message-ID: <20131125175539.GP18046@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 25, 2013 at 02:09:27PM +0000, Russell King - ARM Linux wrote:
> There's no other way to say it, and I've no idea who is responsible for
> this:
> 
>   LD      init/built-in.o
> drivers/built-in.o: In function `omap_usb2_remove':
> powercap_sys.c:(.text+0x1c60): undefined reference to `usb_remove_phy'
> drivers/built-in.o: In function `omap_usb_power_off':
> powercap_sys.c:(.text+0x1c84): undefined reference to `omap_control_usb_phy_power'
> drivers/built-in.o: In function `omap_usb_power_on':
> powercap_sys.c:(.text+0x1ca8): undefined reference to `omap_control_usb_phy_power'
> drivers/built-in.o: In function `omap_usb2_probe':
> powercap_sys.c:(.text+0x1dac): undefined reference to `omap_control_usb_phy_power'
> powercap_sys.c:(.text+0x1e5c): undefined reference to `usb_add_phy_dev'
> drivers/built-in.o: In function `omap_usb2_suspend':
> powercap_sys.c:(.text+0x1ec8): undefined reference to `omap_control_usb_phy_power'
> powercap_sys.c:(.text+0x1f20): undefined reference to `omap_control_usb_phy_power'
> drivers/built-in.o: In function `omap_usb2_set_comparator':
> powercap_sys.c:(.text+0x1f54): undefined reference to `usb_get_phy'
> arch/arm/mach-omap2/built-in.o: In function `usbhs_init_phys':
> dss-common.c:(.text+0xf824): undefined reference to `usb_bind_phy'
> make[1]: *** [vmlinux] Error 1
> make: *** [sub-make] Error 2

Kishon, can you send a patch fixing these ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/a69737e3/attachment.sig>
