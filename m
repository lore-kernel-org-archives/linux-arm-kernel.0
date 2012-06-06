From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Jun 2012 10:27:22 +0800
Subject: [PATCH v3 00/12] add imx usb driver for mx28/6x
In-Reply-To: <20120605150209.GZ28631@arwen.pp.htv.fi>
References: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
 <20120605150209.GZ28631@arwen.pp.htv.fi>
Message-ID: <20120606022714.GA2667@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 06:02:13PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Fri, May 25, 2012 at 10:24:13AM +0800, Richard Zhao wrote:
> > The work is based on  ci13xxx rework done by Alexander Shishkin.
> > 
> > Status:
> >   - this version only support host
> >   - usbotg controler works at host role
> > 
> > Changes since V2:
> >   - Rebase to Alex's tree
> >   - Use regulator to control vbus power
> >   - Remove ARCH check in Kconfig, but add OF_DEV check.
> >   - Other changes according laster version comments.
> > 
> > Richard Zhao (12):
> >   usb: otg: add notify_connect/notify_disconnect callback
> >   usb: chipidea: permit driver bindings pass phy pointer
> >   usb: ehci-hcd: notify phy when connect change
> >   usb: otg: add basic mxs phy driver support
> >   usb: chipidea: add imx platform driver
> >   ARM: imx6q: correct device name of usbphy and usb controller clock
> >     export
> >   ARM: imx6q: add config-on-boot gpios
> >   ARM: imx6q: add usbphy clocks
> >   ARM: imx6q: disable usb charger detector
> >   ARM: dts: imx6q-sabrelite: add usb devices
> >   ARM: mxs: clk_register_clkdev mx28 usb clocks
> >   ARM: dts: imx28-evk: add usb devices
> 
> how are we going to handle these series ? drivers/usb/otg/* parts are
> mostly ok (I need to look deeper) but if I take drivers/usb/otg/* we
> will have to delay drivers/usb/chipidea I guess...
> 
> So someone would have to take the whole series ? Who will be that
> person? Alex, will it be you ?
> 
I'm unsure about drivers/usb part, but arch/arm part should go via
arm-soc tree.

-- 
Regards,
Shawn
