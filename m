From: rjui@broadcom.com (Ray Jui)
Date: Wed, 29 Jul 2015 09:17:02 -0700
Subject: [PATCH] PCI: iproc: Fix BCMA dependency in Kconfig
In-Reply-To: <33449873.RA3z6vhrMA@wuerfel>
References: <1438109533-28694-1-git-send-email-rjui@broadcom.com>
 <33449873.RA3z6vhrMA@wuerfel>
Message-ID: <55B8FC7E.50900@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/29/2015 7:30 AM, Arnd Bergmann wrote:
> On Tuesday 28 July 2015 11:52:13 Ray Jui wrote:
>>  config PCIE_IPROC_BCMA
>>         bool "Broadcom iProc PCIe BCMA bus driver"
>> -       depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
>> +       depends on ARCH_BCM_IPROC && ARM
>>         select PCIE_IPROC
>>         select BCMA
>>         select PCI_DOMAINS
>>
> 
> How about this:
> 
> 	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
> 
> That would leave the compile test present for non-iproc
> ARM platforms while preventing ARM64 and MIPS builds with
> ARCH_BCM_IPROC set.
> 
> 	Arnd
> 

That is indeed better. Broader compile test coverage is always good.
I'll submit another patch with the above suggested change.

Thanks,

Ray
