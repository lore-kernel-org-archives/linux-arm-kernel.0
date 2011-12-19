From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Dec 2011 23:37:59 +0900
Subject: [PATCH] ARM: restart: S3C64XX: use new restart hook
In-Reply-To: <20111219135530.GG14542@n2100.arm.linux.org.uk>
References: <03dc01ccbe45$80633d30$8129b790$%kim@samsung.com>
 <20111219135530.GG14542@n2100.arm.linux.org.uk>
Message-ID: <4EEF4C47.6040408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/11 22:55, Russell King - ARM Linux wrote:
> On Mon, Dec 19, 2011 at 08:58:20PM +0900, Kukjin Kim wrote:
>> Hook these platforms restart code into the new restart hook rather
>> than using arch_reset().
>>
>> Cc: Ben Dooks<ben-linux@fluff.org>
>> Cc: Russell King<rmk+kernel@arm.linux.org.uk>
>> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
>
> It would be _much_ better if you could prepare a set of patches against
> my devel-stable which adds this support (as has been done for others.)
>
OK, I will and other Samsung stuff such as s3c24xx, s5p and exynos will 
be implemented together against your devel-stable.

> I can merge it into my restart branch, and update the commit which removes
> arch_reset() itself, and the commit which adds the #error.  We can then
> avoid bisect breakage.
>
OK.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

>> ---
>>   arch/arm/mach-s3c64xx/common.c                     |   10 ++++++++++
>>   arch/arm/mach-s3c64xx/common.h                     |    2 ++
>>   arch/arm/mach-s3c64xx/include/mach/system.h        |   12 ------------
>>   arch/arm/mach-s3c64xx/mach-anw6410.c               |    1 +
>>   arch/arm/mach-s3c64xx/mach-crag6410.c              |    1 +
>>   arch/arm/mach-s3c64xx/mach-hmt.c                   |    1 +
>>   arch/arm/mach-s3c64xx/mach-mini6410.c              |    1 +
>>   arch/arm/mach-s3c64xx/mach-ncp.c                   |    1 +
>>   arch/arm/mach-s3c64xx/mach-real6410.c              |    1 +
>>   arch/arm/mach-s3c64xx/mach-smartq5.c               |    1 +
>>   arch/arm/mach-s3c64xx/mach-smartq7.c               |    1 +
>>   arch/arm/mach-s3c64xx/mach-smdk6400.c              |    1 +
>>   arch/arm/mach-s3c64xx/mach-smdk6410.c              |    1 +
>>   .../arm/plat-samsung/include/plat/watchdog-reset.h |    1 +
>>   14 files changed, 23 insertions(+), 12 deletions(-)
