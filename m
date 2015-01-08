From: balbi@ti.com (Felipe Balbi)
Date: Thu, 8 Jan 2015 11:08:15 -0600
Subject: [RFC] usb: dwc3: add DWC3_SKIP_USB3PHY and DWC3_SKIP_USB2_PHY
 quirks
In-Reply-To: <20141208213551.38860f81@xhacker>
References: <20141208213551.38860f81@xhacker>
Message-ID: <20150108170815.GJ31926@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 08, 2014 at 09:35:51PM +0800, Jisheng Zhang wrote:
> On platforms which has native usb hosts/phys and pci-dwc3 controller,
> the dwc3 core may get the wrong usb2_phy and usb3_phy by
> devm_usb_get_phy(). It depends on which usb phy driver is initialized
> firstly, the usb_phy_generic or the native/real usb phy driver.

why are you initializing generic PHY if you have a real PHY ?

> Before all old USB phy library usage removed, the solution I can have
> is to add DWC3_SKIP_USB3PHY and DWC3_SKIP_USB2_PHY quirks and set them
> in dwc3-pci.
> Could such modification can be accepted? If not, could you please give
> alternative suggestions?

we will not accept a quirk to skip PHYs, sorry. A better way of handling
this needs to be found.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/98e36480/attachment.sig>
