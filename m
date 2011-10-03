From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Oct 2011 22:13:41 +0900
Subject: [PATCH V2 2/2] ARM: SAMSUNG: Cleanup resources by using macro
In-Reply-To: <CAH9JG2Wc4M2dVFOfNE5jgsygvigE8RbPH_yLcMqarr64LfbENw@mail.gmail.com>
References: <005901cc817e$51a56d00$f4f04700$%kim@samsung.com>
	<CAH9JG2Wc4M2dVFOfNE5jgsygvigE8RbPH_yLcMqarr64LfbENw@mail.gmail.com>
Message-ID: <4E89B505.3060501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/11 12:53, Kyungmin Park wrote:
> On Mon, Oct 3, 2011 at 12:41 PM, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>> This patch adds macro SAMSUNG_RES_MEM, SAMSUNG_RES_IRQ
>> and so on to cleanup regarding 'struct resource' by using
>> defined helpers at<linux/ioport.h>.
>>
>> Cc: Ben Dooks<ben-linux@fluff.org>
>> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
>> ---
>> Changes since v1:
>> - Address comments from Russell King
>>   Using defined helpers to define resource
>>
>>   arch/arm/mach-s3c2410/include/mach/map.h  |    1 +
>>   arch/arm/plat-samsung/devs.c              |  697 +++++------------------------
>>   arch/arm/plat-samsung/include/plat/devs.h |   11 +
>>   3 files changed, 129 insertions(+), 580 deletions(-)
>>

(snip)

>>
>> +#define SAMSUNG_RES_MEM(soc, ip, sz)   DEFINE_RES_MEM(soc##_PA_##ip, sz)
>> +#define SAMSUNG_RES_IRQ(ip)            DEFINE_RES_IRQ(IRQ_##ip)
>> +
>> +#define SAMSUNG_RES_MEM_NAMED(soc, ip, sz, name)       \
>> +                               DEFINE_RES_MEM_NAMED(soc##_PA_##ip, sz, name)
>> +#define SAMSUNG_RES_IRQ_NAMED(ip, name)                        \
>> +                               DEFINE_RES_IRQ_NAMED(IRQ_##ip, name)
>> +#define SAMSUNG_RES_DMA_NAMED(ch, name)                        \
>> +                               DEFINE_RES_DMA_NAMED(DMACH_##ch, name)
>
> It's good for readability. but do you think that it's hard to find out
> defined macros are used at real place?
> e.g., Now I want to find out the S3C_PA_USB_HSOTG. it's difficult if
> you use the SAMSUNG_RES_* series macro.
> but if you use the DEFINED_RES_* series directly. it's easy to find
> out at real codes.
>
Well, I don't think so because the XXX_PA_XXX addresses are defined in 
each mach/map.h and they are usually used in here so it's not hard to 
find it.

And now the 'S3C', 'S5P' and 'SAMSUNG' are used in the 'soc' part. I'm 
preparing to consolidate the name and to remove duplicated resources.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
