From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 22 Jul 2015 11:17:09 +0200
Subject: [PATCH v2 1/3] ARM: STi: Add code to release secondary cores
 from holding pen.
In-Reply-To: <1433856824-30689-2-git-send-email-peter.griffin@linaro.org>
References: <1433856824-30689-1-git-send-email-peter.griffin@linaro.org>
 <1433856824-30689-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <55AF5F95.20307@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 06/09/2015 03:33 PM, Peter Griffin wrote:
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
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>   arch/arm/mach-sti/headsmp.S |  1 +
>   arch/arm/mach-sti/platsmp.c | 55 ++++++++++++++++++++++++++++++++++++++++++---
>   arch/arm/mach-sti/smp.h     |  2 ++
>   3 files changed, 55 insertions(+), 3 deletions(-)
>
>

Applied to sti-soc-for-v4.3.

Thanks!
Maxime
