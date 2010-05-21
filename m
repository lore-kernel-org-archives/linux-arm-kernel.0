From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 21 May 2010 19:30:16 +0800
Subject: L2 cache support for pxa16x
In-Reply-To: <AANLkTilS3eCvMiyMmcX8LZQjkcSn2rsKm94uEyaa4FC_@mail.gmail.com>
References: <1273658181.6926.27.camel@pe-dt434>
	<AANLkTiky2tG7-n5bmMBqhKBIn7tq1tIT0KeWpkUee5YK@mail.gmail.com>
	<1274350676.6926.58.camel@pe-dt434>
	<AANLkTil839_xcOATFEFyQH5YVgWPwJcf31Wo1ZqmJ7Z6@mail.gmail.com>
	<1274435046.6926.69.camel@pe-dt434>
	<AANLkTimdpvBJjF_JgnD1_K6AdnRjW2jaE_49eBb8CoMu@mail.gmail.com>
	<1274438229.6926.73.camel@pe-dt434>
	<AANLkTilS3eCvMiyMmcX8LZQjkcSn2rsKm94uEyaa4FC_@mail.gmail.com>
Message-ID: <AANLkTikGOFQhjxG2I1YJedlb-LTmr1zxCZEpXzNjZ_6G@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 7:07 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
>> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
>> index a2d307e..d047d8c 100644
>> --- a/arch/arm/mach-mmp/aspenite.c
>> +++ b/arch/arm/mach-mmp/aspenite.c
>> @@ -17,6 +17,7 @@
>> ?#include <linux/mtd/partitions.h>
>> ?#include <linux/mtd/nand.h>
>>
>> +#include <asm/hardware/cache-tauros2.h>
>> ?#include <asm/mach-types.h>
>> ?#include <asm/mach/arch.h>
>> ?#include <mach/addr-map.h>
>> @@ -125,6 +126,7 @@ static struct pxa3xx_nand_platform_data
>> aspenite_nand_info = {
>>
>> ?static void __init common_init(void)
>> ?{
>> + ? ? ? tauros2_init();
>> ? ? ? ?mfp_config(ARRAY_AND_SIZE(common_pin_config));
>>
>
> Why do you initialize L2 at here? I think that we should enable L2 a
> bit earlier. For example, in pxa168_init().
>

I think that's what dove is doing.
