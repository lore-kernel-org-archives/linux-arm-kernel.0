From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 11 Aug 2014 08:38:56 -0300
Subject: [PATCH 1/6] ARM: mvebu: Add required ethernet muxing for the
 Armada 370 SoC
In-Reply-To: <53E762A0.5070900@gmail.com>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1407511136-26477-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <53E762A0.5070900@gmail.com>
Message-ID: <20140811113856.GA1665@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Aug 02:16 PM, Sebastian Hesselbarth wrote:
> On 08/08/2014 05:18 PM, Ezequiel Garcia wrote:
> > This commit adds the required pin muxing for the two network interfaces
> > and the MDIO interface, to the Armada 370 SoC.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/armada-370.dtsi | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> > index 21b588b..b0700bf6 100644
> > --- a/arch/arm/boot/dts/armada-370.dtsi
> > +++ b/arch/arm/boot/dts/armada-370.dtsi
> > @@ -151,6 +151,25 @@
> >  						       "mpp62", "mpp60", "mpp58";
> >  					marvell,function = "audio";
> >  				};
> > +
> > +				mdio_pins: mdio_pins {
> 
> Ezequiel,
> 
> please keep me posted next time ;)
> 

Ouch...

> Above should be: mdio_pins: mdio-pins {
> same for the ones below.
> 

OK.

> > +					marvell,pins = "mpp17", "mpp18";
> > +					marvell,function = "ge";
> 
> As we haven't used it before, we could still rename "ge" function to
> more approprate "mdio"... but it is ok.
>

FWIW, I'd rather leave it as it is. If we change the function name, we would
make backporting a PITA, just because of a nitpick.
 
> Besides the comments,
> 
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
