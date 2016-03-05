From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 6 Mar 2016 00:22:37 +0800
Subject: [PATCH v3 13/13] ARM: sunxi: Add Kconfig for sunxi clocks
In-Reply-To: <1457192586-25596-14-git-send-email-vishnupatekar0510@gmail.com>
References: <1457192586-25596-1-git-send-email-vishnupatekar0510@gmail.com>
 <1457192586-25596-14-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <CAEzqOZvULNLoyPb__9Tr8qioNQx73i0tz=cXK8EbJYJatdb3xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Mar 5, 2016 at 11:43 PM, Vishnu Patekar
<vishnupatekar0510@gmail.com> wrote:
> This patch adds Kconfig for sunxi clocks.
> Currently, only sun8i-apb0 and sun9i-cpus clocks are added.
> It'll help to use common clocks across different SOCs.
> We can switch to kconfig for other clocks in future.
>
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  drivers/clk/Kconfig        | 1 +
>  drivers/clk/sunxi/Kconfig  | 5 +++++
>  drivers/clk/sunxi/Makefile | 4 ++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clk/sunxi/Kconfig
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index eca8e01..f9f42e6 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -210,3 +210,4 @@ source "drivers/clk/mvebu/Kconfig"
>
>  source "drivers/clk/samsung/Kconfig"
>  source "drivers/clk/tegra/Kconfig"
> +source "drivers/clk/sunxi/Kconfig"
> diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
> new file mode 100644
> index 0000000..afc55c9
> --- /dev/null
> +++ b/drivers/clk/sunxi/Kconfig
> @@ -0,0 +1,5 @@
> +config CLK_SUN8I_APB0
> +       def_bool MACH_SUN9I || MACH_SUN8I_A83T

This should be MACH_SUN8I and not MACH_SUN8I_A83T.

Self NACK for this patch.
> +
> +config CLK_SUN9I_CPUS
> +       def_bool MACH_SUN9I || MACH_SUN8I_A83T
same here

> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index 3fd7901..38dfca8 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -17,8 +17,8 @@ obj-y += clk-sun9i-core.o
>  obj-y += clk-sun9i-mmc.o
>  obj-y += clk-usb.o
>
> -obj-$(CONFIG_MACH_SUN9I) += clk-sun8i-apb0.o
> -obj-$(CONFIG_MACH_SUN9I) += clk-sun9i-cpus.o
> +obj-$(CONFIG_CLK_SUN8I_APB0) += clk-sun8i-apb0.o
> +obj-$(CONFIG_CLK_SUN9I_CPUS) += clk-sun9i-cpus.o
>
>  obj-$(CONFIG_MFD_SUN6I_PRCM) += \
>         clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
> --
> 1.9.1
>
