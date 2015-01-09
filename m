From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 9 Jan 2015 14:24:44 +0800
Subject: [RFC] usb: dwc3: add DWC3_SKIP_USB3PHY and DWC3_SKIP_USB2_PHY
 quirks
In-Reply-To: <20150108170815.GJ31926@saruman>
References: <20141208213551.38860f81@xhacker> <20150108170815.GJ31926@saruman>
Message-ID: <20150109142444.49e0ff2f@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Thu, 8 Jan 2015 09:08:15 -0800
Felipe Balbi <balbi@ti.com> wrote:

> Hi,
> 
> On Mon, Dec 08, 2014 at 09:35:51PM +0800, Jisheng Zhang wrote:
> > On platforms which has native usb hosts/phys and pci-dwc3 controller,
> > the dwc3 core may get the wrong usb2_phy and usb3_phy by
> > devm_usb_get_phy(). It depends on which usb phy driver is initialized
> > firstly, the usb_phy_generic or the native/real usb phy driver.
> 
> why are you initializing generic PHY if you have a real PHY ?

we have two kind of usb hosts: the native usb hosts which can be probed via. DT
and the usb hosts from pci-dwc3. The former has real phy and the latter doesn't.

> 
> > Before all old USB phy library usage removed, the solution I can have
> > is to add DWC3_SKIP_USB3PHY and DWC3_SKIP_USB2_PHY quirks and set them
> > in dwc3-pci.
> > Could such modification can be accepted? If not, could you please give
> > alternative suggestions?
> 
> we will not accept a quirk to skip PHYs, sorry. A better way of handling
> this needs to be found.
> 

OK, Got your points. It seems we need to deprecate old usb phy library usage
early.

Thanks,
Jisheng
