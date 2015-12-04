From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 4 Dec 2015 17:33:37 +0000
Subject: [PATCH] ARM: at91: fix pinctrl driver selection
In-Reply-To: <1449249513-22972-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1449249513-22972-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5661CE71.5050206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/12/15 17:18, Alexandre Belloni wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Move the selection of the pinctrl driver to SoC family level since we
> have two pinctrl drivers. It is useless to select one which is not
> compatible with the SoC.
>
> [abelloni: fixed pm.c when only sama2d2 is selected]
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/mach-at91/Kconfig | 6 +++++-
>   arch/arm/mach-at91/pm.c    | 7 ++++++-
>   2 files changed, 11 insertions(+), 2 deletions(-)
>

[...]

> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 80e277cfcc8b..01cbb17e6f6b 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -41,8 +41,10 @@
>    * implementation should be moved down into the pinctrl driver and get
>    * called as part of the generic suspend/resume path.
>    */
> +#ifdef PINCTRL_AT91

Accidentally glanced at this patch when my mail client got hung at this
patch :), I think you mean CONFIG_PINCTRL_AT91 here and later below.

--
Regards,
Sudeep
