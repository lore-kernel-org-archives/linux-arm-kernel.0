From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 22:34:58 +0900
Subject: [PATCH 12/12] ARM: restart: S3C24XX: use new restart hook
In-Reply-To: <201112201418.07935.heiko@sntech.de>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <1324385316-6052-13-git-send-email-kgene.kim@samsung.com>
 <201112201418.07935.heiko@sntech.de>
Message-ID: <4EF08F02.9010604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/11 22:18, Heiko St?bner wrote:
> Am Dienstag, 20. Dezember 2011, 13:48:36 schrieb Kukjin Kim:
>> Hook these platforms restart code into the new restart hook rather
>> than using arch_reset().
>> And adds local header file, common.h in arch/arm/mach-s3c2410/ and
>> arch/arm/mach-s3c2440/ directories.
>>
>> Cc: Ben Dooks<ben-linux@fluff.org>
>> Cc: Russell King<rmk+kernel@arm.linux.org.uk>
>> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> just for my understanding would it not also be possible to move the function
> prototype to plat-samsung/include/plat/s3c2410.h and s3c244x.h?
>
Hi Heiko,

Yeah, we have many choices about that and I will sort out the 
mach-s3c24.. directories to mach-s3c24xx or just mach-s3c...

> Or should these files vanish in the long run?
>
Yes, as per Russell's suggestion, I think we don't need that and as a 
note, I'm working on removing plat-s3c24xx and plat-s5p, just keeping 
one plat-samsung.

>
> Also, if you have a minute could you take a look at the
> [PATCH 1/8] s3c-hsudc: move platform_data struct to global header
> from yesterday, as Felipe Balbi would like an Ack on it.
>
Sure, let me look at that tomorrow with others.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

>
>> ---
>>   arch/arm/mach-s3c2410/common.h                    |   17 +++++++++++++
>>   arch/arm/mach-s3c2410/include/mach/system-reset.h |   27
>> --------------------- arch/arm/mach-s3c2410/include/mach/system.h       |
>>    2 -
>>   arch/arm/mach-s3c2410/mach-amlm5900.c             |    3 ++
>>   arch/arm/mach-s3c2410/mach-bast.c                 |    2 +
>>   arch/arm/mach-s3c2410/mach-h1940.c                |    3 ++
>>   arch/arm/mach-s3c2410/mach-n30.c                  |    4 +++
>>   arch/arm/mach-s3c2410/mach-otom.c                 |    3 ++
>>   arch/arm/mach-s3c2410/mach-qt2410.c               |    5 ++-
>>   arch/arm/mach-s3c2410/mach-smdk2410.c             |    5 ++-
>>   arch/arm/mach-s3c2410/mach-tct_hammer.c           |    3 ++
>>   arch/arm/mach-s3c2410/mach-vr1000.c               |    2 +
>>   arch/arm/mach-s3c2410/s3c2410.c                   |    9 +++++++
>>   arch/arm/mach-s3c2440/common.h                    |   17 +++++++++++++
>>   arch/arm/mach-s3c2440/mach-anubis.c               |    3 ++
>>   arch/arm/mach-s3c2440/mach-at2440evb.c            |    3 ++
>>   arch/arm/mach-s3c2440/mach-gta02.c                |    2 +
>>   arch/arm/mach-s3c2440/mach-mini2440.c             |    3 ++
>>   arch/arm/mach-s3c2440/mach-nexcoder.c             |    3 ++
>>   arch/arm/mach-s3c2440/mach-osiris.c               |    3 ++
>>   arch/arm/mach-s3c2440/mach-rx1950.c               |    3 ++
>>   arch/arm/mach-s3c2440/mach-rx3715.c               |    3 ++
>>   arch/arm/mach-s3c2440/mach-smdk2440.c             |    3 ++
>>   arch/arm/mach-s3c2440/s3c2440.c                   |    9 +++++++
>>   arch/arm/plat-s3c24xx/cpu.c                       |    2 -
>>   25 files changed, 104 insertions(+), 35 deletions(-)
>>   create mode 100644 arch/arm/mach-s3c2410/common.h
>>   delete mode 100644 arch/arm/mach-s3c2410/include/mach/system-reset.h
>>   create mode 100644 arch/arm/mach-s3c2440/common.h
