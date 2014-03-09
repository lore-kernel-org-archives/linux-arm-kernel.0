From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Mar 2014 21:35:08 -0800
Subject: [PATCH v2] ARM: shmobile: Add temporary include workaround
In-Reply-To: <20140224224446.14786.79602.sendpatchset@w520>
References: <20140224224446.14786.79602.sendpatchset@w520>
Message-ID: <20140309053508.GC12854@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 07:44:46AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add temporary include path in the mach-shmobile Makefile to
> aid coversion from using <mach/something.h> to "something.h"
> in the source files.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> ---
> 
>  Changes since V1:
>  - Use += instead of := to avoid breaking MULTIPLATFORM
> 
>  arch/arm/mach-shmobile/Makefile |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- 0001/arch/arm/mach-shmobile/Makefile
> +++ work/arch/arm/mach-shmobile/Makefile	2014-02-25 07:41:56.000000000 +0900
> @@ -4,6 +4,8 @@
>  
>  ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/include
>  
> +ccflags-y += -I$(srctree)/arch/arm/mach-shmobile/include/mach
> +
>  # Common objects
>  obj-y				:= timer.o console.o
>  

Hmm. Not a fan of doing this. Let's just do the include file move with
the include string changes instead on each instance.
