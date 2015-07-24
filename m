From: HenryC.Chen@mediatek.com (Henry Chen)
Date: Fri, 24 Jul 2015 11:35:51 +0800
Subject: [PATCH v3 1/2] dt-bindings: regulator: mt6311: Add document for
 mt6311 regulator
In-Reply-To: <CABxcv==6R46AqkTBHPfHdWc8gJZigQdREieZMVkLY9AEvevtUw@mail.gmail.com>
References: <1437622799-28115-1-git-send-email-henryc.chen@mediatek.com>
 <1437622799-28115-2-git-send-email-henryc.chen@mediatek.com>
 <CABxcv==6R46AqkTBHPfHdWc8gJZigQdREieZMVkLY9AEvevtUw@mail.gmail.com>
Message-ID: <1437708951.30329.92.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Thu, 2015-07-23 at 10:43 +0200, Javier Martinez Canillas wrote:
> Hello Henry,
> 
> On Thu, Jul 23, 2015 at 5:39 AM, Henry Chen <henryc.chen@mediatek.com> wrote:
> > This patch adds a list of supported regulator names to the devicetree
> > binding documentation for Mediatek MT6311 PMIC.
> >
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  .../bindings/regulator/mt6311-regulator.txt        | 35 ++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/mt6311-regulator.txt
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/mt6311-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6311-regulator.txt
> > new file mode 100644
> > index 0000000..9387d6d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/mt6311-regulator.txt
> > @@ -0,0 +1,35 @@
> > +Mediatek MT6311 Regulator Driver
> > +
> > +Required properties:
> > +- compatible: "mediatek,mt6311-regulator"
> > +- reg: I2C slave address, usually 0x6b.
> > +- regulators: List of regulators provided by this controller. It is named
> > +  to VDVFS and VBIASN.
> > +  The definition for each of these nodes is defined using the standard binding
> > +  for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
> > +
> > +The valid names for regulators are:
> > +BUCK:
> > +  VDVFS
> > +LDO:
> > +  VBIASN
> > +
> > +Example:
> 
> Sorry, I missed this in the previous revision but the ePAPR document
> says "the name of a node should be somewhat generic, reflecting the
> function of the device and not its precise programming model."
> 
> > +       pmic: mt6311 at 6B {
> 
> So this should be:
> 
> mt6311: pmic@

Ok, I will change it, thanks for reviewing.

Henry
> 
> > +               compatible = "mediatek,mt6311-regulator";
> > +               reg = <0x6B>;
> > +
> > +               regulators {
> > +                       mt6311_vcpu_reg: VDVFS {
> > +                               regulator-name = "VDVFS";
> > +                               regulator-min-microvolt = < 600000>;
> > +                               regulator-max-microvolt = <1400000>;
> > +                               regulator-ramp-delay = <10000>;
> > +                       };
> > +                       mt6311_ldo_reg: VBIASN {
> > +                               regulator-name = "VBIASN";
> > +                               regulator-min-microvolt = <200000>;
> > +                               regulator-max-microvolt = <800000>;
> > +                       };
> > +               };
> > +       };
> > --
> 
> Besides the comment above, it looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Best regards,
> Javier
