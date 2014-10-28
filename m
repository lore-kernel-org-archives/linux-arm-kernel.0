From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 28 Oct 2014 10:03:16 +0100
Subject: [PATCH v9] ARM: EXYNOS: Use MCPM call-backs to support S2R on
 Exynos5420
In-Reply-To: <1412746892-12329-1-git-send-email-a.kesavan@samsung.com>
References: <1412746892-12329-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CABxcv=m0Fq3YZ3kmjjhPaBz5bOSSe1vrmMRQxiWn3Qy4eR8C_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On Wed, Oct 8, 2014 at 7:41 AM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> Use the MCPM layer to handle core suspend/resume on Exynos5420.
> Also, restore the entry address setup code post-resume.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> ---
> Changes in v2:
>         - Made use of the MCPM suspend/powered_up call-backs
> Changes in v3:
>         - Used the residency value to indicate the entered state
> Changes in v4:
>         - Checked if MCPM has been enabled to prevent build error
> Changes in v5:
>         - Removed the MCPM flags and just used a local flag to
>         indicate that we are suspending.
> Changes in v6:
>         - Read the SYS_PWR_REG value to decide if we are suspending
>         the system.
>         - Restore the SYS_PWR_REG value post-resume.
>         - Modified the comments to reflect the first change.
> Changes in v7:
>         - Add the suspend check in exynos_cpu_power_down() rather
>         than the MCPM back-end.
>         - Clean-up unnecessary changes related to earlier versions.
> Changes in v8:
>         - Rebased on the latest exynos PMU/PM support patches.
> Changes in v9:
>         - Fixed rebasing issues in v8
>         - Used pmu_raw_readl instead of __raw_readl
>
> This patch is based on kgene's for-next branch.
> http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
>
> Here are the dependencies:
> 1) Decouple syscon interface from platform devices - v7
> http://lkml.org/lkml/2014/9/30/156
>

This has already been picked by Lee Jones (mfd maintainer) and is
shown in linux-next.

> 2) ARM: Exynos: Convert PMU implementation into a platform driver - v9
> https://lkml.org/lkml/2014/10/6/89
>
> 3) Exynos5420 PMU/S2R Series - v9
> http://www.spinics.net/lists/arm-kernel/msg368207.html
>

Now that 1) has been picked, could you please pick 2), 3) and $subject
to have S2R working on Exynos5420?

Best regards,
Javier
