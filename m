From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 22 Apr 2010 06:11:35 +0800
Subject: [PATCH 2/2] SA1100: add processor check to sa1110-cpufreq driver
In-Reply-To: <1271875749-2891-3-git-send-email-mad_soft@inbox.ru>
References: <1271875749-2891-1-git-send-email-mad_soft@inbox.ru>
	<1271875749-2891-3-git-send-email-mad_soft@inbox.ru>
Message-ID: <x2rf17812d71004211511x5535667di678766abb3735cfd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 22, 2010 at 2:49 AM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> Just to make sure that this driver won't run on StrongArm SA1100
> when both SA1100 and SA1110 cpufreq drivers are built in (usually
> in multimachine config). SA1100 driver already has similar check.
>
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

Looks correct to me as well.

> ---
> ?arch/arm/mach-sa1100/cpu-sa1110.c | ? ?3 +++
> ?1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-sa1100/cpu-sa1110.c b/arch/arm/mach-sa1100/cpu-sa1110.c
> index 63b32b6..7252874 100644
> --- a/arch/arm/mach-sa1100/cpu-sa1110.c
> +++ b/arch/arm/mach-sa1100/cpu-sa1110.c
> @@ -363,6 +363,9 @@ static int __init sa1110_clk_init(void)
> ? ? ? ?struct sdram_params *sdram;
> ? ? ? ?const char *name = sdram_name;
>
> + ? ? ? if (!cpu_is_sa1110())
> + ? ? ? ? ? ? ? return -ENODEV;
> +
> ? ? ? ?if (!name[0]) {
> ? ? ? ? ? ? ? ?if (machine_is_assabet())
> ? ? ? ? ? ? ? ? ? ? ? ?name = "TC59SM716-CL3";
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
