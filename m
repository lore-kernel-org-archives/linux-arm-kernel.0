From: kbeldan@baylibre.com (Karl Beldan)
Date: Tue, 23 Aug 2016 09:52:37 +0000
Subject: [PATCH v2] ARM: davinci: da8xx-dt: Add ti-aemif lookup for clock
 matching
In-Reply-To: <2ef9651f-9a1e-3fb6-cc81-b1b714c9e043@ti.com>
References: <20160819164736.10199-1-kbeldan@baylibre.com>
 <20160819164736.10199-2-kbeldan@baylibre.com>
 <2ef9651f-9a1e-3fb6-cc81-b1b714c9e043@ti.com>
Message-ID: <20160823095237.GA8276@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 02:43:36PM +0530, Sekhar Nori wrote:
> On Friday 19 August 2016 10:17 PM, Karl Beldan wrote:
> > The davinci boards don't have their clocks in DT yet and getting a clock
> > with a null con_id will fail, unless registering them as clk_lookups.
> 
> This statement is true, but I am not sure why you limit it to those
> clocks with null con_id. On DaVinci, all clocks need to be registered
> via a clk_lookup entry. Else clk_get() will fail.
> 
> So can I just edit this to:
> 
> "
> The davinci boards don't have their clocks in DT yet and getting a clock
> will fail, unless registering them as clk_lookups.
> "
> 
> while applying?
> 

Sure, as well as a 'reworded commit message' tag.

Thanks, 
Karl

> > This registers the aemif clock for the ti-aemif memory driver.
> > 
> > The current aemif lookup entry resolving to the same clock:
> >     'CLK(NULL,               "aemif",        &aemif_clk)'
> > is currently used by davinci_nand and remains for non-DT and backward
> > compatibility.
> > 
> > Currently the davinci boards only configure the AEMIF in case of non-DT
> > boot, via some code in mach-davinci.
> > This change will allow DT-based davinci platforms to do the same, via
> > the ti-aemif memory driver code.
> > 
> > Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> > ---
> >  This patch was originally patch 1/4 of the series
> >  "Add DT support for NAND to LCDK via ti-aemif" from which two other
> >  patches have already applied in Sekhar's tree.
> >  Sekhar, please note that commit 31e3a881 ("ARM: dts: da850,da850-evm:
> >  Add an aemif node and use it for the NAND") of your tree depends on
> >  this change.
> 
> yes, noted. While sending the pull request to ARM-SoC, I send the SoC
> changes first.
> 
> Thanks,
> Sekhar
