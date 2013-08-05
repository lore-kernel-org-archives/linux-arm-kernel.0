From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Mon, 5 Aug 2013 15:51:14 +0000
Subject: =?big5?B?tarOYDogW1BBVENIIHYzIDIvMl0gaTJjOiBpbXg6IEFkZCBWeWJyaWQgVkY2MTAg?=
 =?big5?Q?I2C_controller_support?=
In-Reply-To: <20130805095322.GP26614@pengutronix.de>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
 <20130805083050.GN26614@pengutronix.de>
 <B56CDBE15CE27145A4B77D2D24263E851FC075@039-SN1MPN1-004.039d.mgd.msft.net>,
 <20130805095322.GP26614@pengutronix.de>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851FD14C@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > + [VF610_I2C] = {
> > > +         .devtype = VF610_I2C,
> > > +         .hwdata = &vf610_i2c_hwdata
> > > + },
> > >  };
> >
> > Why add this array?
> > You should reference imx_i2c_hwdata/vf610_i2c_hwdata directly here.
[Lu Jingchang-B35083]
The imx_i2c_devtype[] array is used to support platform that doesn't support dts currently. So the array is added to make the driver consistent. Thanks.

> >
> > >
> > >   if (of_id)
> > >           pdev->id_entry = of_id->data;
> >
> > This is wrong in the original driver code. This field should be changed
> > in a driver.
 [Lu Jingchang-B35083]
The assignment to id_entry is due to support both dts device and non-dts devices, just as you said, maybe this field shouldn't be changed out of platform driver core,
so I will try to change this but make the drive for both dts and non-dts still work well. Thanks.



Best Regards,
Jingchang
