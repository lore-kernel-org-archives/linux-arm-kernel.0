From: padma.kvr@gmail.com (Padma Venkat)
Date: Fri, 23 Nov 2012 16:40:59 +0530
Subject: [PATCH V3 0/5] Avoid passing clks through platform data
In-Reply-To: <1352177317-16395-1-git-send-email-padma.v@samsung.com>
References: <1352177317-16395-1-git-send-email-padma.v@samsung.com>
Message-ID: <CAAgF-Bevg7h1yq1bnLhwbUJ94+HKhaaJ6MeYvXUAunKpE-Lvkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc'ing Mark Brown.

On Tue, Nov 6, 2012 at 10:18 AM, Padmavathi Venna <padma.v@samsung.com> wrote:
> Changes since v2:
>         - Rebased on 3.7-rc3
>
> I2S controller has an internal mux for RCLK source clks. The list
> of source clk names were passed through platform data in non-dt case.
> The variable holding the list of RCLK source clk names is not
> required, as the list of clks need to be registered with clkdev
> using generic connection id. This is required as part of adding DT
> support for I2S controller driver.
>
> In the below series of patches, registered the existed clks with
> clkdev using generic connection id and removed the variable which
> holds those clk names. This is done for s3c64xx,s5pc100,s5p64x0,
> s5pv210 and exynos4 series. But tested the sound card detection
> only on smdk6410 board. On remaining all platforms it was just
> build tested.
>
> Padmavathi Venna (5):
>   ARM: S3C64XX: Add I2S clkdev support
>   ARM: S5PC100: Add I2S clkdev support
>   ARM: S5P64x0: Add I2S clkdev support
>   ARM: S5PV210: Avoid passing the clks through platform data
>   ARM: Exynos: Avoid passing the clks through platform data
>
>  arch/arm/mach-exynos/dev-audio.c      |   12 ---
>  arch/arm/mach-s3c64xx/clock.c         |  126 ++++++++++++++++++++-------------
>  arch/arm/mach-s3c64xx/dev-audio.c     |   11 ---
>  arch/arm/mach-s5p64x0/clock-s5p6440.c |   49 +++++++++----
>  arch/arm/mach-s5p64x0/clock-s5p6450.c |   61 +++++++++++-----
>  arch/arm/mach-s5p64x0/dev-audio.c     |   12 ---
>  arch/arm/mach-s5pc100/clock.c         |   48 ++++++++-----
>  arch/arm/mach-s5pc100/dev-audio.c     |   16 ----
>  arch/arm/mach-s5pv210/dev-audio.c     |   16 ----
>  9 files changed, 182 insertions(+), 169 deletions(-)
>
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
