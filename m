From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 18 Mar 2015 00:52:42 +0000
Subject: [PATCH v2.0 1/2] pm: at91: add the PM initialization for the
 sama5d3 and sama5d4
In-Reply-To: <20150316102112.GA29170@gradator.net>
References: <1425873378-8253-1-git-send-email-wenyou.yang@atmel.com>
 <1425873428-8292-1-git-send-email-wenyou.yang@atmel.com>
 <20150316102112.GA29170@gradator.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD932FE@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

> -----Original Message-----
> From: Sylvain Rochet [mailto:sylvain.rochet at finsecur.com]
> Sent: 2015?3?16? 18:21
> To: Yang, Wenyou
> Cc: Ferre, Nicolas; linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; alexandre.belloni at free-electrons.com;
> peda at axentia.se; sergei.shtylyov at cogentembedded.com; linux at maxim.org.za
> Subject: Re: [PATCH v2.0 1/2] pm: at91: add the PM initialization for the sama5d3
> and sama5d4
> 
> Hello Wenyou,
> 
> On Mon, Mar 09, 2015 at 11:57:08AM +0800, Wenyou Yang wrote:
> > To get the mpddrc peripheral id from the PM initialization, which will
> > be used to disable mpddrc'c clock during suspending.
> 
> > +void __init sam5d3_pm_init(void)
> > +{
> > +	at91_dt_ramc();
> > +	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP |
> AT91SAM926x_PMC_UDP;
> > +	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
> > +	at91_pm_data.ddrc_pid = SAMA5D3_ID_MPDDRC;
> > +	return at91_pm_init();
> > +}
> > +
> > +void __init sam5d4_pm_init(void)
> > +{
> > +	at91_dt_ramc();
> > +	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP |
> AT91SAM926x_PMC_UDP;
> > +	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
> > +	at91_pm_data.ddrc_pid = SAMA5D4_ID_MPDDRC;
> > +	at91_pm_data.is_sama5d4 = true;
> > +	return at91_pm_init();
> > +}
> 
> > +static void __init sama5d4_dt_device_init(void) {
> > +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +	sam5d4_pm_init();
> > +}
> 
> This doesn't look right, where is sam5d3_pm_init() actually used ?
Oh, I missed it mindlessly during rebasing. I will added it in the next version. 

Sorry for being confused. 

> 
> Sylvain

Best Regards,
Wenyou Yang
