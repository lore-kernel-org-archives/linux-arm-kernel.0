From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 12 Feb 2014 10:18:33 +0530
Subject: [PATCH] ARM: dts: exynos5250-arndale: Keep G3D regulator always on
In-Reply-To: <1392141043-27170-1-git-send-email-t.figa@samsung.com>
References: <1392141043-27170-1-git-send-email-t.figa@samsung.com>
Message-ID: <CAHbNUh0gPXV36CtmsktJA+hHPDBkvVcej3xJgTRB8UqASuyeeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 February 2014 23:20, Tomasz Figa <t.figa@samsung.com> wrote:
> Apparently, if G3D regulator is powered off, the SoC cannot enter low
> power modes and just hangs. This patch fixes this by keeping the
> regulator always on when the system is running, as suggested by Exynos 4
> User's Manual in case of Exynos4210/4x12 SoCs (Exynos5250 UM does not
> have such note, but observed behavior seems to confirm that it is true
> for this SoC as well).
>
> This fixes an issue preventing Arndale board from entering sleep mode
> observed since commit
>
> 346f372f7b72a0 clk: exynos5250: Add CLK_IGNORE_UNUSED flag for pmu clock
>
> that landed in kernel 3.11, which has fixed the clock driver to make the
> SoC actually try to enter the sleep mode.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: stable at vger.kernel.org

Thanks for the patch.

Tested-by: Tushar Behera <tushar.behera@linaro.org>

-- 
Tushar Behera
