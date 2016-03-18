From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Mar 2016 15:21:31 +0100
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <20160318081209.GA7394@archy.home> (Romain Perier's message of
 "Fri, 18 Mar 2016 09:12:09 +0100")
References: <20160318081209.GA7394@archy.home>
Message-ID: <87shzn989g.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,
 
 On ven., mars 18 2016, Romain Perier <romain.perier@free-electrons.com> wrote:

> This enables the new driver for Marvell CESA crypto engines on all mvebu v7.
>

Thanks for this patch. Could you select the driver as built-in instead
of module?

For me the main benefit to enable this driver in mvebu_v7_defconfig is
for finding regression during boot tests. It is done by kernelci but as
far as I know they don't load modules. Moreover in my case, most of the
time I use a simple kernel without any modules.

Thanks!

Gregory

> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> index dc5797a..26a8919 100644
> --- a/arch/arm/configs/mvebu_v7_defconfig
> +++ b/arch/arm/configs/mvebu_v7_defconfig
> @@ -155,3 +155,4 @@ CONFIG_MAGIC_SYSRQ=y
>  CONFIG_TIMER_STATS=y
>  # CONFIG_DEBUG_BUGVERBOSE is not set
>  CONFIG_DEBUG_USER=y
> +CONFIG_CRYPTO_DEV_MARVELL_CESA=m
> -- 
> 2.7.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
