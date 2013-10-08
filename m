From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 8 Oct 2013 14:52:47 +0900
Subject: [PATCH v2 3/3] ARM: shmobile: kzm9d: Use common clock framework
In-Reply-To: <20131008143403.c11f294c8a1701a2ab3bc5fd@ops.dti.ne.jp>
References: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
 <20131008143403.c11f294c8a1701a2ab3bc5fd@ops.dti.ne.jp>
Message-ID: <CANqRtoTPoR8Lt67Bo-BC9DxdN_+XH5uEGBetYGHMnrmjYk-21w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 8, 2013 at 2:34 PM,  <takasi-y@ops.dti.ne.jp> wrote:
> Use common clock framework version of clock
>  drivers/clk/shmobile/clk-emev2.c
> instead of sh-clkfwk version
>  arch/arm/mach-shmobile/clock-emev2.c
> when it is configured as a part of multi-platform.
>
> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> ---
>  arch/arm/mach-shmobile/board-kzm9d-reference.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
> index 054d8d5..853003c 100644
> --- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9d-reference.c
> @@ -20,15 +20,14 @@
>
>  #include <linux/init.h>
>  #include <linux/of_platform.h>
> +#include <linux/clk-provider.h>
>  #include <mach/emev2.h>
>  #include <mach/common.h>
>  #include <asm/mach/arch.h>
>
>  static void __init kzm9d_add_standard_devices(void)
>  {
> -       if (!IS_ENABLED(CONFIG_COMMON_CLK))
> -               emev2_clock_init();
> -
> +       of_clk_init(NULL);

Hi Yoshii-san,

Thanks, this looks very good. It is the correct way now when
renesas-devel-20131008 includes the following series:
[PATCH 00/05] ARM: shmobile: KZM9D Multiplatform update

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
