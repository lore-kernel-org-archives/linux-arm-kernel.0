From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Thu, 28 Jun 2012 08:24:00 +0300
Subject: [linux-pm] [PATCH v3 6/7] omap4: thermal: add basic CPU thermal
 zone
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59149DB0@BGSMSX101.gar.corp.intel.com>
References: <4FEB4B57.6030109@dev.rtsoft.ru> <20120628051207.GF2471@besouro>
 <4D68720C2E767A4AA6A8796D42C8EB59149DB0@BGSMSX101.gar.corp.intel.com>
Message-ID: <20120628052400.GG2471@besouro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Durga,

On Thu, Jun 28, 2012 at 05:16:43AM +0000, R, Durgadoss wrote:
> Hi,
> 
> > > +
> > > +	data = devm_kzalloc(bg_ptr->dev, sizeof(*data), GFP_KERNEL);
> > > +	if (!data) {
> > > +		dev_err(bg_ptr->dev, "kzalloc fail\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +	data->sensor_id = id;
> > > +	data->bg_ptr = bg_ptr;
> > > +	data->omap4_thermal = thermal_zone_device_register(domain, 0,
> > > +				data, &omap4_thermal_ops, 0, 0, 0, 0);
> 
> Please watch out for changes on this API.
> The third argument is the flag for writeable trip points.
> This patch is in linux-next. So, kindly have a look at this API
> implementation in thermal_sys.c in linux-next, when you submit this patch
> next time.

Ok. Thanks for the heads up. I will have a look on linux-next.

> 
> Thanks,
> Durga
