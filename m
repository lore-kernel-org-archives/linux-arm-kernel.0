From: robherring2@gmail.com (Rob Herring)
Date: Thu, 8 Oct 2015 08:48:00 -0500
Subject: [PATCH v2 4/4] ARM: meson: Enable Meson8b SoCs
In-Reply-To: <1444249865-6897-5-git-send-email-carlo@caione.org>
References: <1444249865-6897-1-git-send-email-carlo@caione.org>
 <1444249865-6897-5-git-send-email-carlo@caione.org>
Message-ID: <CAL_JsqJvOwhnicWTYndaNCsQf93GhStC7Ny269Yxcoow9v0X+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 7, 2015 at 3:31 PM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  arch/arm/mach-meson/Kconfig | 5 +++++
>  arch/arm/mach-meson/meson.c | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index 0743e20..5d56f86 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -19,4 +19,9 @@ config MACH_MESON8
>         default ARCH_MESON
>         select MESON6_TIMER
>
> +config MACH_MESON8B
> +       bool "Amlogic Meson8b SoCs support"
> +       default ARCH_MESON
> +       select MESON6_TIMER

I don't see the need for a new config option. Just add the dtbs to MACH_MESON8.

> +
>  endif
> diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
> index 5d6affe..4e23571 100644
> --- a/arch/arm/mach-meson/meson.c
> +++ b/arch/arm/mach-meson/meson.c
> @@ -19,6 +19,7 @@
>  static const char * const meson_common_board_compat[] = {
>         "amlogic,meson6",
>         "amlogic,meson8",
> +       "amlogic,meson8b",
>         NULL,
>  };
>
> --
> 1.9.1
>
