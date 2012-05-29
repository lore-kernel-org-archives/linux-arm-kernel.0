From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 28 May 2012 20:34:29 -0600
Subject: amba, tegra-ahb and pci (Kconfig question)
In-Reply-To: <20120528081737.GA8031@mail.gnudd.com>
References: <20120528081737.GA8031@mail.gnudd.com>
Message-ID: <4FC435B5.8030007@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2012 02:17 AM, Alessandro Rubini wrote:
> Hello.
> 
> I plan to submit drivers/amba/apb-pci.c (and later ahb-pci.c), because
> the amba-pl011-pci.c I proposed is actually a generic bridge and there
> are several such devices in my chip.
> 
> I planned to use obj-$(CONFIG_PCI) in drivers/amba/Makefile, but 
> commit 87d0bab2cba3c31624b80cc68bcf5e29ef969458 had this in drivers/Makefile:
> 
>   -obj-$(CONFIG_ARM_AMBA)         += amba/
>   +obj-y                          += amba/
> 
> So I ask how to proceed. Shall I define CONFIG_PCI_AMBA or something
> like that, or should drivers/amba/tegra-ahb.c be moved to
> arch/arm/mach-tegra ?  (I prefer the latter and can submit such patch,
> but not without authorization from the involved parties).

FYI, there's a desire to keep all (especially new) drivers out of
arch/arm/mach-*. We had originally wanted to put the tegra-ahb driver in
that directory since it is highly Tegra-specific, but that location was
NAKd.
