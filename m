From: olof@lixom.net (Olof Johansson)
Date: Wed, 8 May 2013 11:19:38 -0700
Subject: [PATCH] ARM: exynos: Select PINCTRL_EXYNOS for exynos5
In-Reply-To: <1368034349-15091-1-git-send-email-dianders@chromium.org>
References: <1368034349-15091-1-git-send-email-dianders@chromium.org>
Message-ID: <CAOesGMia9kLGh6B6QJZAKS1UpBg86v32S2um+0fjx5HYjje3cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 8, 2013 at 10:32 AM, Doug Anderson <dianders@chromium.org> wrote:
> If you've got MACH_EXYNOS5_DT but not MACH_EXYNOS4_DT you'll be
> missing the pincontrol definitions.  Add them for exynos5.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm/mach-exynos/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 6e77432..cdcd7fa 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -428,6 +428,8 @@ config MACH_EXYNOS5_DT
>         depends on ARCH_EXYNOS5
>         select ARM_AMBA
>         select CLKSRC_OF
> +       select PINCTRL
> +       select PINCTRL_EXYNOS

Nit:

Seems like this should be selected by the SoC (ARCH_EXYNOS5) instead
of the board. Actually, I'm not sure we need the board Kconfig entry
long-term; all boards will be dt-only.


-Olof
