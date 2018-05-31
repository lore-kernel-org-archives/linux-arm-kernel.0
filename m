From: tony@atomide.com (Tony Lindgren)
Date: Thu, 31 May 2018 06:50:00 -0700
Subject: [PATCH v2 4/6] bus: ti-sysc: Add support for using ti-sysc for
 MCAN on dra76x
In-Reply-To: <0b627ab6-59f1-4a4f-42d2-5d6846adfe0b@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-5-faiz_abbas@ti.com>
 <20180530145726.GD5705@atomide.com>
 <0b627ab6-59f1-4a4f-42d2-5d6846adfe0b@ti.com>
Message-ID: <20180531135000.GL5705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Faiz Abbas <faiz_abbas@ti.com> [180531 10:17]:
> Hi,
> 
> On Wednesday 30 May 2018 08:27 PM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [180530 14:12]:
> >> The dra76x MCAN generic interconnect module has a its own
> >> format for the bits in the control registers.
> ...
> >>  static int sysc_init_pdata(struct sysc *ddata)
> >>  {
> >>  	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
> >> @@ -1441,6 +1457,7 @@ static const struct of_device_id sysc_match[] = {
> >>  	{ .compatible = "ti,sysc-mcasp", .data = &sysc_omap4_mcasp, },
> >>  	{ .compatible = "ti,sysc-usb-host-fs",
> >>  	  .data = &sysc_omap4_usb_host_fs, },
> >> +	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
> >>  	{  },
> >>  };
> > 
> > Looks good to me. And presumably you checked that no other dra7 modules
> > use sysconfig register bit layout like this?
> > 
> 
> As far as I could see, Yes.

OK thanks for checking it.

Regards,

Tony
