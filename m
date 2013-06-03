From: dianders@chromium.org (Doug Anderson)
Date: Mon, 3 Jun 2013 13:18:01 -0700
Subject: [PATCH V4 4/4] ARM: dts: add clock provider information for i2s
 controllers in Exynos5250
In-Reply-To: <1370236744-16802-5-git-send-email-padma.v@samsung.com>
References: <1370236744-16802-1-git-send-email-padma.v@samsung.com>
 <1370236744-16802-5-git-send-email-padma.v@samsung.com>
Message-ID: <CAD=FV=X_XVmQ-jyorxATqBad5hhdFe5dodg_AzjsRQ-S+1=NeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi,

On Sun, Jun 2, 2013 at 10:19 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
> +               clocks = <&clock_audss EXYNOS_I2S_BUS>,
> +                       <&clock_audss EXYNOS_I2S_BUS>,
> +                       <&clock_audss EXYNOS_SCLK_I2S>,
> +                       <&clock_audss EXYNOS_MOUT_AUDSS>,
> +                       <&clock_audss EXYNOS_MOUT_I2S>;
> +               clock-names = "iis", "i2s_opclk0", "i2s_opclk1",
> +                               "mout_audss", "mout_i2s";

Are there bindings for these clocks? Would be nice to see a
description for what they are supposed to be.

I looked up i2s_opclk0 / i2s_opclk1 and they look reasonable at a
quick glance. ...and it does seem right that iis and i2s_opclk0 are
the same. ...but I don't see any place that uses the last two. Is
there an in-flight patch?

-Doug
