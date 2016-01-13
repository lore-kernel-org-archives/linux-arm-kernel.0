From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 21:39:48 +0100
Subject: [PATCH] ata: add AMD Seattle platform driver
In-Reply-To: <56968168.4010606@amd.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
 <4689728.Nn3Rl2cUeP@wuerfel> <56968168.4010606@amd.com>
Message-ID: <10776629.UCmL1lPAav@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 January 2016 10:55:04 Brijesh Singh wrote:
> On 01/12/2016 08:24 AM, Arnd Bergmann wrote:

> > c) calling into the ACPI interpreter to do platform specific hacks
> 
> Thanks for explaining. Now I understood your comment on AML however we need to consider the following:
> 
> a) activity LED blinking routines are called very frequent (10 to 100ms based on emp->state) and executing AML method that often would introduces its own overhead.
> 
> b) all BIOS vendors need to implement a new methods in their DSDT and release a new BIOS.
> 
> c) other OS'es (mainly Windows) driver need to be updated.
> 
> 
> We don't know how many other SoC's have similar hacky implementation which can take advantage of extending generic
> AHCI driver to call into AML methods for LED blink. Given some of these causes I think having a platform driver is much cleaner. I can drop DT binding part from this driver and keep just ACPI binding.
> 
> Thoughts ?

I don't care what you do with ACPI, just make sure we can use the generic
driver without any platform specific hacks for the DT case.

For ACPI, please talk to the respective maintainers about whether they want
to have a custom driver for this case, or a proper abstraction in the generic
driver.

	Arnd
