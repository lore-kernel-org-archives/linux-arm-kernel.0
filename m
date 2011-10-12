From: axel.lin@gmail.com (Axel Lin)
Date: Wed, 12 Oct 2011 21:49:13 +0800
Subject: [PATCH] ARM: SAMSUNG: s3c-dma-ops needs export.h for EXPORT_SYMBOL
In-Reply-To: <069601cc88dc$6b9a78d0$42cf6a70$%kim@samsung.com>
References: <1317961214.16109.1.camel@phoenix>
	<069601cc88dc$6b9a78d0$42cf6a70$%kim@samsung.com>
Message-ID: <CAF+7xWmXGovD4zdst16fdX66voauhvKFTctQLEORX9tosckfkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/12 Kukjin Kim <kgene.kim@samsung.com>:
> Kukjin Kim wrote:
>>
>> Axel Lin wrote:
>> >
>> > Fix below build warning:
>> > ? CC ? ? ?arch/arm/plat-samsung/s3c-dma-ops.o
>> > arch/arm/plat-samsung/s3c-dma-ops.c:130: warning: data definition has no type
>> or
>> > storage class
>> > arch/arm/plat-samsung/s3c-dma-ops.c:130: warning: type defaults to 'int' in
>> > declaration of 'EXPORT_SYMBOL'
>> > arch/arm/plat-samsung/s3c-dma-ops.c:130: warning: parameter names (without
>> > types) in function declaration
>> >
>> > And fix the build error:
>> > ERROR: "s3c_dma_get_ops" [drivers/spi/spi-s3c64xx.ko] undefined!
>> > make[1]: *** [__modpost] Error 1
>> > make: *** [modules] Error 2
>> >
>> > Signed-off-by: Axel Lin <axel.lin@gmail.com>
>> > ---
>> > This can be reproduced by "make s3c6400_defconfig;make" on linux-next
>> > 20111006.
>> > ?arch/arm/plat-samsung/s3c-dma-ops.c | ? ?1 +
>> > ?1 files changed, 1 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/plat-samsung/s3c-dma-ops.c b/arch/arm/plat-samsung/s3c-
>> > dma-ops.c
>> > index 582333c..7814949 100644
>> > --- a/arch/arm/plat-samsung/s3c-dma-ops.c
>> > +++ b/arch/arm/plat-samsung/s3c-dma-ops.c
>> > @@ -14,6 +14,7 @@
>> > ?#include <linux/errno.h>
>> > ?#include <linux/slab.h>
>> > ?#include <linux/types.h>
>> > +#include <linux/export.h>
>> >
>> > ?#include <mach/dma.h>
>> >
>> > --
>> > 1.7.4.1
>> >
>> OK, will apply.
>>
>> BTW, I don't know why the build error/warning was not happened in my tree with
>> s3c6400_defconfig. Probably other file having it?...
>>
> Hi Axel,
>
> When I applied this in my tree, happened following error with s3c6400_defconfig.
>
> arch/arm/plat-samsung/s3c-dma-ops.c:17: fatal error: linux/export.h: No such file or directory
>
> Probably the <linux/export.h> file has been added from other tree.
> So if required, will fix with this during upcoming merge window maybe at end of.
>
Cc Paul Gortmaker,
Maybe it is only in Paul's tree now.

Regards,
Axel
