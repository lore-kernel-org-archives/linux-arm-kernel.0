From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 3 Nov 2010 21:33:14 +0800
Subject: [PATCH 01/17] ARM: pxa: Fix missing includes
In-Reply-To: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
References: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTik--cShUXGDNwZ+usZU2bz=t4UE7HrMASaUsFcL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 3, 2010 at 7:51 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> After the "ARM: pxa: Introduce pxa{25x,27x,3xx}_map_io()" patch, forged by me
> and Eric, was applied, some variables were misnamed and some includes missing.
> This patch corrects these errors.

Already fixed in my tree, but thanks again for spotting this.

>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> ?arch/arm/mach-pxa/pxa25x.c | ? ?2 ++
> ?arch/arm/mach-pxa/pxa27x.c | ? ?5 ++++-
> ?arch/arm/mach-pxa/pxa3xx.c | ? ?4 +++-
> ?3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
> index 4596b98..acde987 100644
> --- a/arch/arm/mach-pxa/pxa25x.c
> +++ b/arch/arm/mach-pxa/pxa25x.c
> @@ -31,6 +31,8 @@
> ?#include <mach/pm.h>
> ?#include <mach/dma.h>
>
> +#include <asm/mach/map.h>
> +
> ?#include "generic.h"
> ?#include "devices.h"
> ?#include "clock.h"
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index af47bef..764b9ac 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -27,8 +27,11 @@
> ?#include <mach/ohci.h>
> ?#include <mach/pm.h>
> ?#include <mach/dma.h>
> +
> ?#include <plat/i2c.h>
>
> +#include <asm/mach/map.h>
> +
> ?#include "generic.h"
> ?#include "devices.h"
> ?#include "clock.h"
> @@ -387,7 +390,7 @@ static struct map_desc pxa27x_io_desc[] __initdata = {
> ?void __init pxa27x_map_io(void)
> ?{
> ? ? ? ?pxa_map_io();
> - ? ? ? iotable_init(ARRAY_AND_SIZE(pxa27x_io_table));
> + ? ? ? iotable_init(ARRAY_AND_SIZE(pxa27x_io_desc));
> ? ? ? ?pxa27x_get_clk_frequency_khz(1);
> ?}
>
> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index af7f701..bb60664 100644
> --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> @@ -32,6 +32,8 @@
> ?#include <mach/regs-intc.h>
> ?#include <plat/i2c.h>
>
> +#include <asm/mach/map.h>
> +
> ?#include "generic.h"
> ?#include "devices.h"
> ?#include "clock.h"
> @@ -592,7 +594,7 @@ static struct map_desc pxa3xx_io_desc[] __initdata = {
> ?void __init pxa3xx_map_io(void)
> ?{
> ? ? ? ?pxa_map_io();
> - ? ? ? iotable_init(ARRAY_AND_SIZE(common_io_desc));
> + ? ? ? iotable_init(ARRAY_AND_SIZE(pxa3xx_io_desc));
> ? ? ? ?pxa3xx_get_clk_frequency_khz(1);
> ?}
>
> --
> 1.7.2.3
>
>
