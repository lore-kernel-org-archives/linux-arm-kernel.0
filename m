From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 26 Oct 2012 15:34:46 +0200
Subject: [PATCH V2 2/4] arm: mvebu: adding SATA support: dt binding for
 Armada 370/XP
In-Reply-To: <20121026133154.GN18811@titan.lakedaemon.net>
References: <1351254650-26861-1-git-send-email-gregory.clement@free-electrons.com>
 <1351254650-26861-3-git-send-email-gregory.clement@free-electrons.com>
 <20121026133154.GN18811@titan.lakedaemon.net>
Message-ID: <20121026133446.GM21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 09:31:54AM -0400, Jason Cooper wrote:
> On Fri, Oct 26, 2012 at 02:30:47PM +0200, Gregory CLEMENT wrote:
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > Signed-off-by: Lior Amsalem <alior@marvell.com>
> > ---
> >  arch/arm/boot/dts/armada-370-xp.dtsi |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> > index 94b4b9e..a911f7a 100644
> > --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> > +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> > @@ -69,6 +69,15 @@
> >  			compatible = "marvell,armada-addr-decoding-controller";
> >  			reg = <0xd0020000 0x258>;
> >  		};
> > +
> > +		sata at d00a0000 {
> > +                        compatible = "marvell,orion-sata";
> > +                        reg = <0xd00a0000 0x2400>;
> > +                        interrupts = <55>;
> > +			clocks = <&coreclk 0>;
> 
> nit. whitespace?

[Don't shoot the messenger]

How about extending checkpatch to check for this? I guess its just
spaces which should be tabs.

    Andrew
