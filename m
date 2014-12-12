From: rjui@broadcom.com (Ray Jui)
Date: Fri, 12 Dec 2014 08:56:19 -0800
Subject: [PATCH v2 3/4] ARM: mach-bcm: Enable PCIe support for iProc
In-Reply-To: <3173848.p74DGitYxH@wuerfel>
References: <1418351817-14898-4-git-send-email-rjui@broadcom.com>
 <3173848.p74DGitYxH@wuerfel>
Message-ID: <548B1E33.4090806@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/12/2014 4:15 AM, Arnd Bergmann wrote:
> On Thursday 11 December 2014 18:36:56 Ray Jui wrote:
>> Enable PCIe driver support for Broadcom iProc family of SoCs by
>> selecting PCIE_IPROC
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>   arch/arm/mach-bcm/Kconfig |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index aaeec78..a13a0b2 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -19,6 +19,7 @@ config ARCH_BCM_IPROC
>>   	select ARCH_REQUIRE_GPIOLIB
>>   	select ARM_AMBA
>>   	select PINCTRL
>> +	select PCIE_IPROC
>>   	help
>>   	  This enables support for systems based on Broadcom IPROC architected SoCs.
>>   	  The IPROC complex contains one or more ARM CPUs along with common
>>
>
> No, just enable it in multi_v7_defconfig and bcm_defconfig.
>
> 	Arnd
>
Or can I simply have the PCIE_IPROC default to y in 
drivers/pci/host/Kconfig? Note PCIE_IPROC depends on ARCH_BCM_IPROC. By 
defaulting it to y, it will be automatically enabled for all iProc 
family of SoCs.
