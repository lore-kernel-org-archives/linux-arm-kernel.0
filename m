From: jnair@caviumnetworks.com (Jayachandran C)
Date: Fri, 10 Feb 2017 15:07:54 +0000
Subject: [PATCH v4 4/5] dt-bindings: arm64 ARCH_THUNDER2 platform
 documentation
In-Reply-To: <CAL_JsqKm-c6D_fki_TsRYKH3aGoC5GE7n0DazNi7P268aj-93g@mail.gmail.com>
References: <CAK8P3a07eo0htv_y6H_aHvAaeo5two3vQTaySuFXpG+dzYguUQ@mail.gmail.com>
 <1486667612-8168-1-git-send-email-jnair@caviumnetworks.com>
 <CAL_JsqKm-c6D_fki_TsRYKH3aGoC5GE7n0DazNi7P268aj-93g@mail.gmail.com>
Message-ID: <20170210150754.GA1874@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 08:55:31AM -0600, Rob Herring wrote:
> On Thu, Feb 9, 2017 at 1:13 PM, Jayachandran C <jnair@caviumnetworks.com> wrote:
> > Add documentation for Cavium ThunderX2 CN99XX ARM64 processor family.
> > The the SoC will use the ID "cavium,thunderx2-cn9900".
> >
> > Add documentation entry for the "cavium,thunder2" cpu core as well.
> >
> > Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> > ---
> >
> > v3->v4
> > Documentation updates to reflect changes in device tree.
> >
> >  Documentation/devicetree/bindings/arm/cavium-thunder2.txt | 8 ++++++++
> >  Documentation/devicetree/bindings/arm/cpus.txt            | 1 +
> >  2 files changed, 9 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder2.txt
> >
> > diff --git a/Documentation/devicetree/bindings/arm/cavium-thunder2.txt b/Documentation/devicetree/bindings/arm/cavium-thunder2.txt
> > new file mode 100644
> > index 0000000..dc5dd65
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/cavium-thunder2.txt
> > @@ -0,0 +1,8 @@
> > +Cavium ThunderX2 CN99XX platform tree bindings
> > +----------------------------------------------
> > +
> > +Boards with Cavium ThunderX2 CN99XX SoC shall have the root property:
> > +  compatible = "cavium,thunderx2-cn9900", "brcm,vulcan-soc";
> > +
> > +These SoC uses the "cavium,thunder2" core which will be compatible
> > +with "brcm,vulcan".
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> > index a1bcfee..74f0b23 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> > @@ -169,6 +169,7 @@ nodes to be present and contain the properties described below.
> >                             "brcm,brahma-b15"
> >                             "brcm,vulcan"
> >                             "cavium,thunder"
> > +                           "cavium,thunder2"
> 
> Is this the same as brcm,vulcan?

It will have a different CPU ID, with different implementer and part num,
but compatible with "brcm,vulcan". In the ThunderX2 dtsi file (once
ARCH_VULCAN goes away), we want to be compatable = "cavium,thunder2", with
maybe "brcm,vulcan" after that.

JC.
