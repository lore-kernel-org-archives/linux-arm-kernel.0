From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 08 Jan 2016 10:22:24 +0000
Subject: [Question] Any restriction for the location of initramdisk?
In-Reply-To: <CAK7LNAQS--QobTNyAvxqqZY2gvy4zB_eBOGju69Pjs-1FAJ+tQ@mail.gmail.com>
References: <CAK7LNAQS--QobTNyAvxqqZY2gvy4zB_eBOGju69Pjs-1FAJ+tQ@mail.gmail.com>
Message-ID: <1452248544.3006.2.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-01-08 at 16:16 +0900, Masahiro Yamada wrote:
> Hi.
> 
> 
> I know DTB should be located within the reach of the kernel
> so that the kernel can get access to it at the early boot stage.
> In other words, DTB should be put in the low memory area.
> 
> Does initramdisk has the similar restriction?

I assume so, as that's what Documentation/arm/Booting says ...


5. Load initramfs.
------------------

Existing boot loaders:		OPTIONAL
New boot loaders:		OPTIONAL

If an initramfs is in use then, as with the dtb, it must be placed in
a region of memory where the kernel decompressor will not overwrite it
while also with the region which will be covered by the kernel's
low-memory mapping.

A safe location is just above the device tree blob which itself will
be loaded just above the 128MiB boundary from the start of RAM as
recommended above.


-- 
Tixy
