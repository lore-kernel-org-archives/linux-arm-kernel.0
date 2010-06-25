From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Jun 2010 10:08:39 +0100
Subject: clock updates
In-Reply-To: <AANLkTikIOfUS-hOs8ea3cqBntYJEFTD4pEFgte8qbMTH@mail.gmail.com>
References: <20100623232422.GB16584@trinity.fluff.org>
	<AANLkTikIOfUS-hOs8ea3cqBntYJEFTD4pEFgte8qbMTH@mail.gmail.com>
Message-ID: <20100625090839.GA22090@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 25, 2010 at 05:38:20PM +0900, MyungJoo Ham wrote:
> However, what about devices and clocks with the same name and
> different id numbers (i.e., platform_device.id)? Are you going to add
> .id lookup to clkdev's clk_find? There are multiple clocks with the
> same name and different id number.

Platform devices are assigned names which are <basename>.<id> where id != -1.
The basename is matched by the driver.  The <basename>.<id> is what you
see in sysfs, and is the name of the underlying struct device.
