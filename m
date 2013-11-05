From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Nov 2013 10:15:31 -0500
Subject: [PATCH v3 25/28] ARM: mvebu: Add support for NAND controller
 in Armada 370/XP
In-Reply-To: <20131105135145.GA2676@localhost>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-26-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131105132905.GJ3060@titan.lakedaemon.net>
 <20131105135145.GA2676@localhost>
Message-ID: <20131105151531.GK3060@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 10:51:46AM -0300, Ezequiel Garcia wrote:
> On Tue, Nov 05, 2013 at 08:29:05AM -0500, Jason Cooper wrote:
> > On Tue, Nov 05, 2013 at 09:55:32AM -0300, Ezequiel Garcia wrote:
> > > The Armada 370 and Armada XP SoC have a NAND controller (aka NFCv2).
> > > This commit adds support for it in Armada 370 and Armada XP SoC
> > > common devicetree.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  arch/arm/boot/dts/armada-370-xp.dtsi | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> > > index 01e69fc..b4e6898 100644
> > > --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> > > +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> > > @@ -258,6 +258,15 @@
> > >  				status = "disabled";
> > >  			};
> > >  
> > > +			nand at d0000 {
> > > +				compatible = "marvell,armada370-nand";
> > 
> > Could you please provide a separate patch updating the devicetree
> > binding documentation?  You can also Cc the entire series to the
> > devicetree ml as long as the documentation patch is easy to find in the
> > series.  eg 'dt: binding: ...'
> > 
> 
> Hm.. actually the controller already supports the new compatible string
> so the binding documentation should be added now.

$ git grep -n 'marvell,armada370-nand' -- Documentation/devicetree/bindings/
$

Perhaps in v3.13-rc1?

> And I'd rather do that in a separate patch, to avoid cluttering the poor
> devicetree people with an unrelated 28-piece patch :-)

No (really), according to Grant and Mark during the closing session, I
asked this specific question.  They _do_ want the entire series so they
can refer to the corresponding code changes if necessary.  As I stated
above, we can make their job easier by making the binding a separate
patch that is clearly marked as such.

> BTW: who should take such a patch? I'm still a little lost regarding
> who takes the binding or dts patches for a given subsystem.

The appropriate sub-system maintainer still takes the patches, we simply
wait a bit for the DT binding maintainers to chime in.  If they don't
after a few weeks, we can take it without their Ack.

If the maintainer is unsure, or needs help reviewing the binding, they
can always ping the DT folks for assistance.

thx,

Jason.
