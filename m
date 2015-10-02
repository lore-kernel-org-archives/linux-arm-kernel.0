From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 2 Oct 2015 17:19:20 +0300
Subject: [PATCH] ARM: debug: add support for alternate 8250 register layout
In-Reply-To: <1443787929-19173-1-git-send-email-mans@mansr.com>
References: <1443787929-19173-1-git-send-email-mans@mansr.com>
Message-ID: <560E9268.60900@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/2/2015 3:12 PM, Mans Rullgard wrote:

> Some SoCs have a UART with a non-standard register layout. This
> allows the debug console to work with these.

> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> I would have preferred a more accurate description of the UART, but I've
> not managed to figure out who the vendor is.

    You haven't seem the Alchemy datasheets? I can send you some if so.

> ---
>   arch/arm/Kconfig.debug        |  4 ++++
>   arch/arm/include/debug/8250.S | 12 ++++++++++++
>   2 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 0cfd7f9..8d5c837 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1597,6 +1597,10 @@ config DEBUG_UART_8250_WORD
>   		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
>   		DEBUG_BRCMSTB_UART
>
> +config DEBUG_UART_8250_AU
> +       bool "8250 UART has Alchemy register layout"
> +       depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
> +

    So Alchemy UART got reused on ARM?

MBR, Sergei
