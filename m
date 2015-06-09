From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 9 Jun 2015 11:17:41 +0200
Subject: [PATCH 1/2] ARM: STi: Add code to release secondary cores from
 holding pen.
In-Reply-To: <1433780219-1245-2-git-send-email-peter.griffin@linaro.org>
References: <1433780219-1245-1-git-send-email-peter.griffin@linaro.org>
 <1433780219-1245-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <5576AF35.1020100@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 06/08/2015 06:16 PM, Peter Griffin wrote:
> Most upstream devs boot STi platform via JTAG which abuses the
> boot process by setting the PC of secondary cores directly. As
> a consquence, booting STi platforms via u-boot results in only
> the primary core being brought up as the code to manage the
> holding pen is not upstream.
>
> This patch adds the necessary code to bring the secondary cores
> out of the holding pen. It uses the cpu-release-addr DT property
> to get the address of the holding pen from the bootloader.
>
> With this patch booting upstream kernels via u-boot works
> correctly:
>
> [    0.045456] CPU: Testing write buffer coherency: ok
> [    0.045597] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.045734] Setting up static identity map for 0x40209000 - 0x40209098
> [    0.065047] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.065081] Brought up 2 CPUs
> [    0.065089] SMP: Total of 2 processors activated (5983.43 BogoMIPS).
> [    0.065092] CPU: All CPU(s) started in SVC mode.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   arch/arm/mach-sti/headsmp.S |  1 +
>   arch/arm/mach-sti/platsmp.c | 56 ++++++++++++++++++++++++++++++++++++++++++---
>   arch/arm/mach-sti/smp.h     |  2 ++
>   3 files changed, 56 insertions(+), 3 deletions(-)

>
> diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
> index d4b624f..6597ed8 100644
> --- a/arch/arm/mach-sti/platsmp.c
> +++ b/arch/arm/mach-sti/platsmp.c

>   
>   struct smp_operations __initdata sti_smp_ops = {
> @@ -114,3 +163,4 @@ struct smp_operations __initdata sti_smp_ops = {
>   	.smp_secondary_init	= sti_secondary_init,
>   	.smp_boot_secondary	= sti_boot_secondary,
>   };
> +
Please remove trailing line.

Once fixed, you can add:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
