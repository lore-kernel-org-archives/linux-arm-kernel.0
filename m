From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 27 Mar 2018 10:06:30 +0100
Subject: [PATCH v2 0/4] Introduce PMSAv8 memory protection unit
In-Reply-To: <2415fbb7-a171-2917-35bc-4f2ee128f7c3@arm.com>
References: <1518790485-2321-1-git-send-email-vladimir.murzin@arm.com>
 <2415fbb7-a171-2917-35bc-4f2ee128f7c3@arm.com>
Message-ID: <2749c3e2-1046-a23f-b91c-f456f304d5c3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/18 13:36, Vladimir Murzin wrote:
> On 16/02/18 14:14, Vladimir Murzin wrote:
>> Hi,
>>
>> This series adds support for PMSAv8 MPU defined by ARMv8R/M
>> architecture.
>>
>> Changelog:
>>
>>      v1 -> v2
>>      - Included missed patch.
>> 	- Folded "ARM: NOMMU: Make _stext and _end meet PMSAv8 alignment
>> 	  restrictions" into "ARM: NOMMU: Support PMSAv8 MPU" since it
>> 	  allows us to refer PMSAv8_MINALIGN in linker scripts.
>> 	- Improved and tested XIP support
>>
>>     RFC -> v1
>>      - Rebased on v4.16-rc1
>> 	- Added Tested-by for v7M bits from Andras
>>
>> Thanks!
> 
> OK for patch tracker?

The patches were on the list for a month and half without much attention
except v7M folks (thanks them for testing!) and I'm afraid it would be even
harder to make progress with them in nearby feature.

I'm wondering if ARM SoC team can pick the patches?

Thanks
Vladimir

> 
> Vladimir
> 
>>
>> Vladimir Murzin (4):
>>   ARM: NOMMU: Move PMSAv7 MPU under it's own namespace
>>   ARM: NOMMU: Reorganise __setup_mpu
>>   ARM: NOMMU: Postpone MPU activation till __after_proc_init
>>   ARM: NOMMU: Support PMSAv8 MPU
>>
>>  arch/arm/include/asm/mpu.h        | 112 +++++++++-----
>>  arch/arm/include/asm/v7m.h        |  14 +-
>>  arch/arm/kernel/asm-offsets.c     |   8 +-
>>  arch/arm/kernel/head-nommu.S      | 289 ++++++++++++++++++++++++++++-------
>>  arch/arm/kernel/vmlinux-xip.lds.S |   4 +
>>  arch/arm/kernel/vmlinux.lds.S     |   7 +
>>  arch/arm/mm/Makefile              |   2 +-
>>  arch/arm/mm/nommu.c               |  32 ++++
>>  arch/arm/mm/pmsa-v7.c             |  59 +++-----
>>  arch/arm/mm/pmsa-v8.c             | 307 ++++++++++++++++++++++++++++++++++++++
>>  10 files changed, 701 insertions(+), 133 deletions(-)
>>  create mode 100644 arch/arm/mm/pmsa-v8.c
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
