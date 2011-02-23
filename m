From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Feb 2011 15:02:44 +0000
Subject: CPU_V6K build failure in next-20110223
In-Reply-To: <20110223144020.GE2796@pulham.picochip.com>
References: <20110223144020.GE2796@pulham.picochip.com>
Message-ID: <20110223150244.GA14911@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 02:40:20PM +0000, Jamie Iles wrote:
> Hi Russell,
> 
> Building todays next tree for my board (CPU_V6K) results in the 
> following build error:
> 
>   CC      arch/arm/kernel/asm-offsets.s
> In file included from /home/jamiei/src/linux-2.6/arch/arm/include/asm/cacheflush.h:15,
>                  from arch/arm/kernel/asm-offsets.c:16:
> /home/jamiei/src/linux-2.6/arch/arm/include/asm/glue-cache.h:129:2: error: #error Unknown cache maintainence model
> make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2
> 
> Building dove_defconfig also results in the same error.  The patch below 
> appears to fix the issue.

Welcome to the wonderful world of git conflicts with fixes needed in
non-conflicting files...
