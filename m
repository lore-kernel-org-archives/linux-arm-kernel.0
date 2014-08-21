From: balbi@ti.com (Felipe Balbi)
Date: Thu, 21 Aug 2014 09:10:23 -0500
Subject: [PATCH v4 2/3] usb: dwc3: dwc3-st: Add st-dwc3 devicetree
 bindings documentation
In-Reply-To: <20140821140347.GA21073@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1406734091-16202-1-git-send-email-peter.griffin@linaro.org>
 <1406734091-16202-3-git-send-email-peter.griffin@linaro.org>
 <20140820180005.GU24500@saruman.home>
 <20140821133340.GC17487@griffinp-ThinkPad-X1-Carbon-2nd>
 <20140821135620.GD9608@saruman.home>
 <20140821140347.GA21073@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20140821141023.GA11146@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Thu, Aug 21, 2014 at 03:03:47PM +0100, Peter Griffin wrote:
> Hi Felipe,
> 
> On Thu, 21 Aug 2014, Felipe Balbi wrote:
> 
> > > Currently (in the vendor tree) one of the phys lives in
> > > drivers/usb/phy and the other in drivers/phy.
> > > I believe that is because one is only a usb phy and the other is a
> > > multi function phy which can drive PCI-E or USB3.
> > 
> > right, but for mainline, we can have both PHYs in drivers/phy only.
> 
> Ah ok, I didn't know that, so thanks for that info.
> > 
> > > So to make that work, when dwc3/core.c gets the PHYS in
> > > dwc3_core_get_phy() we need to use the different bindings.
> > > 
> > > I think we are the only platform using "one of each", but luckily
> > > dwc3_core_get_phy() has been written generically enough that it "just
> > > works" :-).
> > 
> > true, but I want to drop support for the legacy drivers/usb/phy layer
> > from dwc3. I'll try to move all PHYs to drivers/phy for v3.18.
> 
> Ok, so for the next re-spin I will change this to just use the generic
> phy binding for both usb2 & usb3 phys.
> 
> In parallel I will also migrate over the drivers/usb/phy driver to be
> just a generic phy before I attempt to upstream it.

Thank you for understanding :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/9e7b3434/attachment.sig>
