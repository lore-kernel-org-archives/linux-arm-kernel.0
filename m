From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 8 Jul 2012 13:57:37 -0300
Subject: [PATCH] Add nand platform on imx27 devicetree
In-Reply-To: <1341764963-11402-1-git-send-email-tremyfr@yahoo.fr>
References: <1341764963-11402-1-git-send-email-tremyfr@yahoo.fr>
Message-ID: <CAOMZO5BjcnB=CJ=i=V7Ct9oMvgnnbK8AjWvYJZdoVmZu=+_MQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Sun, Jul 8, 2012 at 1:29 PM, Philippe Reynes <tremyfr@yahoo.fr> wrote:
> Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>
> ---
>  arch/arm/mach-imx/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index eff4db5..565422b 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -381,6 +381,7 @@ config MACH_IMX27_DT
>         bool "Support i.MX27 platforms from device tree"
>         select SOC_IMX27
>         select USE_OF
> +       select IMX_HAVE_PLATFORM_MXC_NAND

Bu doing this you end up selecting unnecessary code for dt.

I proposed a fix for this already:
http://patchwork.ozlabs.org/patch/168645/

Regards,

Fabio Estevam
