From: sza@esh.hu (=?utf-8?B?U3plbXrFkSBBbmRyw6Fz?=)
Date: Thu, 20 Jul 2017 11:29:26 +0200
Subject: [RFC PATCH 0/2] Introduce interface for default DMA pool
In-Reply-To: <1500281885-3034-1-git-send-email-vladimir.murzin@arm.com>
References: <1500281885-3034-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <8C5889D6-099B-4752-AC42-5363FBD235AA@esh.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 2017. Jul 17., at 10:58, Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> 
> Hi,
> 
> This is follow-up for Christoph complain of overloading the current
> dma coherent infrastructure with the global pool. To address that I
> implemented Robin's idea of the new interface to the global pool and
> wire up it with (only existent user) ARM NOMMU.  Since I have not
> heard from Vitaly and/or George of their use of global pool, I'm
> leaving ARM MMU part to them.
> 
> [1] https://lkml.org/lkml/2017/7/7/370
> 


I?ve tested the patches on Atmel SAMV7 SoC, and it works for me
without any issues, so you can add my Tested-by.

Thanks for the patches!


Booting Linux on physical CPU 0x0
Linux version 4.13.0-rc1 (root at devel) (gcc version 4.9.2 ( 4.9.2-10)) #3 Wed Jul 19 04:48:18 EDT 2017
CPU: ARMv7-M [410fc271] revision 1 (ARMv7M), cr=00000000
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
OF: fdt: Machine model: SAME70-sampione board
...
Reserved memory: created DMA memory pool at 0x73e00000, size 2 MiB
OF: reserved mem: initialized node linux,dma, compatible id shared-dma-pool
Using ARMv7 PMSA Compliant MPU. Region independence: No, Used 4 of 16 regions
...
DMA: default coherent area is set
...
