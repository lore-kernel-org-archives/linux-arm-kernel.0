From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 8 Dec 2014 21:35:51 +0800
Subject: [RFC] usb: dwc3: add DWC3_SKIP_USB3PHY and DWC3_SKIP_USB2_PHY quirks
Message-ID: <20141208213551.38860f81@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi list,

On platforms which has native usb hosts/phys and pci-dwc3 controller, the dwc3
core may get the wrong usb2_phy and usb3_phy by devm_usb_get_phy(). It depends
on which usb phy driver is initialized firstly, the usb_phy_generic or the
native/real usb phy driver.

Before all old USB phy library usage removed, the solution I can have is to
add DWC3_SKIP_USB3PHY and DWC3_SKIP_USB2_PHY quirks and set them in dwc3-pci.
Could such modification can be accepted? If not, could you please give alternative
suggestions?

Thanks,
Jisheng
