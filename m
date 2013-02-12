From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 12 Feb 2013 06:20:24 +0000
Subject: [PATCH v2 1/3] ARM: davinci: da850: override mmc DT node device
 name
In-Reply-To: <5119D72D.3010605@ti.com>
References: <1360223825-23929-1-git-send-email-prakash.pm@ti.com>
 <1360223825-23929-2-git-send-email-prakash.pm@ti.com>
 <5119D72D.3010605@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4685E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 11:16:21, Nori, Sekhar wrote:
> On 2/7/2013 1:27 PM, Manjunathappa, Prakash wrote:
> > Populate OF_DEV_AUXDATA with desired device name expected by
> > davinci_mmc driver. Without this clk_get of davinci_mmc DT driver
> > fails.
> 
> But there is no mmc DT support for DaVinci at this time. This patch
> should come after the driver DT support and .dts addition patches.
> 

Agreed, I will bring it up in the series.

> > diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> > index 37c27af..3362ca4 100644
> > --- a/arch/arm/mach-davinci/da8xx-dt.c
> > +++ b/arch/arm/mach-davinci/da8xx-dt.c
> > @@ -39,9 +39,16 @@ static void __init da8xx_init_irq(void)
> >  
> >  #ifdef CONFIG_ARCH_DAVINCI_DA850
> >  
> > +static const struct of_dev_auxdata da8xx_auxdata[] __initconst = {
> > +	OF_DEV_AUXDATA("ti,davinci-mmc-da830", 0x01c40000, "davinci_mmc.0",
> > +			NULL),
> > +	{},
> > +};
> > +
> >  static void __init da850_init_machine(void)
> >  {
> > -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +	of_platform_populate(NULL, of_default_bus_match_table, da8xx_auxdata,
> > +			NULL);
> 
> This needs to be rebased on by v3.9/dt-2 branch. There are conflicts
> with the code already present.
> 

Yes, I will send it after rebasing on new branch.

Thanks,
Prakash

> Thanks,
> Sekhar
> 
