From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 18 Jun 2010 16:44:59 +0900
Subject: Several questions regarding ARCH_S3C2410
In-Reply-To: <AANLkTimPk6mtyB57jXuAq1ugQseS655OCPEuP9-qZYoT@mail.gmail.com>
References: <AANLkTimPk6mtyB57jXuAq1ugQseS655OCPEuP9-qZYoT@mail.gmail.com>
Message-ID: <AANLkTilbEYR28lrVBAIXXuJ6sEf5uCp4Tpr7wriBZLj3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CCing Mr. Kim

On Fri, Jun 18, 2010 at 12:43 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Hi Ben,
>
> While working towards a unified kernel, I found that ARCH_S3C2410 actually
> includes multiple mach-* already.
>
> linux-2.6$ git grep "ARCH_S3C2410" arch/arm/Makefile
> arch/arm/Makefile:machine-$(CONFIG_ARCH_S3C2410) ? ? ? ?:= s3c2410 s3c2400
> s3c2412 s3c2416 s3c2440 s3c2443
>
> There are several questions though:
>
> 1. It looks like only s3c2410 is significant, so all the common definitions
> ? like PHYS_OFFSET are actually same across all mach-s3c24* (except for
> ? s3c24a0) ? Yet I've found arch/arm/mach-s3c2400/include/mach/memory.h,
> ? where a different PHYS_OFFSET is defined, just feel a bit confused.
>
> 2. So except for s3c24a0, theretically, it's possible to combine all these
> ? mach into something mach-s3c24xx?
>
> 3. When trying building of s3c2410_defconfig, there are a lot complaints
> ? about re-definitions of {in,out}[s]{b,w,l}. ?Taking a look into io.h,
> ? I'm wondering if it's possible to use those definitions in asm/io.h?
> ? (possibly with a customized __io())
>
> In file included from linux-2.6/include/linux/scatterlist.h:8,
> ? ? ? ? ? ? ? ? from linux-2.6/include/linux/dma-mapping.h:7,
> ? ? ? ? ? ? ? ? from linux-2.6/include/linux/dmaengine.h:26,
> ? ? ? ? ? ? ? ? from linux-2.6/include/linux/skbuff.h:30,
> ? ? ? ? ? ? ? ? from linux-2.6/lib/kobject_uevent.c:24:
> linux-2.6/arch/arm/include/asm/io.h:137: warning: "outb" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:196: note: this is
> the location of the previous definition
> linux-2.6/arch/arm/include/asm/io.h:138: warning: "outw" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:197: note: this is
> the location of the previous definition
> linux-2.6/arch/arm/include/asm/io.h:140: warning: "outl" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:198: note: this is
> the location of the previous definition
> linux-2.6/arch/arm/include/asm/io.h:143: warning: "inb" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:193: note: this is
> the location of the previous definition
> linux-2.6/arch/arm/include/asm/io.h:144: warning: "inw" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:194: note: this is
> the location of the previous definition
> linux-2.6/arch/arm/include/asm/io.h:146: warning: "inl" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:195: note: this is
> the location of the previous definition
> linux-2.6/arch/arm/include/asm/io.h:149: warning: "outsb" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:207: note: this is
> the location of the previous definition
> linux-2.6/arch/arm/include/asm/io.h:150: warning: "outsw" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:208: note: this is
> the location of the previous definition
> linux-2.6/arch/arm/include/asm/io.h:151: warning: "outsl" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:209: note: this is
> the location of the previous definition
> linux-2.6/arch/arm/include/asm/io.h:153: warning: "insb" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:203: note: this is
> the location of the previous definition
> linux-2.6/arch/arm/include/asm/io.h:154: warning: "insw" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:204: note: this is
> the location of the previous definition
> linux-2.6/arch/arm/include/asm/io.h:155: warning: "insl" redefined
> linux-2.6/arch/arm/mach-s3c2410/include/mach/io.h:205: note: this is
> the location of the previous definition
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
