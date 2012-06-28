From: durgadoss.r@intel.com (R, Durgadoss)
Date: Thu, 28 Jun 2012 05:16:43 +0000
Subject: [linux-pm] [PATCH v3 6/7] omap4: thermal: add basic CPU thermal
 zone
In-Reply-To: <20120628051207.GF2471@besouro>
References: <4FEB4B57.6030109@dev.rtsoft.ru> <20120628051207.GF2471@besouro>
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59149DB0@BGSMSX101.gar.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > +
> > +	data = devm_kzalloc(bg_ptr->dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data) {
> > +		dev_err(bg_ptr->dev, "kzalloc fail\n");
> > +		return -ENOMEM;
> > +	}
> > +	data->sensor_id = id;
> > +	data->bg_ptr = bg_ptr;
> > +	data->omap4_thermal = thermal_zone_device_register(domain, 0,
> > +				data, &omap4_thermal_ops, 0, 0, 0, 0);

Please watch out for changes on this API.
The third argument is the flag for writeable trip points.
This patch is in linux-next. So, kindly have a look at this API
implementation in thermal_sys.c in linux-next, when you submit this patch
next time.

Thanks,
Durga
