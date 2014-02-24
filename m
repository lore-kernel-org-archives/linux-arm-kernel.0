From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 15:25:19 +0900
Subject: [PATCH 01/12] ARM: shmobile: Add temporary include workaround
In-Reply-To: <20140224054107.1143.71718.sendpatchset@w520>
References: <20140224054058.1143.14096.sendpatchset@w520>
 <20140224054107.1143.71718.sendpatchset@w520>
Message-ID: <CANqRtoQRRoPXiAuLjJ1RKeCqARL5dYYEnCA=3k+YdeduorXOaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 2:41 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@opensource.se>
>
> Add temporary include path in the mach-shmobile Makefile to
> aid coversion from using <mach/something.h> to "something.h"
> in the source files.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
>  arch/arm/mach-shmobile/Makefile |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- 0001/arch/arm/mach-shmobile/Makefile
> +++ work/arch/arm/mach-shmobile/Makefile        2014-02-24 13:03:32.000000000 +0900
> @@ -4,6 +4,8 @@
>
>  ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/include
>
> +ccflags-y := -I$(srctree)/arch/arm/mach-shmobile/include/mach
> +
>  # Common objects
>  obj-y                          := timer.o console.o
>

Just noticed, I managed to send an old version of this patch. The
above should be "ccflags-y += ..." which is needed for multiplatform,

Cheers,

/ magnus
