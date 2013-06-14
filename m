From: dianders@chromium.org (Doug Anderson)
Date: Fri, 14 Jun 2013 08:01:09 -0700
Subject: [PATCH] ARM: dts: Enable RTC node for exynos5250
In-Reply-To: <1371189378-22823-1-git-send-email-tushar.behera@linaro.org>
References: <1371189378-22823-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <CAD=FV=WeY5r_=qLV6dh8HkaNGygZ33uQg5Q6dKhwd31e7MfFTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar,

On Thu, Jun 13, 2013 at 10:56 PM, Tushar Behera
<tushar.behera@linaro.org> wrote:
> The kernel dump produced by s3c-rtc driver as reported by
> commit 522ccdb6fd0e ("ARM: dts: Disable the RTC by default on exynos5")
> are no longer reproducible in latest kernel.
>
> Hence it would be good to re-enable RTC support for EXYNOS5250.
>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |    1 -
>  1 file changed, 1 deletion(-)

I would prefer we not commit this.

The original commit wasn't just about avoiding the bug (though that
was a nice side effect).  My understanding is that the SoC dtsi file
ought to have most peripherals disabled by default and individual
board dts files should enable the peripherals that they want.  I think
exynos5250 is particularly bad about this right now (it starts with
most peripherals enabled) but that should probably be fixed...

If my understanding is wrong, others on the list should definitely speak up!  :)

-Doug
