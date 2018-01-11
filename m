From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 11 Jan 2018 23:18:45 +0100
Subject: [linux, dev-4.10, 6/6] drivers/hwmon: Add a driver for a generic
 PECI hwmon
In-Reply-To: <20180111214035.GA14748@roeck-us.net>
References: <20180109223126.13093-7-jae.hyun.yoo@linux.intel.com>
 <20180110214747.GA25248@roeck-us.net>
 <261ac28e-813c-a058-c81f-ad4e718d0233@linux.intel.com>
 <20180111214035.GA14748@roeck-us.net>
Message-ID: <20180111221845.GA9278@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > >>+static const struct of_device_id peci_of_table[] = {
> > >>+	{ .compatible = "peci-hwmon", },
> > >
> > >This does not look like a reference to some piece of hardware.
> > >
> > 
> > This driver provides generic PECI hwmon function to which controller has
> > PECI HW such as Aspeed or Nuvoton BMC chip so it's not dependant on a
> > specific hardware. Should I remove this or any suggestion?

PECI seems to be an Intel thing. So at least it should be

 { .compatible = "intel,peci-hwmon", }

assuming it is actually compatible with the Intel specification.

	 Andrew
