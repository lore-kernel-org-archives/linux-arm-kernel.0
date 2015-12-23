From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Wed, 23 Dec 2015 13:40:09 +0200
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <BLUPR12MB0451852E89B0848DA16067609DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com>
 <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com>
 <20151215145953.GK1762@lahna.fi.intel.com>
 <1450863241.7740.30.camel@kxue-X58A-UD3R>
 <20151223095237.GJ1758@lahna.fi.intel.com>
 <BLUPR12MB0451770284D7788418640F699DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
 <20151223100959.GK1758@lahna.fi.intel.com>
 <BLUPR12MB0451852E89B0848DA16067609DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
Message-ID: <20151223114009.GM1758@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 11:24:44AM +0000, Zheng, Ivan wrote:
> I'm a BIOS engineer and my point is that such non-ACPI defined methods
> rely on BIOS implementation, so how the generic I2C driver works on a
> platform without such methods? Should the vendor implement their own
> driver in such case?

Those methods are by *no* means meant for generic driver. They are
specific to DesignWare I2C driver.

If you need to specify bus speed that the device is supposed to use,
you put it to the I2cSerialBus() resource (ConnectionSpeed)...

> I think Windows driver use ConnectionSpeed field in I2CSerialBus
> declaration for a certain device and it's defined in ACPI 5.0.

..like you say here.

We just need to add support for ConnectionSpeed to Linux I2C core.
