From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Thu, 14 Mar 2013 13:51:12 +0000
Subject: [PATCH v5 1/4] ARM: davinci: mmc: derive version information
 from device name
In-Reply-To: <5141AF99.5090608@ti.com>
References: <1363097637-11371-1-git-send-email-prakash.pm@ti.com>
 <1363097637-11371-2-git-send-email-prakash.pm@ti.com>
 <5141AF99.5090608@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA48F34@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 16:38:09, Nori, Sekhar wrote:
> Prakash,
> 
> The series looks good to me. I tested it again on DA850 EVM (with and
> without DT).
> 
> On 3/12/2013 7:43 PM, Manjunathappa, Prakash wrote:
> > Remove specifying mmc controller IP version information via platform
> > data, instead specify device name so that driver derives it from
> > platform_device_id table. Also change the clock node name to match
> > the changed dev_id.
> > Tested on da850-evm to make sure driver loads without clk_get failures.
> > 
> > Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> > Reviewed-by: Sekhar Nori <nsekhar@ti.com>
> > ---
> 
> > diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> > index 27123f8..50e9782 100644
> > --- a/drivers/mmc/host/davinci_mmc.c
> > +++ b/drivers/mmc/host/davinci_mmc.c
> > @@ -1157,6 +1157,18 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
> >  	mmc_davinci_reset_ctrl(host, 0);
> >  }
> >  
> > +static struct platform_device_id davinci_mmc_devtype[] = {
> > +	{
> > +		.name	= "davinci-mmc-dm355",
> > +		.driver_data = MMC_CTLR_VERSION_1,
> > +	}, {
> > +		.name	= "davinci-mmc-da830",
> > +		.driver_data = MMC_CTLR_VERSION_2,
> > +	},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(platform, davinci_mmc_devtype);
> 
> I should have mentioned this previously, but your choice of name here is
> too long. You can simply use dm355-mmc (rather dm6441-mmc?) and
> da830-mmc instead like you did for SPI. This would have saved some long
> lines. Sorry about not asking for this earlier. I know it would have
> saved you a bunch of effort.
> 

No problem, will change the name.

Thanks,
Prakash 
