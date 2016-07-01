From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 1 Jul 2016 11:21:34 -0400
Subject: [PATCH] ARM: debug: Enable DEBUG_BCM_5301X for Northstar Plus SoCs
In-Reply-To: <1467331810-929-1-git-send-email-f.fainelli@gmail.com>
References: <1467331810-929-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <CAC3K-4p0wwArVUefsC9ku=tBVz8sdLpBkrgagfYKXGCOZayKXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 8:10 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Northstar Plus SoCs (ARCH_BCM_NSP) have the exact same UART location and
> properties like the register shift of 0, so make it usable.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jon Mason <jon.mason@broadcom.com>

> ---
>  arch/arm/Kconfig.debug | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 19a3dcf5eb2e..6912f4fbbe80 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -138,8 +138,8 @@ choice
>                 select DEBUG_UART_PL01X
>
>         config DEBUG_BCM_5301X
> -               bool "Kernel low-level debugging on BCM5301X UART1"
> -               depends on ARCH_BCM_5301X
> +               bool "Kernel low-level debugging on BCM5301X/NSP UART1"
> +               depends on ARCH_BCM_5301X || ARCH_BCM_NSP
>                 select DEBUG_UART_8250
>
>         config DEBUG_BCM_KONA_UART
> --
> 2.7.4
>
