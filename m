From: adrian.wenl@gmail.com (Lei Wen)
Date: Tue, 28 Jun 2011 23:12:38 +0800
Subject: [PATCH] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <1309246361.23597.30.camel@sauron>
References: <4E031900.50108@compulab.co.il>
	<1309000666-5242-1-git-send-email-leiwen@marvell.com>
	<1309246361.23597.30.camel@sauron>
Message-ID: <BANLkTik6gSqYk1FsnCGS7WgfupgA6jdY0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 3:32 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Sat, 2011-06-25 at 04:17 -0700, Lei Wen wrote:
>> Current pxa3xx_nand controller has two chip select which
>> both be workable. This patch enable this feature.
>>
>> Update platform driver to support this feature.
>>
>> Another notice should be taken that:
>> When you want to use this feature, you should not enable the
>> keep configuration feature, for two chip select could be
>> attached with different nand chip. The different page size
>> and timing requirement make the keep configuration impossible.
>>
>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>> ---
>> ?arch/arm/mach-mmp/aspenite.c ? ? ? ? ? ? ? ? | ? ?5 +-
>> ?arch/arm/mach-pxa/cm-x300.c ? ? ? ? ? ? ? ? ?| ? ?5 +-
>> ?arch/arm/mach-pxa/colibri-pxa3xx.c ? ? ? ? ? | ? ?5 +-
>> ?arch/arm/mach-pxa/littleton.c ? ? ? ? ? ? ? ?| ? ?5 +-
>> ?arch/arm/mach-pxa/mxm8x10.c ? ? ? ? ? ? ? ? ?| ? ?9 +-
>> ?arch/arm/mach-pxa/raumfeld.c ? ? ? ? ? ? ? ? | ? ?5 +-
>> ?arch/arm/mach-pxa/zylonite.c ? ? ? ? ? ? ? ? | ? ?5 +-
>> ?arch/arm/plat-pxa/include/plat/pxa3xx_nand.h | ? 19 +-
>> ?drivers/mtd/nand/pxa3xx_nand.c ? ? ? ? ? ? ? | ?512 +++++++++++++++-----------
>> ?9 files changed, 346 insertions(+), 224 deletions(-)
>
> In general huge patches like this are not encouraged and it is better to
> split them. At least the printk changes can be in a separate patch. Then
> re-naming host to info probably could be another patch. Could you please
> rather do a series of smaller patches? Also, if you use dev_info and the
> like functions, you probably do not need the pxa3xx_nand prefix anymore.
>

Hi Artem & Igor,

Thanks for your suggestion, I would seperate this patch and push back later.

Best regards,
Lei
