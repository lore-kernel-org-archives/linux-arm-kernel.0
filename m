From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 5 Dec 2013 12:04:46 +0530
Subject: [PATCH v3 04/10] usb: dwc3: use quirks to know if a particualr
 platform doesn't have PHY
In-Reply-To: <20131204144027.GB21055@xps8300>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
 <1385373690-12170-5-git-send-email-kishon@ti.com>
 <20131204144027.GB21055@xps8300>
Message-ID: <52A01E86.50406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 04 December 2013 08:10 PM, Heikki Krogerus wrote:
> Hi guys,
> 
> Kishon, sorry I did not see this v3 set.
> 
> On Mon, Nov 25, 2013 at 03:31:24PM +0530, Kishon Vijay Abraham I wrote:
>> There can be systems which does not have an external phy, so get
>> phy only if no quirks are added that indicates the PHY is not present.
>> Introduced two quirk flags to indicate the *absence* of usb2 phy and
>> usb3 phy. Also remove checking if return value is -ENXIO since it's now
>> changed to always enable usb_phy layer.
> 
> Can you guys explain why is something like this needed? Like with
> clocks and gpios, the device drivers shouldn't need to care any more
> if the platform has the phys or not. -ENODEV tells you your platform

Shouldn't we report if a particular platform needs a PHY and not able to get
it. How will a user know if a particular controller is not working because it's
not able to get and initialize the PHYs? Don't you think in such cases it's
better to fail (and return from probe) because the controller will not work
anyway without the PHY?

Thanks
Kishon
