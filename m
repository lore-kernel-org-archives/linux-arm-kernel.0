From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 22 Jul 2011 13:52:41 +0530
Subject: [PATCH 0/4] Fix CPU hotplug IRQ migration
In-Reply-To: <20110722081244.GA21416@n2100.arm.linux.org.uk>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
	<4E290C05.7020209@ti.com>
	<20110722081244.GA21416@n2100.arm.linux.org.uk>
Message-ID: <4E293351.6010903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/22/2011 1:42 PM, Russell King - ARM Linux wrote:
> On Fri, Jul 22, 2011 at 11:05:01AM +0530, Santosh Shilimkar wrote:

[...]

> Secure code is called on CPU1 too, so I don't think your statement is
> accurate.  Eg:
>
> 	omap_modify_auxcoreboot0(0x0, 0x200)
>
> 	omap_read_auxcoreboot0()
>
> both result in calling secure code on CPU1.
These are monitor mode secure API's and they can be executed
on any CPU.

I am talking about the services like secure encryption/decryption,
secure copy, saving secure RAM etc.

These services can't be executed on CPU1 and hence the concern.
There is entire secure middle-ware which runs in parallel with Linux
and all it's services are bound to CPU0 only.

Regards
Santosh
