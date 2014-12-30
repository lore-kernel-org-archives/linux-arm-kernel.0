From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 30 Dec 2014 13:42:29 +0300
Subject: [PATCH v2 07/12] ARM: imx: depend MXC debug board on 3DS machines
In-Reply-To: <1419895935-22966-8-git-send-email-stefan@agner.ch>
References: <1419895935-22966-1-git-send-email-stefan@agner.ch>
 <1419895935-22966-8-git-send-email-stefan@agner.ch>
Message-ID: <54A28195.4070102@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/30/2014 2:32 AM, Stefan Agner wrote:

> Depend the MXC debug board on machines which actually support it.

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> This configuration appeared lonely when I enabled ARCH_MULTI_V7M.
> Afaik, the selection of it only makes sense with one of the supported
> boards...

>   arch/arm/mach-imx/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 3c5859e..96c8eb8 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -21,6 +21,7 @@ config MXC_AVIC
>
>   config MXC_DEBUG_BOARD
>   	bool "Enable MXC debug board(for 3-stack)"
> +	depends on CONFIG_MACH_MX27_3DS || CONFIG_MACH_MX31_3DS || CONFIG_MACH_MX35_3DS

    CONFIG_ prefixes are not needed in Kconfig.

[...]

WBR, Sergei
