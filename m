From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Mon, 22 Aug 2016 21:16:17 +0200
Subject: [PATCH v2 0/7] musb: sunxi: Add support for run-time changing
 dr-mode through sysfs
In-Reply-To: <20160819212540.GB1853@uda0271908>
References: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
 <20160819212540.GB1853@uda0271908>
Message-ID: <20160822191615.hqnswn6d4cosvbs5@vip.cybercity.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 04:25:40PM -0500, Bin Liu wrote:
> Hi,
> 
> On Mon, Aug 15, 2016 at 09:21:25PM +0200, Hans de Goede wrote:
> > Hi All,
> > 
> > Here is a patch series which implements run-time changing the dr-mode
> > of sunxi musb controllers through the (already existing) musb "mode"
> > sysfs attribute.
> > 
> > This is useful on boards where there is no id pin, e.g. some tv-boxes
> > use the musb controller to get an extra usb A port without needing
> > a hub chip. Except for the missing id pin when using a usb A<->A cable
> > these ports can do peripheral mode just fine. This series makes it
> > possible to do e.g. this by doing echo "peripheral" > mode before
> > plugging in the usb A<->A cable.
> 
> Well, this is an illegal usecase. A-A cable is invalid by USB Spec.

TV boxes with the Sunchip CX-A99 board inside are an example of such
devices and they ship with a cable that has a type-A plug at both ends,
precisely to allow you to connect the board to a USB host. It is standard
practice to do so with that board [1][2] and I've had mine connected that
way for the last few months while working on mainline kernel support.

> With type-A receptacle the controller should be in host-only mode,
> switching to peripheral mode should not be allowed.
[...]
> This is not a problem. With a type-A connector, the dual-role controller
> should work in host-only mode.
> 
> Role switching should only be allowed if an AB connector is used.

The Openmoko Neo 1973 and Neo Freerunner have just a Mini-B connector
but the s3c24xx USB port is switchable between host mode and peripheral
mode.[3] Should that also be disallowed then?

> Using the sysfs entry to switch roles for generic purpose is really a
> bad idea, it opens up ton of problems.

Openmoko kernels have since November 2008 had the funtionality to switch
roles of the USB port using a sysfs attribute. Can you be more specific
about the "ton of problems"? I have one of those devices as well as a
CX-A99, so I'd like to know what I've overlooked.

[1] http://forum.tronsmart.com/forum/tronsmart-draco-aw80/211-instructions-for-firmware-updating-via-pc#642
[2] https://linux-sunxi.org/FEL
[3] http://wiki.openmoko.org/wiki/Specialized_USB_cables
-- 
Rask Ingemann Lambertsen
