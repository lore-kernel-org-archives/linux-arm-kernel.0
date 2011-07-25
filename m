From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 25 Jul 2011 15:13:58 +0800
Subject: [PATCH v6 0/6] mc13783: add pwr button support
In-Reply-To: <201107250849.26071.philippe.retornaz@epfl.ch>
References: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
	<20110724034418.GA28189@S2100-06.ap.freescale.net>
	<201107250849.26071.philippe.retornaz@epfl.ch>
Message-ID: <20110725071357.GD21641@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 08:49:25AM +0200, Philippe R?tornaz wrote:
> Le dimanche 24 juillet 2011 05:44:19, Shawn Guo a ?crit :
> > On Fri, Jul 22, 2011 at 04:17:06PM +0200, Philippe R?tornaz wrote:
> > > Hello
> > > 
> > > This add button handling for the MC13783 PMIC.
> > > 
> > > Patch 1 & 2 modify the mc13xxx MFD driver to use the platform data to
> > > resgister the led subdevice and unconditionally register the regulator
> > > subdevice (as suggested by Mark and Uwe).
> > > 
> > > Patch 3 remove the use of the *_USE_REGULATOR and *_USE_LED macros in
> > > the platform files.
> > > 
> > > Patch 4 must be applied after patch 1,2,3 to remove the obsolete define.
> > > 
> > > Patch 5 modify the mc13xxx MFD driver to add a button subdevice and
> > > also adds the mc13783-pwrbutton driver using a misc input device.
> > > 
> > > The last patch adds the power on button support to the mx31moboard
> > > boards.
> > > 
> > > v2: first patch modified according to comments by Dmitry Torokhov
> > > v3: Implement review by Uwe
> > > v4: Implement comments by Uwe and Mark
> > > v5: Reorder patchset
> > > v6: Minor corrections
> > 
> > It seems you did not address the comment about possible NULL pdata I
> > put on v4?
> 
> Yes I did in patch 5:
> 
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -716,6 +716,11 @@ static int mc13xxx_probe(struct spi_device *spi)
>         enum mc13xxx_id id;
>         int ret;
>  
> +       if (!pdata) {
> +               dev_err(&spi->dev, "invalid platform data\n");
> +               return -EINVAL;
> +       }
> +
> 
Ah, missed that.  I thought it should be fixed with a separate patch
in the first place.  But I'm fine with it, as long as it gets fixed :)

-- 
Regards,
Shawn
