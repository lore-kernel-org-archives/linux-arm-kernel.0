From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 4 Jan 2016 09:09:37 +0000
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <1450863241.7740.30.camel@kxue-X58A-UD3R>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com> <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com> <20151215145953.GK1762@lahna.fi.intel.com>
 <1450863241.7740.30.camel@kxue-X58A-UD3R>
Message-ID: <568A36D1.8070808@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/12/15 09:34, Ken Xue wrote:
> On Tue, 2015-12-15 at 16:59 +0200, Mika Westerberg wrote:
>> On Tue, Dec 15, 2015 at 08:52:19AM -0600, Suravee Suthikulpanit wrote:

> During test, I2C bus should run in different "ConnectionSpeed" of
> device.
> 
> That means windows driver can modify I2C bus speed to match the
> "ConnectionSpeed" of device on-the-fly. Static value from SSCN and FMCN
> can not work for WITT test cases.
> 
> It sounds like odd that multi-speed can be applied over one I2C bus, But
> everything goes well.
> Does this behavior(multi-speed) violate the I2C spec?

I can't remember if the spec says it, but I would say the bus should
run at the speed of the slowest attached peripheral as they all have
to listen for the address-byte being sent at the start of each i2c
transaction.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
