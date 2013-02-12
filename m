From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 12 Feb 2013 17:01:04 +0200
Subject: [PATCH 0/5 v3] at91: PMECC: enable PMECC in dt for
 at91sam9x5ek, at91sam9n12ek
In-Reply-To: <5113D347.8050409@atmel.com>
References: <1358945232-2282-1-git-send-email-josh.wu@atmel.com>
 <5113D347.8050409@atmel.com>
Message-ID: <1360681264.12703.112.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-02-07 at 17:16 +0100, Nicolas Ferre wrote:
> On 01/23/2013 01:47 PM, Josh Wu :
> > Those patches will enable PMECC in dt parameters for at91sam9x5ek and 
> > at91sam9n12ek.
> > 
> > The PMECC driver will check minimum required ecc on ONFI parameter from NAND 
> > flash.
> > 
> > If pmecc-cap, pmecc-sector-size in dts file is specified, use those two.
> > otherwise, set those according to NAND flash ONFI parameters.
> > 
> > If the pmecc-cap, pmecc-sector-size in dts are different with ecc requirement
> > in ONFI, print out a warning.
> > 
> > 
> > For the following compile error:
> >   ERROR (phandle_references): Reference to non-existent node or label "pinctrl_ssc0_tx"
> > 
> >   ERROR: Input tree has errors, aborting (use -f to force output)
> >   make[2]: *** [arch/arm/boot/dts/at91sam9g20ek.dtb] Error 2
> > 
> > the fixes are already merged in Linux mainline in v3.8-rc4.
> > you can find in: 
> >  544ae6b2e676c3c37fb8c93ef9327932fc2e5bc2 (ARM: at91/dts: add pinctrl support for SSC peripheral)
> >  ea03c81521bde526570e1dec96eaa21fe5ac84a2 (ASoC: atmel-ssc: add pinctrl selection to driver) 
> 
> Artem,
> 
> I propose to take patches 2 and 3/5 of this series via arm-soc git tree.
> I will specify to merge them at the end of the merge-window so that the
> Device Tree properties will not be out-of-sync with driver modifications
> (may not cause big issues anyway).

Hi, just pushed patches 1, 3, and 4 to the l2-mtd.git tree, thanks!
-- 
Best Regards,
Artem Bityutskiy
