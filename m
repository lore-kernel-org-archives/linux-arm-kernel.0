From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Mon, 22 May 2017 20:13:17 +0200
Subject: [PATCH 06/13] ARM: dts: armada-385-linksys: usb3 label cleanup
In-Reply-To: <20170522145515.GK29447@lunn.ch>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
 <20170521124903.11050-7-ralph.sennhauser@gmail.com>
 <20170522145515.GK29447@lunn.ch>
Message-ID: <20170522201317.3f9a4d4b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 May 2017 16:55:15 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Sun, May 21, 2017 at 02:48:55PM +0200, Ralph Sennhauser wrote:
> > Now that we use the reference for the USB3.0 port update the node
> > name and labels for the phy and vbus to match the label used by
> > armada-38x.dtsi.
> > 
> > Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> > 
> > ---
> > 
> > Notes:
> > 
> >   Going by documentation regulator-name is only of informative
> > nature so changing it should be a non issue.  
> 
> Does the regulator name appear in /sys somewhere?

To differentiate between node-name and regulator-name property I changed
the regulator name to usb3_1-vbus-regulator-name

# find /sys -name *usb3_1-vbus*
/sys/kernel/debug/regulator/usb3_1-vbus-regulator-name
/sys/devices/platform/usb3_1-vbus
/sys/firmware/devicetree/base/soc/internal-regs/pinctrl at 18000/usb3_1-vbus-pins
/sys/firmware/devicetree/base/usb3_1-vbus
/sys/bus/platform/devices/usb3_1-vbus
/sys/bus/platform/drivers/reg-fixed-voltage/usb3_1-vbus

So yes, however, only under /sys/kernel/debug and more importantly not
under /sys/class which would be covered by
Documentation/ABI/testing/sysfs-class-regulator.

How the description is worded in regulator.txt [1] under optional
properties, "regulator-name: A string used as a descriptive name for
regulator outputs" doesn't give the impression its considered part of
the ABI implicitly either, well, as you know this might just be my lack
of English skill. As I was uncertain and still am not under the
impression this to be an issue I decided to change it and leave a note
so it doesn't make it in unnoticed and can be discussed / clarified.

Changing the node name has a similar impact but the same can be said
for gpio_keys vs gpio-keys which got your Reviewed-by already.

The new name would better match some recent dts additions beside being
the more obvious choice with the related changes.

[1] Documentation/devicetree/bindings/regulator/regulator.txt 

Ralph
