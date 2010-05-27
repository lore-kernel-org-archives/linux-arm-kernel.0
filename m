From: mcuos.com@gmail.com (Wan ZongShun)
Date: Thu, 27 May 2010 11:14:07 +0800
Subject: defining ARM machine type properly
In-Reply-To: <4BFD8E7A.6050103@gmail.com>
References: <4BFD8E7A.6050103@gmail.com>
Message-ID: <AANLkTilhxt5hVjffJMRPzN477Czw2_Xtqo2joYvo1vM3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/27 f. achkar <fachkar.datawind@gmail.com>:
> hi,
> I'm trying to port smdk2450 arch to the a new kernel 2.6.32-9, I did the
> initial work as per various googled documents, but somehow the current
> initial Image is failing at arch/arm/kernel/head-common.S :
> '__lookup_processor_type', and eventually goes to '__error_a' of the

The '__lookup_processor_type' goes to '__error_a'  is not related to
your machine_type,
you should check whether there is a true definition of  select
CPU_ARMxx in the arch/arm/kconfig.

The issue maybe result from you get a wrong ARM processor type
number,which is not equal to
the R9 resigster value.

> same file! this seems to be related to the definition of machine_type as
> defined in :
> include/asm-arm/mach-types.h ?and arch/arm/tools/mach-types*
> I checked where the definition goes in ?include/asm-arm/mach-types.h by
> inserting
> #error 2223XX
> into various parts of that header and seems fine at the point.
> nevertheless I'm not 100 sure
> I wonder if the is a definitive reference to guide in this matter,
> better yet a check-list like procedure??
> thanks,
> ferar
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
