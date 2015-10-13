From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 13 Oct 2015 06:58:42 +0000
Subject: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
In-Reply-To: <561CA5AF.2080300@hisilicon.com>
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com>
 <1444445957-239522-5-git-send-email-wangzhou1@hisilicon.com>
 <20151012213545.GA17479@localhost> <561CA5AF.2080300@hisilicon.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E162428B1@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> +
> >> +static int __init hisi_pcie_init(void)
> >> +{
> >> +	return platform_driver_probe(&hisi_pcie_driver, hisi_pcie_probe);
> >> +}
> >> +subsys_initcall(hisi_pcie_init);
> >
> > Can you use module_platform_driver() or module_platform_driver_probe()
> > here instead of the subsys_initcall()?  No, I don't really know what
> > the difference between module_platform_driver() and
> > module_platform_driver_probe() is, sorry :)
> 
> In fact, I used module_platform_driver_probe in previous version, but
> A PCIe VGA card of HiSilicon will use Hip05 PCIe host, so we modified
> module_platform_driver_probe to subsys_initcall which will be called
> before module_platform_driver_probe.
> 
> We will upstream the driver of above PCIe VGA card soon.
> 
> Many thanks for your reviewing,
> Zhou

Hi Bjorn, firstly many thanks for looking at this.

About this last bit the reason why we use subsys_initcall() is that
our host bridge is embedded in the SoC and as such is not hot-pluggable
for instance see:
http://lxr.free-electrons.com/source/Documentation/driver-model/platform.txt#L59

Our approach is also used by Exynos:
http://lxr.free-electrons.com/source/drivers/pci/host/pci-exynos.c#L644

Cheers

Gab

> 
> >
> > Bjorn
> >
> > .
> >
> 
