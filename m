From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 06 Apr 2012 16:50:54 +0400
Subject: [PATCH] ARM: kirkwood: add missing kexec.h include
In-Reply-To: <1333715458-13834-1-git-send-email-ijc@hellion.org.uk>
References: <1333715458-13834-1-git-send-email-ijc@hellion.org.uk>
Message-ID: <4F7EE6AE.4020909@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.04.2012 16:30, Ian Campbell wrote:
> Fixes build the following error when CONFIG_KEXEC is enabled:

    Maybe "the following build error" instead?

>    CC      arch/arm/mach-kirkwood/board-dt.o
> arch/arm/mach-kirkwood/board-dt.c: In function 'kirkwood_dt_init':
> arch/arm/mach-kirkwood/board-dt.c:52:2: error: 'kexec_reinit' undeclared (first use in this function)
> arch/arm/mach-kirkwood/board-dt.c:52:2: note: each undeclared identifier is reported only once for each function it appears in

> kexec.h also needs string.h.

    Why it doesn't include it?

> Signed-off-by: Ian Campbell<ijc@hellion.org.uk>
> ---
>   arch/arm/mach-kirkwood/board-dt.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 1c672d9..5868b71 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -14,6 +14,8 @@
>   #include<linux/init.h>
>   #include<linux/of.h>
>   #include<linux/of_platform.h>
> +#include<linux/string.h>
> +#include<asm/kexec.h>
>   #include<asm/mach/arch.h>
>   #include<asm/mach/map.h>
>   #include<mach/bridge-regs.h>

WBR, Sergei
