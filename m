From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 17 Jul 2012 16:02:42 +0200
Subject: Device tree.
In-Reply-To: <5b5e32ecde7b96d3af217054150eb43c@codethink.co.uk>
References: <500552C9.4090107@codethink.co.uk> <50056E22.5040308@gmail.com>
 <5b5e32ecde7b96d3af217054150eb43c@codethink.co.uk>
Message-ID: <13863985.aH2icoQzEI@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012 14:56:33 Ben Dooks wrote:
> On 17/07/2012 14:52, Rob Herring wrote:
> > On 07/17/2012 08:25 AM, Ben Dooks wrote:
> >> On 17/07/2012 14:07, Ian Molton wrote:
> >>> On 17/07/12 13:32, Josh Coombs wrote:
> >>>> make make target.dtb
> >>>> cat arch/arm/boot/target.dtb  >> arch/arm/boot/zImage
> >>>> make uImage
> >>>
> >>> Yick...
> >>
> >> How about adding a dts=<address> argument to the current
> >> command line handling. If this is found, then the system
> >> ignores the rest of the atags passed and uses the passed
> >> address for the device-tree settings.
> >>
> >> This means in u-boot, you just need to load the .dts file
> >> into place before booting the kernel.
> >>
> > You mean dtb...
> >
> > But no, we don't need a 3rd boot interface in the kernel. I don't see
> > why cat + mkimage is too hard to run.
> 
> I suppose we can produce our own build-script
> 
> > Now that u-boot has direct support for zImage booting, I doubt 
> > anything
> > uImage building related will ever be accepted into the kernel.
> 
> Depends on u-boot, the one we have been supplied doesn't seem to
> have any interest in booting zImages.

In that case you just need to make sure that you produce a valid uImage of 
your zImage+dtb appended. This is what I use on old (1.1.6) uboot versions 
without any issues.
--
Florian
