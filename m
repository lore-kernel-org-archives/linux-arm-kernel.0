From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Jun 2011 14:51:37 +0300
Subject: [RFC][PATCH 2/5] ARM: SAMSUNG: Changing the build condition of
	OTG platform device for samsung.
In-Reply-To: <BANLkTikPt=_KNpoJ4Xawz_PYMmZg3PnR9g@mail.gmail.com>
References: <0LN4003LQZBUSGU0@mailout4.samsung.com>
	<BANLkTikPt=_KNpoJ4Xawz_PYMmZg3PnR9g@mail.gmail.com>
Message-ID: <20110621115136.GC2531@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 21, 2011 at 05:20:25PM +0530, Praveen Paneri wrote:
> > > @@ -37,7 +39,12 @@ static struct resource s3c_usb_hsotg_resources[] = {
> > >??static u64 s3c_hsotg_dmamask = DMA_BIT_MASK(32);
> > >
> > >??struct platform_device s3c_device_usb_hsotg = {
> > > +#ifdef CONFIG_S3C_DEV_USB_HSOTG
> > >?? .name = "s3c-hsotg",
> > > +#endif
> > > +#ifdef CONFIG_S3C_DEV_DWC_OTG
> > > + .name = "dwc_otg",
> > > +#endif
> >
> > no, don't do that. See we're going through a big re-factor on the gadget
> > framework to allow multiple UDC drivers to be compiled as modules. The
> > idea is to be able to have distro-like kernels for embedded too.
> It can be build as a module but need to make necessary modifications in
> platform code. Will modify according to the gadget framework.

can't you do runtime detection of which platform you're running on ?
Then you add one or the other platform_device. But ifdeferry won't help
you in the long run.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110621/a1b1e70c/attachment.sig>
