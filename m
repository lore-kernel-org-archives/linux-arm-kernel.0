From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 May 2015 10:48:02 -0500
Subject: [PATCH v2 06/13] musb: Add support for the Allwinner sunxi musb
 controller
In-Reply-To: <1426878682-14521-7-git-send-email-hdegoede@redhat.com>
References: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
 <1426878682-14521-7-git-send-email-hdegoede@redhat.com>
Message-ID: <20150526154802.GL26599@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 08:11:15PM +0100, Hans de Goede wrote:
> This is based on initial code to get the Allwinner sunxi musb controller
> supported by Chen-Yu Tsai and Roman Byshko.
> 
> This adds support for the Allwinner sunxi musb controller in both host only
> and otg mode. Peripheral only mode is not supported, as no boards use that.
> 
> This has been tested on a cubietruck (A20 SoC) and an UTOO P66 tablet
> (A13 SoC) with a variety of devices in host mode and with the g_serial gadget
> driver in peripheral mode, plugging otg / host cables in/out a lot of times
> in all possible imaginable plug orders.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

drivers/usb/musb/sunxi.c:28:11: error: unable to open 'linux/soc/sunxi/sunxi_sram.h'
scripts/Makefile.build:264: recipe for target 'drivers/usb/musb/sunxi.o' failed
make[2]: *** [drivers/usb/musb/sunxi.o] Error 1
make[2]: *** Waiting for unfinished jobs....
scripts/Makefile.build:403: recipe for target 'drivers/usb/musb' failed
make[1]: *** [drivers/usb/musb] Error 2
Makefile:1548: recipe for target 'drivers/usb/' failed
make: *** [drivers/usb/] Error 2

What is the dependency ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150526/c800a34a/attachment.sig>
