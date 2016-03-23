From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 23 Mar 2016 14:39:53 +0800
Subject: cross build AArch64 kernel failed with ": fatal error:
 asm/types.h: No such file or directory"
In-Reply-To: <53a0aa9d.ecad.153a22bee78.Coremail.shhuiw@163.com>
References: <53a0aa9d.ecad.153a22bee78.Coremail.shhuiw@163.com>
Message-ID: <20160323143953.6eb4b3e2@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Mar 2016 14:31:41 +0800 (CST) shhuiw wrote:

> Hello,
> 
> 
> I followed the steps below to build arm64 kernel image on Intel box:
>                 make O=<output path> distclean
>                 make O=<output path> mrproper
>                 make O=<output path> ARCH=arm64 CROSS_COMPILE=aarch64-none-linux- defconfig
>                 (optional) make O=<output path> ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-   headers_install            
>                 make O=<output path> ARCH=arm64 CROSS_COMPILE=aarch64-none-linux- 
> 
> I used the upstream kernel
> 
> But the last make step failed with:
> ...
>   GEN     ./Makefile
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CC      kernel/bounds.s
> In file included from include/linux/types.h:5:0,
>                  from include/linux/page-flags.h:8,
>                  from kernel/bounds.c:9:
> include/uapi/linux/types.h:4:23: fatal error: asm/types.h: No such file or directory

It seems a toolchain issue. plz try aarch64-linux-gnu- toolchain from linaro.

Thanks

>  #include <asm/types.h>
>                        ^
> compilation terminated.
> ./Kbuild:44: recipe for target 'kernel/bounds.s' failed
> make[2]: *** [kernel/bounds.s] Error 1
> Makefile:993: recipe for target 'prepare0' failed
> make[1]: *** [prepare0] Error 2
> ...
> 
> 
> Is this a bug? Is any solution available now? 
> 
> 
> Regards,
> sh
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
