From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 24 Nov 2015 17:48:28 +0530
Subject: PCIe regression with DRA7xx in 4.4-rc1
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E162C92FB@lhreml503-mbs>
References: <56545183.8000507@ti.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E162C92FB@lhreml503-mbs>
Message-ID: <56545594.9070100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 24 November 2015 05:38 PM, Gabriele Paoloni wrote:
> Hi Kishon
> 
>> -----Original Message-----
>> From: Kishon Vijay Abraham I [mailto:kishon at ti.com]
>> Sent: 24 November 2015 12:01
>> To: linux-pci at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
>> omap at vger.kernel.org; james.morse at arm.com; gabriel.fernandez at st.com;
>> Minghuan.Lian at freescale.com; Wangzhou (B); Gabriele Paoloni; arnd at arndb.de;
>> bhelgaas at google.com; pratyush.anand at gmail.com; Nori, Sekhar;
>> jingoohan1 at gmail.com; linux-arm-kernel at lists.infradead.org
>> Subject: PCIe regression with DRA7xx in 4.4-rc1
>>
>> Hi,
>>
>> I'm seeing a regression with <d1b9cf31252e905ad563b9e863fd4470f6c3dd1c>("PCI:
>> designware: Make driver arch-agnostic").
>>
>> Logs using a SATA PCIe card [1]. The PCIe card enumerates fine but after that
>> I
>> observe "ata3.00: qc timeout (cmd 0xec), ata3.00: failed to IDENTIFY (I/O
>> error, err_mask=0x4)"
>>
> 
> May this be related to the bug flagged in:
> 
> [PATCH] PCI: designware: remove wrong io_base assignment
> 
> [...]
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 540f077c37ea..02a7452bdf23 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -440,7 +440,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  					 ret, pp->io);
>  				continue;
>  			}
> -			pp->io_base = pp->io->start;
>  			break;
>  		case IORESOURCE_MEM:
>  			pp->mem = win->res;
> 


yes, this indeed solved the bug.

Thanks
Kishon
