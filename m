From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 16 Oct 2013 07:32:20 +0900
Subject: [PATCH RESEND 0/3] ARM: S3C24XX: add missing dma-devices and
 warning fix
In-Reply-To: <201310132011.11285.heiko@sntech.de>
References: <201310111059.19791.heiko@sntech.de>
 <20131013145642.GJ2954@intel.com> <201310132011.11285.heiko@sntech.de>
Message-ID: <525DC274.8090808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/13 03:11, Heiko St?bner wrote:
> Am Sonntag, 13. Oktober 2013, 16:56:42 schrieb Vinod Koul:
>> On Fri, Oct 11, 2013 at 10:59:19AM +0200, Heiko St?bner wrote:
>>> [I messed up the linux-arm-kernel list address yesterday, so I resend it
>>> with a fixed address, sorry for the noise]
>>>
>>> When Olof reported the warning about the unused s3c2410_dma_resource, I
>>> thought the best way forward would be to simply implement the missing
>>> pieces and so it has users :-) .
>>>
>>> Therefore this series adds the necessary platform-devices for s3c2410,
>>> s3c2440 and s3c2442. This especially also includes the
>>> channel-constraints of those socs.
>>>
>>> As I do not have access to any of those socs these changes are of course
>>> compile-tested only.
>>
>> Do you want this to be applied thru dma or arm tree?
>
> hmm, the original series went into the samsung tree for 3.13, so maybe this
> addition should go the same way?
>
I think so, let me pick this up into Samsung tree for v3.13.

Thanks,
Kukjin

>
> Heiko
>
>
>> ~Vinod
>>
>>> Heiko Stuebner (3):
>>>    ARM: S3C24XX: Fix possible dma selection warning
>>>    dmaengine: s3c24xx-dma: add support for the s3c2410 type of controller
>>>    ARM: S3C24XX: add dma platformdata for s3c2410, s3c2440 and s3c2442
>>>
>>>   arch/arm/mach-s3c24xx/Kconfig             |    3 +-
>>>   arch/arm/mach-s3c24xx/common.c            |  100
>>>   +++++++++++++++++++++++++++++ arch/arm/mach-s3c24xx/common.h
>>>   |    2 +
>>>   drivers/dma/s3c24xx-dma.c                 |   10 +++
>>>   include/linux/platform_data/dma-s3c24xx.h |    3 +
>>>   sound/soc/samsung/Kconfig                 |    2 +-
>>>   6 files changed, 118 insertions(+), 2 deletions(-)
