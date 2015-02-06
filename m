From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 6 Feb 2015 20:55:12 +0800
Subject: Recommendations for a new MFD device driver?
In-Reply-To: <20150206115418.GV21293@sirena.org.uk>
References: <20150206101006.GK12209@pengutronix.de>
 <20150206115418.GV21293@sirena.org.uk>
Message-ID: <1423227312.31210.286.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-02-06 at 11:54 +0000, Mark Brown wrote:
> On Fri, Feb 06, 2015 at 11:10:06AM +0100, Sascha Hauer wrote:
> 
> > 1) Put it into the RTC device driver.
> > 2) Put it into the .resource field of struct mfd_cell
> > 3) Put it into the device tree using standard reg, interrupt properties and
> >    a) Let the RTC driver interpret these
> >    b) Let the MFD driver create resources in the .resource field of struct
> >       mfd_cell
> >    c) Let the MFD core create the resources
> 
> > I have a tendency to 3, but I'm afraid that the resource informations
> > are duplicated too much in the device tree source files, because every
> > user would have to carry a full description of the mfd device. Maybe
> > that duplication could be reduced with some CPP magic, I don't know.
> 
> > Maybe this is a solved problem and I'm just not picking a good example
> > from drivers/mfd.
> 
> The wm831x drivers take option 2 but are pre-DT, it still seems the most
> sensible thing to me though - no need for the user to have to repeat
> this information in every DT and easy to add new stuff if we need it.
> You could use a .dtsi like we use for SoCs to reduce the duplication
> required if you do decide to put things in the DT.

Hi,

I think we should create a dtsi file, say mt6397.dtsi, the regulator
device nodes are already too much to duplicate into every board using
mt6397.

But a new problem is where should we put it? MT6397 is used in both
mt8135-evbp1(armv7) & mt8173-evb(armv8) boards, so they both need
mt6397.dtsi. Should we put them in include/dt-bindings to avoid
duplicate it into both arch/arm/boot/dts and arch/arm64/boot/dts?

Joe.C
