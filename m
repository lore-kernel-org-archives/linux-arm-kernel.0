From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Apr 2014 14:33:27 -0400
Subject: [PATCH v2 10/10] ARM: mvebu: Enable the thermal sensor in
 Armada 380/385 SoC
In-Reply-To: <20140428164403.GA17824@arch.cereza>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1398371004-15807-11-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140428164403.GA17824@arch.cereza>
Message-ID: <20140428183327.GA28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 01:44:03PM -0300, Ezequiel Garcia wrote:
> On Apr 24, Ezequiel Garcia wrote:
> > This commit enables the thermal sensor found in Armada 380/385 SoCs.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/armada-38x.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> > index a064f59..02c6139 100644
> > --- a/arch/arm/boot/dts/armada-38x.dtsi
> > +++ b/arch/arm/boot/dts/armada-38x.dtsi
> > @@ -346,6 +346,12 @@
> >  				clock-output-names = "nand";
> >  			};
> >  
> > +			thermal at e8078 {
> > +				compatible = "marvell,armada380-thermal";
> > +				reg = <0xe4078 0x4>, <0xe404 0x4>;
> 
> Dammit, there's a stupid typo in the register offset. I never noticed this, because
> the initialization sequence does not do much, and this register is not really used
> (for now). The fix is this:
> 
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 02c6139..370220f 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -348,7 +348,7 @@
>  
>  			thermal at e8078 {
>  				compatible = "marvell,armada380-thermal";
> -				reg = <0xe4078 0x4>, <0xe404 0x4>;
> +				reg = <0xe4078 0x4>, <0xe4074 0x4>;
>  				status = "okay";
>  			};
>  
> Want me to send a follow-up patch?

Nope, I squashed it in and pushed it out.

thx,

Jason.
