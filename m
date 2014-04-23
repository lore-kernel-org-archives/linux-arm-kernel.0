From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 23 Apr 2014 18:19:30 +0900
Subject: [RFC PATCH 2/2] PCI: exynos: Add PCIe support for Samsung GH7 SoC
In-Reply-To: <201404221611.40087.arnd@arndb.de>
References: <000801cf592e$30b7bff0$92273fd0$%han@samsung.com>
 <000a01cf592e$67e592e0$37b0b8a0$%han@samsung.com>
 <201404221611.40087.arnd@arndb.de>
Message-ID: <031b01cf5ed5$21d536a0$657fa3e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Wednesday 16 April 2014, Jingoo Han wrote:
> > Samsung GH7 has four PCIe controllers which can be used as root
> > complex for PCIe interface.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/pci/host/Kconfig      |    2 +-
> >  drivers/pci/host/pci-exynos.c |  135
> ++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 126 insertions(+), 11 deletions(-)
> 
+ Byungho An, Ilho Lee

Hi Arnd,

> Can you explain how much the GH7 and Exynos front-ends actually have in
> common? Would it make sense to have a separate driver for gh7?
> 
Basically, ARMv8 based GH7 has same PCIe hardware IP with previous ARMv7
based exynos5440, several features in PCIe are different though. In other
words, basic functionalities for PCIe are same. So I think, would be nice if
we could use one PCIe device driver for both SoCs.

However, if we need to support the PCIe with each own device driver because
of difference of 32bit and 64bit, please kindly let us know. Honestly, I'm
not sure about that right now.

> Also, if gh7 is expected to run a full firmware, I think you should
> do all the setup in the firmware before booting Linux, and just
> do the required run-time operations in the driver itself.
> 
Well, we're expecting that all the setup should be done by the device driver
in kernel not firmware.

Thanks,
Kukjin
