From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 23 May 2017 08:57:08 +0100
Subject: [RFC PATCH v2 0/7] ARM: NOMMU: MPU updates
In-Reply-To: <907F9677-52F3-4379-BDB2-E703FAAED59A@esh.hu>
References: <1495187206-14303-1-git-send-email-vladimir.murzin@arm.com>
 <907F9677-52F3-4379-BDB2-E703FAAED59A@esh.hu>
Message-ID: <310db372-8058-1c2d-5713-803265170185@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22/05/17 11:05, Szemz? Andr?s wrote:
> Hi,
> 
>> On 2017. May 19., at 11:46, Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>>
>> Hi,
>>
>> This is an update of the existent MPU code which consist set of
>> clean-ups and enhancements. The most significant changes are in the way
>> how MPU settings sync-up for secondaries (PATCH 3/7) and more flexible
>> layout for memory (PATCH 7/7). Since there is no in-tree user of MPU,
>> support for M-class has been added (PATCH 6/7).
>>
>> Thanks!
>>
>> Changelog:
>> 	    RFC -> RFC v2
>> 	       - fixed MPU enable for v7m (PATCH 6/7)
>>
>> Vladimir Murzin (7):
>>  ARM: NOMMU: Move out MPU setup in separate module
>>  ARM: NOMMU: Update MPU accessors to use cp15 helpers
>>  ARM: NOMMU: Rework MPU to be mostly done in C
>>  ARM: NOMMU: Disallow MPU for XIP
>>  ARM: Kconfig: Kill CONFIG_VECTORS_BASE
>>  ARM: V7M: Add support for MPU to M-class
>>  ARM: NOMMU: Use more MPU regions to cover memory
>>
>>
> 
>  I?ve tested these patches on my custom Atmel SAME70 armv7m board, along with the 
> "ARM: Fix dma_alloc_coherent() and friends for NOMMU" patches.
> 
> Both series works fine for me. These MPU patches introduce a nice feature that it simplifies the bootloader:
> do not need to setup the MPU, for example for coherent DMA region, which is described in device-tree too.
> 
> So you can add my Tested-by.
> 

Much appreciated!

> 
> Booting Linux on physical CPU 0x0
> Linux version 4.12.0-rc1 (root at devel) (gcc version 4.9.2 ( 4.9.2-10) ) #1 Fri May 19 06:26:34 EDT 2017
> CPU: ARMv7-M [410fc271] revision 1 (ARMv7M), cr=00000000
> CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> OF: fdt: Machine model: SAME70-sampione board
> bootconsole [earlycon0] enabled
> Reserved memory: created DMA memory pool at 0x73e00000, size 2 MiB
> OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
> Using ARMv7 PMSA Compliant MPU. Region independence: No, Used 4 of 16 regions
> ?
> 
> 
> Thanks for the patches!

I'm glad they work for you!

Cheers
Vladimir

> 
> Regards,
> Andras
> 
> 
