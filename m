From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Sat, 1 Mar 2014 19:08:51 +0530
Subject: [PATCH v2 5/5] phy: mvebu-sata: prepare new Dove DT Kconfig
 variable
In-Reply-To: <1393662801-17950-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393662801-17950-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <5311E2EB.70301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 March 2014 02:03 PM, Sebastian Hesselbarth wrote:
> DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> DT-only MACH_DOVE Kconfig.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Kishon,
>
> Mark Brown requested to take the corresponding ASoC patch through
> his tree. Therefore, I have split the former patch into individual subsystem
> patches. This patch also received an update, to not break bisectability
> we add DT-enabled MACH_DOVE and maintain ARCH_DOVE, which is non-DT only
> after conversion. ARCH_DOVE will be removed, when legacy mach-dove will
> be removed.

Cool.. Should this patch be going through PHY tree?

Cheers
Kishon
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>   drivers/phy/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index c7a551c2d5f1..e81daff7b5a3 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -24,7 +24,7 @@ config PHY_EXYNOS_MIPI_VIDEO
>
>   config PHY_MVEBU_SATA
>   	def_bool y
> -	depends on ARCH_KIRKWOOD || ARCH_DOVE
> +	depends on ARCH_KIRKWOOD || ARCH_DOVE || MACH_DOVE
>   	depends on OF
>   	select GENERIC_PHY
>
>
