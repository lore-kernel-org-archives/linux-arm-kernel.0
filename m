From: peter.fordham@gmail.com (Peter Fordham)
Date: Wed, 15 Jun 2011 12:36:01 -0700
Subject: [MPCore Watchdog]: Convert from misc_dev to dynamic device node.
In-Reply-To: <20110615190945.GA2518@pulham.picochip.com>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
	<20110614234858.GA15534@gallagher>
	<BANLkTik02nt4ttTTS-3u5R_ZH0W90FADJQ@mail.gmail.com>
	<20110615085820.GH3075@pulham.picochip.com>
	<BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com>
	<20110615190945.GA2518@pulham.picochip.com>
Message-ID: <BANLkTin2vBCpiEMcLFTEJ1koUmdTQd11eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The framework looks great. I hope it gets in soon.

> If you use a bus then the device creation is slightly more involved than
> with a class - create the bus, allocate the device and assign the
> bus_type then set the name with dev_set_name(). ?That should be enough
> for udev to work out the name of the device.

It's a platform device so it's already on the platform bus under:

/sys/devices/platform/mpcore_wdt

Do I need to create another bus? The platform driver name is used in driver
matching so it doesn't seem like the right thing to do to change it to watchdog.

-Pete
