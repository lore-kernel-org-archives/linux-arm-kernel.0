From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 Jan 2015 09:14:59 +0100
Subject: [PATCH 1/8] soc: Add MediaTek infracfg controller support
In-Reply-To: <20150120161403.GG15924@leverpostej>
References: <1421747231-554-1-git-send-email-s.hauer@pengutronix.de>
 <1421747231-554-2-git-send-email-s.hauer@pengutronix.de>
 <20150120161403.GG15924@leverpostej>
Message-ID: <20150121081459.GB12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 04:14:03PM +0000, Mark Rutland wrote:
> On Tue, Jan 20, 2015 at 09:47:04AM +0000, Sascha Hauer wrote:
> > This adds support for the MediaTek infracfg controller found
> > on the MT8135/MT8173 SoCs. The infracfg controller contains
> > miscellaneous registers for controlling peripheral resets and
> > clocks.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  .../devicetree/bindings/soc/mediatek/infracfg.txt  |  19 +++
> >  drivers/soc/Kconfig                                |   1 +
> >  drivers/soc/Makefile                               |   1 +
> >  drivers/soc/mediatek/Kconfig                       |  12 ++
> >  drivers/soc/mediatek/Makefile                      |   1 +
> >  drivers/soc/mediatek/mtk-infracfg.c                | 127 ++++++++++++++++++++
> >  drivers/soc/mediatek/mtk-pericfg.c                 | 128 +++++++++++++++++++++
> >  7 files changed, 289 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/infracfg.txt
> >  create mode 100644 drivers/soc/mediatek/Kconfig
> >  create mode 100644 drivers/soc/mediatek/Makefile
> >  create mode 100644 drivers/soc/mediatek/mtk-infracfg.c
> >  create mode 100644 drivers/soc/mediatek/mtk-pericfg.c
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/infracfg.txt b/Documentation/devicetree/bindings/soc/mediatek/infracfg.txt
> > new file mode 100644
> > index 0000000..042083a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/infracfg.txt
> > @@ -0,0 +1,19 @@
> > +MediaTek infracfg Controller
> > +
> > +The infracfg controller contains miscellaneous registers for controlling
> > +clocks, resets and bus settings.
> > +
> > +Required properties:
> > +- compatible: must be one of:
> > +       mediatek,mt8135-infracfg
> > +       mediatek,mt8173-infracfg
> > +- reg: Address range for the infracfg controller
> > +
> > +Example:
> > +
> > +       infracfg: infracfg at 10003000 {
> > +               #reset-cells = <1>;
> > +               #clock-cells = <1>;
> 
> These weren't listed as required or optional above.
> 
> Please document these, along with the values a given clock-specifier or
> reset-specifier may take.

I documented #reset-cells and dropped #clock-cells for now.
Documentation for #clock-cells can be added along with the clock support
later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
