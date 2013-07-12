From: robherring2@gmail.com (Rob Herring)
Date: Fri, 12 Jul 2013 15:17:57 -0500
Subject: Sharing *.dtsi between Linux architectures?
In-Reply-To: <51E05FEB.1090308@wwwdotorg.org>
References: <51E05FEB.1090308@wwwdotorg.org>
Message-ID: <51E06475.6010006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2013 02:58 PM, Stephen Warren wrote:
> Is there a (possibly just proposed) mechanism in place to allow *.dts
> from multiple Linux architectures to share common *.dtsi files?

Nothing proposed yet. There was some discussion at Connect (which I
missed part of). We're certainly going to start to have that issue
between arm and arm64 as well as probably FSL powerpc and arm.

I would like to move all dts files out of arch. I think we should think
about how we construct a separate dts repository and then move the
kernel structure in that direction (it's still believed there is too
much interdependency to have separate repo yet). I don't think cpu
architecture is the right top level structure for dts files. Probably
something by vendor and/or SOC family is more appropriate. Then you have
to figure out how to handle board vs. chip vendors.

> As an example, consider two SoCs that are identical except for the CPU
> complex. One uses an ARMv7 CPU (DTs in arch/arm/boot/dts/) and the other
> uses some ARMv8 CPU (DTs in arch/am64/boot/dts/). It'd be useful to
> define all the SoC components in some common .dtsi file to avoid
> duplication, and have both arch/arm/boot/dts/tegraXXX.dtsi and
> arch/arm64/boot/dts/tegraYYY.dtsi include that and add the relevant
> CPU-related nodes.
> 
> I could imagine creating one of the following paths for this purpose:
> 
> arch/common/dts/
> include/dt-common/
> include/dtsi/
> 
> ... or perhaps re-using the existing:
> 
> include/dt-bindings/
> 
> ... although my original intent for that last location was just to house
> header files that define constants that are part of binding definitions,
> rather than actual structural content.

I think we should stick with defines there.

Rob
