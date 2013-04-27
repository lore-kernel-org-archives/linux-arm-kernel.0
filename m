From: romieu@fr.zoreil.com (Francois Romieu)
Date: Sat, 27 Apr 2013 10:53:06 +0200
Subject: VIA velocity network driver
In-Reply-To: <517B6267.4070404@prisktech.co.nz>
References: <517B6267.4070404@prisktech.co.nz>
Message-ID: <20130427085306.GA24622@electric-eye.fr.zoreil.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Prisk <linux@prisktech.co.nz> :
> I would like to add support to this driver for platform devices as
> found on VIA's APC8750 board. At the moment, I have a standalone
> platform version that works fine, but wanted to ask a few questions
> before sending a patch to merge this code into one driver.
> 
> The current driver is for PCI network cards, and uses pci dma
> functions. Most of the pci dma functions are wrappers around other
> functions which is what I have used for the platform version.

[...]
> Is it ok to use the non-pci versions (which are basically just the
> unwrapped pci versions) and pass the struct device *, or will I need
> to use the correct function for the correct instance.

It's ok.

A standalone patch to convert the pci dma functions and check the
returned status code of the new one would be welcome regardless of
any future change in the driver data struct.

[...]
> I assume this is loading something from an EEPROM, but there is no
> EEPROM on the APC8750. Removing this code, the driver seems to work
> fine on the APC8750.

I feel a "no documentation" disturbance in the force.

Via's people Cced.

> Could it be avoided with a vptr->has_no_eeprom that defaults to 0 to
> avoid breaking existing support?

Yes. No unnecessary module option please.

-- 
Ueimor
