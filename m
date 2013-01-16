From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 Jan 2013 09:13:51 +0200
Subject: [RFC PATCH 0/7] usb: musb: add driver for control module
In-Reply-To: <50F6423C.2020307@ti.com>
References: <1358239378-10030-1-git-send-email-kishon@ti.com>
 <201301151341.08297.arnd@arndb.de> <50F56A1A.3040504@ti.com>
 <20130115150432.GB26272@arwen.pp.htv.fi>
 <6C6B28D4DC342643927BEAFCE8707BF63EA5ACAB@DBDE01.ent.ti.com>
 <50F6423C.2020307@ti.com>
Message-ID: <20130116071351.GC610@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 11:31:32AM +0530, kishon wrote:
> Hi Ravi,
> 
> On Tuesday 15 January 2013 09:36 PM, B, Ravi wrote:
> >>Hi,
> >>
> >>On Tue, Jan 15, 2013 at 08:09:22PM +0530, kishon wrote:
> >>>Hi Arnd,
> >>>
> >>>On Tuesday 15 January 2013 07:11 PM, Arnd Bergmann wrote:
> >>>>On Tuesday 15 January 2013, Kishon Vijay Abraham I wrote:
> >>>>>Added a new driver for the usb part of control module.
> >>This has an
> >>>>>API to power on the USB2 phy and an API to write to the mailbox
> >>>>>depending on whether MUSB has to act in host mode or in
> >>device mode.
> >>>>>
> >>>>>Writing to control module registers for doing the above
> >>task which
> >>>>>was previously done in omap glue and in omap-usb2 phy is removed.
> >>>>>
> >>>>>Also added the dt data to get MUSB working in OMAP platforms.
> >>>>>This series has patches for both drivers and ARCH
> >>folders, so If it
> >>>>>has to be split I'll do it.
> >>>>>
> >>>>
> >>>>The series looks good to me, I just had a minor comment on
> >>one patch.
> >>>>
> >>>>One a somewhat related topic, I wonder whether there are
> >>any plans on
> >>>>your side to change this driver to support multiple bus
> >>glues to be
> >>>>built for one kernel image. With a multiplatform kernel,
> >>we may need
> >>>>all of TUSB6010/OMAP2PLUS/DSPS/UX500 for instance.
> >>>
> >>>We don't have plans as of now. I actually don't expect any
> >>changes in
> >>>the driver other than the Kconfig changes. Anyways the
> >>probe of glue's
> >>>other than the platform it's running won't get called. right Felipe?
> >
> >If understand correctly the control module driver used to configure the respective usb phy of SoC to respective usb modes using the common set of control module APIs.
> What if, if control module interface (register defintions) varies b/w
> different revision or spin of same type of SoCs, if usbphy type is
> changed.
> Well in that case, we can write to the registers based on the IP
> revision check (I think thats the common practice to do).
> 
> In this case whether the single instance of control module driver is
> good enough to cater of all cpu types of same SoC series ?
> Of course. I don't see why we can't have the same driver to handle
> different versions of the same IP.
> The only reason where we might need multiple instance is if the SoC
> have multiple control module which Arnd already pointed out.
> 
> >Whether cpu_is_xxx() can be used to differentiate b/w different cpu types in CM driver?
> Not needed at all IMHO. We can use revision register to differentiate.
> 
> Btw I think Felipe looped you for a different reason ;-)

right, it was to look at removing <mach/*> inclusion from all
davinci-link glue layers (they should be combined, btw).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130116/6cf028ad/attachment.sig>
