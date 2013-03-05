From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Mar 2013 13:36:54 +0200
Subject: Latest randconfig build errors
In-Reply-To: <20130304185424.GR11806@atomide.com>
References: <20130304095136.GI17833@n2100.arm.linux.org.uk>
 <20130304184649.GO11806@atomide.com>
 <20130304185142.GB15203@arwen.pp.htv.fi>
 <20130304185424.GR11806@atomide.com>
Message-ID: <20130305113654.GC19290@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 04, 2013 at 10:54:24AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130304 10:56]:
> > Hi,
> > 
> > On Mon, Mar 04, 2013 at 10:46:50AM -0800, Tony Lindgren wrote:
> > > > The last three are caused by incorrect use of 'select':
> > > > 
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3 && MWAVE) selects SERIAL_8250 which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQS)
> > > > warning: (USB_MUSB_HDRC) selects TWL4030_USB which has unmet direct dependencies (USB_SUPPORT && (USB || USB_GADGET) && TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS)
> > > > warning: (USB_MUSB_HDRC) selects TWL6030_USB which has unmet direct dependencies (USB_SUPPORT && (USB || USB_GADGET) && TWL4030_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS)
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_8250_CONSOLE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQS && SERIAL_8250=y)
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_CORE_CONSOLE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQS)
> > > > warning: (VIDEO_DM6446_CCDC && VIDEO_DM355_CCDC && VIDEO_ISIF && VIDEO_DAVINCI_VPBE_DISPLAY) selects VIDEO_VPSS_SYSTEM which has unmet direct dependencies (MEDIA_SUPPORT && V4L_PLATFORM_DRIVERS && ARCH_DAVINCI)
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3 && MWAVE) selects SERIAL_8250 which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQS)
> > > > warning: (USB_MUSB_HDRC) selects TWL4030_USB which has unmet direct dependencies (USB_SUPPORT && (USB || USB_GADGET) && TWL4030_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS)
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_8250_CONSOLE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQS && SERIAL_8250=y)
> > > > warning: (MACH_OMAP_ZOOM2 && MACH_OMAP_ZOOM3) selects SERIAL_CORE_CONSOLE which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQS)
> > > > warning: (VIDEO_DM6446_CCDC && VIDEO_DM355_CCDC && VIDEO_ISIF && VIDEO_DAVINCI_VPBE_DISPLAY) selects VIDEO_VPSS_SYSTEM which has unmet direct dependencies (MEDIA_SUPPORT && V4L_PLATFORM_DRIVERS && ARCH_DAVINCI)
> > > > 
> > > > This 'select' madness of driver symbols *HAS* *TO* *STOP*.
> > > 
> > > Felipe, can you take a look at removing the MUSB selects from Kconfig?
> > > You might be able to just have MUSB depends on TWL if omap.
> > 
> > I don't think we even need depend or select at all for MUSB. I'll look
> > at it tomorrow.
> 
> OK thanks!

http://marc.info/?l=linux-usb&m=136248269928419&w=2

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130305/a6a887c2/attachment-0001.sig>
