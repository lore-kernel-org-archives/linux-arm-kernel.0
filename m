From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 14 Apr 2015 00:18:22 +0800
Subject: Two new breakages since Thursday
In-Reply-To: <20150411090024.GL12732@n2100.arm.linux.org.uk>
References: <20150405080645.GE13898@n2100.arm.linux.org.uk>
 <20150411090024.GL12732@n2100.arm.linux.org.uk>
Message-ID: <1428941902.7514.73.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-04-11 at 10:00 +0100, Russell King - ARM Linux wrote:
> And almost a week later, and most of these are _still_ present.
> 
> Given that the merge window is potentially opening on Sunday, this
> is _very_ poor, because it means that we've had a week of failing
> builds in the week before the merge window - the week where we
> _should_ be stabilising the code and getting it ready for submission
> to Linus.
> 
> Right now, arm-soc is *NOT* ready for submission to Linus.
> 
> Please fix this as a top priority.
> 
> On Sun, Apr 05, 2015 at 09:06:45AM +0100, Russell King - ARM Linux wrote:
> > Two new breakages have appeared since Thursday.  The first affects both
> > ARM and ARM64 builds (a missing file), the second only ARM builds.
> > 
> > arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h:18:40: fatal error: dt-bindings/pinctrl/mt65xx.h: No such file or directory
> > arch/arm/boot/dts/mt8135-pinfunc.h:18:40: fatal error: dt-bindings/pinctrl/mt65xx.h: No such file or directory
> > arch/arm/mach-at91/pm_suspend.S:143: Error: selected processor does not support ARM mode `dsb'

Hi Arnd/Olof,

The mediatek part is due to merge dependency in pinctrl driver. It is
discussed in
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/336258.html

I thought we already decided to revert DT node in arm-soc tree for 4.1.
What should we do next?

Joe.C
