From: rjui@broadcom.com (Ray Jui)
Date: Tue, 28 Jul 2015 08:48:49 -0700
Subject: [PATCH v5 1/4] PCI: iproc: enable arm64 support for iProc PCIe
In-Reply-To: <CAOesGMh2Dz2HWpAg0Yh71QYfnAyMRae929p=mqGmopGdrVWgxQ@mail.gmail.com>
References: <1438036941-27210-1-git-send-email-rjui@broadcom.com>
 <1438036941-27210-2-git-send-email-rjui@broadcom.com>
 <CAOesGMh2Dz2HWpAg0Yh71QYfnAyMRae929p=mqGmopGdrVWgxQ@mail.gmail.com>
Message-ID: <55B7A461.5040807@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/28/2015 6:24 AM, Olof Johansson wrote:
> Hi Ray,
> 
> I get the following when building an allmodconfig on arm64:
> 
> drivers/pci/host/pcie-iproc-bcma.c: In function 'iproc_pcie_bcma_map_irq':
> drivers/pci/host/pcie-iproc-bcma.c:37:31: error: dereferencing pointer
> to incomplete type
>   struct iproc_pcie *pcie = sys->private_data;
>                                ^
> 
> Should be easy for you to reproduce, please send incremental fix.
> 
> 
> -Olof

This looks like a dependency issue of the iProc PCIe BCMA driver, which
should really be disabled for arm64 as it's only available on legacy
arm32 based Broadcom SoCs.

I'll submit an incremental fix in Kconfig.

Thanks,

Ray
