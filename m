From: robherring2@gmail.com (Rob Herring)
Date: Sun, 22 May 2011 10:46:03 -0500
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <20110521234725.GB17672@n2100.arm.linux.org.uk>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>	<20110519233958.GB18181@ponder.secretlab.ca>	<4DD66B8A.5040404@gmail.com>
	<201105201621.03801.arnd@arndb.de>	<4DD68614.6090209@gmail.com>	<a42f0c27-2811-4b68-bedf-7dfaa7bff6ff@VA3EHSMHS025.ehs.local>	<BANLkTi=8vX1Cs_fzpQXZBuuDuLYLu1FGmg@mail.gmail.com>
	<20110521234725.GB17672@n2100.arm.linux.org.uk>
Message-ID: <4DD92FBB.2050601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2011 06:47 PM, Russell King - ARM Linux wrote:
> On Sat, May 21, 2011 at 11:42:34AM -0600, Grant Likely wrote:
>> Russell, it seems to me that the primary behaviour that amba_bus has
>> over platform_bus is the clock management, and secondarily
>> verification of the type of device by the device id.  Am I correct, or
>> am I missing something?
>
> It matches by vendor/device ID just like PCI does, and does the bus
> clock management and power management in a really nice way, which I
> doubt platform devices will ever do.
>

Matching by ID is just one aspect of PCI. AMBA devices require defining 
the base address and irq just like platform devices. Having the ID is 
optional on AMBA buses. In PCI the bus and devices are probe-able. For 
AMBA, the bus is not probe-able, only the devices (or maybe not).

I believe OMAP is doing clock and power mgt at the bus level for 
platform devices.

Rob
