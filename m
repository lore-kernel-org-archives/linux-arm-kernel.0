From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 9 Jan 2016 01:13:46 +0900
Subject: [Question] Any restriction for the location of initramdisk?
In-Reply-To: <1452248544.3006.2.camel@linaro.org>
References: <CAK7LNAQS--QobTNyAvxqqZY2gvy4zB_eBOGju69Pjs-1FAJ+tQ@mail.gmail.com>
 <1452248544.3006.2.camel@linaro.org>
Message-ID: <CAK7LNAQ4jnBC3Q3wPMLD0E7e=5y2yOvBL-3oG_N44KO2K_kRdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

2016-01-08 19:22 GMT+09:00 Jon Medhurst (Tixy) <tixy@linaro.org>:
> On Fri, 2016-01-08 at 16:16 +0900, Masahiro Yamada wrote:
>> Hi.
>>
>>
>> I know DTB should be located within the reach of the kernel
>> so that the kernel can get access to it at the early boot stage.
>> In other words, DTB should be put in the low memory area.
>>
>> Does initramdisk has the similar restriction?
>
> I assume so, as that's what Documentation/arm/Booting says ...
>
>
> 5. Load initramfs.
> ------------------
>
> Existing boot loaders:          OPTIONAL
> New boot loaders:               OPTIONAL
>
> If an initramfs is in use then, as with the dtb, it must be placed in
> a region of memory where the kernel decompressor will not overwrite it
> while also with the region which will be covered by the kernel's
> low-memory mapping.
>
> A safe location is just above the device tree blob which itself will
> be loaded just above the 128MiB boundary from the start of RAM as
> recommended above.


Uh, the document states that clearly.

Thanks!




-- 
Best Regards
Masahiro Yamada
