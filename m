From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 May 2015 12:06:02 -0500
Subject: [PATCH v2 06/13] musb: Add support for the Allwinner sunxi musb
 controller
In-Reply-To: <5564A10E.3040402@redhat.com>
References: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
 <1426878682-14521-7-git-send-email-hdegoede@redhat.com>
 <20150526154802.GL26599@saruman.tx.rr.com>
 <5564A10E.3040402@redhat.com>
Message-ID: <20150526170602.GQ26599@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 06:36:30PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 05/26/2015 05:48 PM, Felipe Balbi wrote:
> >On Fri, Mar 20, 2015 at 08:11:15PM +0100, Hans de Goede wrote:
> >>This is based on initial code to get the Allwinner sunxi musb controller
> >>supported by Chen-Yu Tsai and Roman Byshko.
> >>
> >>This adds support for the Allwinner sunxi musb controller in both host only
> >>and otg mode. Peripheral only mode is not supported, as no boards use that.
> >>
> >>This has been tested on a cubietruck (A20 SoC) and an UTOO P66 tablet
> >>(A13 SoC) with a variety of devices in host mode and with the g_serial gadget
> >>driver in peripheral mode, plugging otg / host cables in/out a lot of times
> >>in all possible imaginable plug orders.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> >drivers/usb/musb/sunxi.c:28:11: error: unable to open 'linux/soc/sunxi/sunxi_sram.h'
> >scripts/Makefile.build:264: recipe for target 'drivers/usb/musb/sunxi.o' failed
> >make[2]: *** [drivers/usb/musb/sunxi.o] Error 1
> >make[2]: *** Waiting for unfinished jobs....
> >scripts/Makefile.build:403: recipe for target 'drivers/usb/musb' failed
> >make[1]: *** [drivers/usb/musb] Error 2
> >Makefile:1548: recipe for target 'drivers/usb/' failed
> >make: *** [drivers/usb/] Error 2
> >
> >What is the dependency ?
> 
> Thanks you that you're working on this, the dependency is the sunxi sram
> controller driver which was supposed to get pulled for 4.1, but like many
> other ARM related pull-reqs did not get pulled. And now for 4.2 Arnd
> has decided that he does not like the driver even though it was
> ok for 4.1, and has not yet answered how else we should solve this...
> 
> Arnd, we would really like to move forward with musb support for sunxi
> which means we need a solution for the sram controller, can you please
> answer Maxime's latest mails on this, or accept the driver as is ?

all right, most of the other patches are in my testing/next (please have
a look when you have some extra time) so ony this patch will be pending
for v4.2.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150526/18104f36/attachment.sig>
