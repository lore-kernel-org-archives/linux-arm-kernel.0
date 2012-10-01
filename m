From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 1 Oct 2012 11:22:28 +0100
Subject: [PATCH 1/4] mfd: ab8500: add devicetree support for fuelgauge
In-Reply-To: <20121001094929.GB6682@gmail.com>
References: <1349064513-31301-1-git-send-email-rajanikanth.hv@stericsson.com>
 <1349064513-31301-2-git-send-email-rajanikanth.hv@stericsson.com>
 <20121001094929.GB6682@gmail.com>
Message-ID: <20121001102228.GD6682@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, some mistakes:

> > From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>
> > 
> > - This patch adds device tree support for fuelguage driver
> > - optimize bm devices platform_data usage and of_probe(...)
> >   Note: of_probe() routine for battery managed devices is made
> >   common across all bm drivers.

Spelling errors in here.

> > +		dev_err(dev, "invalid battery-info node\n");
> > +		return -EINVAL;
> > +	}
> > +	if (of_property_read_bool(np_bat_supply,
> > +			"thermistor-on-batctrl") == false){
> 
> Replace with: 
>         if (of_get_property(np_bat_supply, "thermistor-on-batctr", NULL))
> 	        np_bat_supply =  true;

This should be: 

         if (of_get_property(np_bat_supply, "thermistor-on-batctr", NULL))
 	        thermistor = NTC_INTERNAL;
         else
                thermistor = NTC_EXTERNAL;

> <remove>
> 
> > +		dev_warn(dev, "missing property thermistor-on-batctrl\n");
> > +		thermistor = NTC_EXTERNAL;
> > +	}
> 
> </remove>

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
