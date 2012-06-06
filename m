From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 Jun 2012 09:03:50 +0300
Subject: [PATCH v3 00/12] add imx usb driver for mx28/6x
In-Reply-To: <20120606022714.GA2667@S2101-09.ap.freescale.net>
References: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
 <20120605150209.GZ28631@arwen.pp.htv.fi>
 <20120606022714.GA2667@S2101-09.ap.freescale.net>
Message-ID: <20120606060348.GD32345@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2012 at 10:27:22AM +0800, Shawn Guo wrote:
> On Tue, Jun 05, 2012 at 06:02:13PM +0300, Felipe Balbi wrote:
> > Hi,
> > 
> > On Fri, May 25, 2012 at 10:24:13AM +0800, Richard Zhao wrote:
> > > The work is based on  ci13xxx rework done by Alexander Shishkin.
> > > 
> > > Status:
> > >   - this version only support host
> > >   - usbotg controler works at host role
> > > 
> > > Changes since V2:
> > >   - Rebase to Alex's tree
> > >   - Use regulator to control vbus power
> > >   - Remove ARCH check in Kconfig, but add OF_DEV check.
> > >   - Other changes according laster version comments.
> > > 
> > > Richard Zhao (12):
> > >   usb: otg: add notify_connect/notify_disconnect callback
> > >   usb: chipidea: permit driver bindings pass phy pointer
> > >   usb: ehci-hcd: notify phy when connect change
> > >   usb: otg: add basic mxs phy driver support
> > >   usb: chipidea: add imx platform driver
> > >   ARM: imx6q: correct device name of usbphy and usb controller clock
> > >     export
> > >   ARM: imx6q: add config-on-boot gpios
> > >   ARM: imx6q: add usbphy clocks
> > >   ARM: imx6q: disable usb charger detector
> > >   ARM: dts: imx6q-sabrelite: add usb devices
> > >   ARM: mxs: clk_register_clkdev mx28 usb clocks
> > >   ARM: dts: imx28-evk: add usb devices
> > 
> > how are we going to handle these series ? drivers/usb/otg/* parts are
> > mostly ok (I need to look deeper) but if I take drivers/usb/otg/* we
> > will have to delay drivers/usb/chipidea I guess...
> > 
> > So someone would have to take the whole series ? Who will be that
> > person? Alex, will it be you ?
> > 
> I'm unsure about drivers/usb part, but arch/arm part should go via
> arm-soc tree.

Yes, sure but the whole series is very "coupled" together... Maybe
Richard could try to split this series into things that can go through
arm-soc with no dependency on the other part and things that depend on
drivers/usb/*

Richard, can you do that ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120606/649ec1a6/attachment.sig>
