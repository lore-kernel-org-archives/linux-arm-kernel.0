From: avinashphilip@ti.com (Philip, Avinash)
Date: Tue, 11 Dec 2012 12:55:21 +0000
Subject: [PATCH v3 2/3] mtd: devices: elm: Add support for ELM error
 correction
In-Reply-To: <20121211090356.8D3D93E076D@localhost>
References: <1354189595-12784-1-git-send-email-avinashphilip@ti.com>
 <1354189595-12784-3-git-send-email-avinashphilip@ti.com>
 <20121211090356.8D3D93E076D@localhost>
Message-ID: <518397C60809E147AF5323E0420B992E3EA285C0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 14:33:56, Grant Likely wrote:
> On Thu, 29 Nov 2012 17:16:33 +0530, "Philip, Avinash" <avinashphilip@ti.com> wrote:
> > The ELM hardware module can be used to speedup BCH 4/8/16 ECC scheme
> > error correction.
> > For now only 4 & 8 bit support is added
> > 
> > Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Rob Landley <rob@landley.net>
> > ---
> > Changes since v2:
> > 	- Remove __devinit & __devexit annotations
> > 
> > Changes since v1:
> > 	- Change build attribute to CONFIG_MTD_NAND_OMAP_BCH
> > 	- Reduced indentation using by passing elm_info , offset
> > 	  to elm_read & elm_write
> > 	- Removed syndrome manipulation functions.
> > 
> > :000000 100644 0000000... b88ee83... A	Documentation/devicetree/bindings/mtd/elm.txt
> > :100644 100644 395733a... 369a194... M	drivers/mtd/devices/Makefile
> > :000000 100644 0000000... d2667f3... A	drivers/mtd/devices/elm.c
> > :000000 100644 0000000... d4fce31... A	include/linux/platform_data/elm.h
> >  Documentation/devicetree/bindings/mtd/elm.txt |   17 +
> >  drivers/mtd/devices/Makefile                  |    4 +-
> >  drivers/mtd/devices/elm.c                     |  418 +++++++++++++++++++++++++
> >  include/linux/platform_data/elm.h             |   54 ++++
> >  4 files changed, 493 insertions(+), 1 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/elm.txt b/Documentation/devicetree/bindings/mtd/elm.txt
> > new file mode 100644
> > index 0000000..b88ee83
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/elm.txt
> > @@ -0,0 +1,17 @@
> > +Error location module
> > +
> > +Required properties:
> > +- compatible: Must be "ti,elm"
> 
> Compatible string is too generic. Need to specify a specific SoC here.
> ie: "ti,omap3430-elm"

I will change to "ti,am33xx-elm" in next version.

Thanks
Avinash


> 
> Otherwise the binding looks fine. I haven't reviewed the code though.
> 
> g.
> 
> 
