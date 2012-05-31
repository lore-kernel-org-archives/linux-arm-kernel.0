From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 May 2012 09:22:18 +0000
Subject: [RFC PATCH 0/5] omap: add ocp2scp as a misc driver
In-Reply-To: <CAAe_U6LFFstds=iQ7cy7gM9vWbfRgf5z0gaRp_-bu0Qjx6eA1Q@mail.gmail.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com>
 <201205301843.51568.arnd@arndb.de>
 <CAAe_U6LFFstds=iQ7cy7gM9vWbfRgf5z0gaRp_-bu0Qjx6eA1Q@mail.gmail.com>
Message-ID: <201205310922.18550.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 May 2012, ABRAHAM, KISHON VIJAY wrote:
> >
> > Just put the devices you actually want into the device tree instead and
> > have them automatically created.
> 
> But shouldn't device tree support and non-device tree support co-exist
> till the non-device tree is completely knocked out of the kernel? Even

Well, it's a new driver, so there is no regression in supporting it only
on DT-enabled boards. OMAP5 is DT-only anyway and OMAP4 only supports two
boards that should both be working with the generic DT code already.

> then shouldn't there be a separate driver to extract the child nodes
> of ocp2scp and create a device (using of_platform_populate)?
> As far as I've seen, the devices are automatically created (by virtue
> of of_platform_populate() in  mach-omap2/board-generic.c in omap case)
> only for the devices that is connected to the system bus. For other
> cases, the parent should be responsible for creating the child
> devices.

I would mark the multiplexed device compatible with "simple-bus", which
results in the child devices automatically getting added.

	Arnd
