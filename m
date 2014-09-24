From: B31939@freescale.com (Lian Minghuan-B31939)
Date: Wed, 24 Sep 2014 10:17:58 +0800
Subject: [PATCH v3 3/3] PCI: Layerscape: Add Layerscape PCIe driver
In-Reply-To: <1411507511.13320.155.camel@snotra.buserror.net>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
 <1411482540-31297-5-git-send-email-Minghuan.Lian@freescale.com>
 <1411507511.13320.155.camel@snotra.buserror.net>
Message-ID: <542229D6.50405@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

Please see my comments inline.

On 2014?09?24? 05:25, Scott Wood wrote:
> On Tue, 2014-09-23 at 22:29 +0800, Minghuan Lian wrote:
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 34134d6..7c49456 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -82,4 +82,11 @@ config PCIE_XILINX
>>   	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>>   	  Host Bridge driver.
>>   
>> +config PCI_LAYERSCAPE
>> +	bool "Freescale Layerscape PCIe controller"
>> +	select PCIE_DW
>> +	select MFD_SYSCON
>> +	help
>> +	  Say Y here if you want PCIe controller support on Layerscape SoCs.
>> +
>>   endmenu
> Are you sure there are no dependencies for this to build?  At the least
> you need OF.
>
> I think you should also be selecting REGMAP.
[Minghuan] Yes, it does need OF. I will add 'depends on OF' next version.
Because MFS_SYSCON will select REGMAP, so I think it is enough to select 
MFS_SYSCON.

> -Scott
>
>
