From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Aug 2012 16:31:25 +0200
Subject: [PATCH 11/11] arm: mvebu: add pinctrl support in defconfig
In-Reply-To: <1344689809-6223-12-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-12-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdaF3OuBLC7odWyH5C_EJT9uFq1rYQMh6=kr8PQjvA68sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 2:56 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
> index 2e86b31..cb07e64 100644
> --- a/arch/arm/configs/mvebu_defconfig
> +++ b/arch/arm/configs/mvebu_defconfig
> @@ -21,6 +21,8 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_PINCTRL_ARMADA_370=y
> +CONFIG_PINCTRL_ARMADA_XP=y

If the system is not even booting without pinctrl you should
(IMHO) select these from the machine's Kconfig entry insteaf.

If they boot fine without I'm fine with this ... the arch maintainer
gets to choose anyway.

Yours,
Linus Walleij
