From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 26 Jan 2011 05:19:55 +0800
Subject: [PATCH 1/2] Updated XCEP partition sizes
In-Reply-To: <AANLkTimMniHC==y6majqBGKNBa91J1DpVK8zbnDxEWvy@mail.gmail.com>
References: <AANLkTi=42n+h+0buU_83R-y4XkXqy8bkWSquwuLAY56m@mail.gmail.com>
	<AANLkTimMniHC==y6majqBGKNBa91J1DpVK8zbnDxEWvy@mail.gmail.com>
Message-ID: <AANLkTinLTuJY9vDH_oHeKk7j6oo4369cF35PG+fVc5A_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 2:54 AM, Matej Kenda <matejken@gmail.com> wrote:
> Hi Eric,
>
> I've sent two simple patches for Iskratel XCEP last week.
>
> Can they be included in the kernel?

I'm a bit tentative on this. Patch 1 is basically OK, but what if
someone needs a even larger partition in the future?  And some work
is on-going with cleanup of those defconfigs, guess I'll hold a
while those changes to the defconfig until that's clear enough.

BTW - did you run Uwe's script to make sure the changes to defconfig
is the smallest one?

>
> TIA,
>
> Matej
>
> On 19 January 2011 13:01, Matej Kenda <matejken@gmail.com> wrote:
>> Increased partition for Linux kernel from 1 MB to 2 MB for
>> monolithically built kernel 2.6.37 for Iskratel XCEP SBC to fit in.
>>
>> Signed-off-by: Matej Kenda <matejken@gmail.com>
>>
>> ---
>>
>> diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
>> index 3260ce7..f7b1052 100644
>> --- a/arch/arm/mach-pxa/xcep.c
>> +++ b/arch/arm/mach-pxa/xcep.c
>> @@ -55,20 +55,20 @@ static struct mtd_partition xcep_partitions[] = {
>> ? ? ? ?}, {
>> ? ? ? ? ? ? ? ?.name = ? ? ? ? "Bootloader ENV",
>> ? ? ? ? ? ? ? ?.size = ? ? ? ? 0x00040000,
>> - ? ? ? ? ? ? ? .offset = ? ? ? 0x00040000,
>> + ? ? ? ? ? ? ? .offset = ? ? ? MTDPART_OFS_APPEND,
>> ? ? ? ? ? ? ? ?.mask_flags = ? MTD_WRITEABLE
>> ? ? ? ?}, {
>> ? ? ? ? ? ? ? ?.name = ? ? ? ? "Kernel",
>> - ? ? ? ? ? ? ? .size = ? ? ? ? 0x00100000,
>> - ? ? ? ? ? ? ? .offset = ? ? ? 0x00080000,
>> + ? ? ? ? ? ? ? .size = ? ? ? ? 0x00200000,
>> + ? ? ? ? ? ? ? .offset = ? ? ? MTDPART_OFS_APPEND,
>> ? ? ? ?}, {
>> ? ? ? ? ? ? ? ?.name = ? ? ? ? "Rescue fs",
>> ? ? ? ? ? ? ? ?.size = ? ? ? ? 0x00280000,
>> - ? ? ? ? ? ? ? .offset = ? ? ? 0x00180000,
>> + ? ? ? ? ? ? ? .offset = ? ? ? MTDPART_OFS_APPEND,
>> ? ? ? ?}, {
>> ? ? ? ? ? ? ? ?.name = ? ? ? ? "Filesystem",
>> ? ? ? ? ? ? ? ?.size = ? ? ? ? MTDPART_SIZ_FULL,
>> - ? ? ? ? ? ? ? .offset = ? ? ? 0x00400000
>> + ? ? ? ? ? ? ? .offset = ? ? ? MTDPART_OFS_APPEND
>> ? ? ? ?}
>> ?};
>>
>
