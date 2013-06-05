From: mindentropy@gmail.com (mind entropy)
Date: Wed, 5 Jun 2013 12:52:32 +0530
Subject: On mini2440 IO mappings.
In-Reply-To: <5390072.c6vttxqWyK@wuerfel>
References: <CAM2a4uxNKhD_+zr7mZOV0eR7u_VTCSZyEcsj_uNA5MuuKPFbDQ@mail.gmail.com>
 <3308480.LZZ0YkAPVH@wuerfel>
 <CAM2a4uw_mq=NZHrg32KRf7js8+3iC59SB1NPdP8EwCov7z0DnQ@mail.gmail.com>
 <5390072.c6vttxqWyK@wuerfel>
Message-ID: <CAM2a4uxAs31ba7q9UaYTKJJLvRGeFw3TmE36vbGZYbC0j1OWEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I don't think it does. The mappings are
>
> static struct map_desc s3c_iodesc[] __initdata = {
>         IODESC_ENT(GPIO),
>         IODESC_ENT(IRQ),
>         IODESC_ENT(MEMCTRL),
>         IODESC_ENT(UART)
> };
>
> using these virtual addresses:
>
> #define S3C_ADDR_BASE   0xF6000000
> #define S3C_ADDR(x)     ((void __iomem __force *)S3C_ADDR_BASE + (x))
> #define S3C_VA_IRQ      S3C_ADDR(0x00000000)    /* irq controller(s) */
> #define S3C_VA_SYS      S3C_ADDR(0x00100000)    /* system control */
> #define S3C_VA_MEM      S3C_ADDR(0x00200000)    /* memory control */
> #define S3C_VA_UART     S3C_ADDR(0x01000000)    /* UART */
> #define S3C24XX_VA_GPIO   ((S3C24XX_PA_GPIO - S3C24XX_PA_UART) + S3C24XX_VA_UART)
>
> and these physical addresses
>
> #define S3C2410_PA_UART         (0x50000000)
> #define S3C2410_PA_GPIO         (0x56000000)
> #define S3C2410_PA_IRQ          (0x4A000000)
> #define S3C2410_PA_MEMCTRL      (0x48000000)
>
> Everything is aligned to full megabytes.

You are right. Sorry I misread the virtual addresses. Now in this
scheme would there be unused holes in the virtual address space (For
eg. IRQ address space is not 1 MB big)?

-Gautam
