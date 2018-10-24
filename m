From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 24 Oct 2018 01:52:14 -0700
Subject: [PATCH v5 1/4] clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
In-Reply-To: <20181023155727.9383-1-jagan@amarulasolutions.com>
References: <20181023155727.9383-1-jagan@amarulasolutions.com>
Message-ID: <154037113470.53599.9820023879508838050@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jagan Teki (2018-10-23 08:57:24)
> Allwinner SoC like SUN8I and SUN50I has DE2 CCU so enable them
> as default.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v5:
> - remove DRM dependency 
> Changes for v4, v3:
> - none
> Changes for v2:
> - Enable for MACH_SUN8I
> 
>  drivers/clk/sunxi-ng/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 826674d090fd..99cf8103474c 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -63,6 +63,8 @@ config SUN8I_V3S_CCU
>  
>  config SUN8I_DE2_CCU
>         bool "Support for the Allwinner SoCs DE2 CCU"
> +       default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> +       depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI)

Why do we need 'depends on'? That isn't described in the commit text.
