From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 7 Sep 2012 10:27:14 +0800
Subject: [PATCH 07/12] ARM: move all dtb targets out of Makefile.boot
In-Reply-To: <1346962375-26163-8-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-8-git-send-email-robherring2@gmail.com>
Message-ID: <20120907022711.GE26709@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 03:12:50PM -0500, Rob Herring wrote:
> +dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb
> +dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
> +dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra20-harmony.dtb tegra20-paz00.dtb \
> +	tegra20-seaboard.dtb tegra20-trimslice.dtb tegra20-ventana.dtb \
> +	tegra20-whistler.dtb
> +dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu.dtb
> +dtb-$(CONFIG_BOARD_SPEAR600_DT)	+= spear600-evb.dtb

Replace tab with space?

> +dtb-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-db.dtb armada-xp-db.dtb
> +dtb-$(CONFIG_MACH_AT91SAM_DT) += aks-cdu.dtb at91sam9263ek.dtb \
> +	at91sam9g20ek_2mmc.dtb at91sam9g20ek.dtb at91sam9g25ek.dtb \
> +	at91sam9m10g45ek.dtb at91sam9n12ek.dtb ethernut5.dtb evk-pro3.dtb \
> +	kizbox.dtb tny_a9260.dtb tny_a9263.dtb tny_a9g20.dtb usb_a9260.dtb \
> +	usb_a9263.dtb usb_a9g20.dtb
> +dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns320.dtb kirkwood-dns325.dtb
> +dtb-$(CONFIG_MACH_DREAMPLUG_DT) += kirkwood-dreamplug.dtb
> +dtb-$(CONFIG_MACH_EXYNOS4_DT) += exynos4210-origen.dtb exynos4210-smdkv310.dtb
> +dtb-$(CONFIG_MACH_EXYNOS5_DT) += exynos5250-smdk5250.dtb
> +dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
> +dtb-$(CONFIG_MACH_IB62X0_DT) += kirkwood-ib62x0.dtb
> +dtb-$(CONFIG_MACH_ICONNECT_DT) += kirkwood-iconnect.dtb
> +dtb-$(CONFIG_MACH_IMX51_DT) += imx51-babbage.dtb
> +dtb-$(CONFIG_MACH_IMX53_DT) += imx53-ard.dtb imx53-evk.dtb \
> +	imx53-qsb.dtb imx53-smd.dtb
> +dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
> +dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
> +dtb-$(CONFIG_MACH_SNOWBALL) += snowball.dtb
> +dtb-$(CONFIG_MACH_SPEAR1310) += spear1310-evb.dtb
> +dtb-$(CONFIG_MACH_SPEAR1340) += spear1340-evb.dtb
> +dtb-$(CONFIG_MACH_SPEAR300) += spear300-evb.dtb
> +dtb-$(CONFIG_MACH_SPEAR310) += spear310-evb.dtb
> +dtb-$(CONFIG_MACH_SPEAR320) += spear320-evb.dtb
> +dtb-$(CONFIG_MACH_TS219_DT) += kirkwood-ts219-6281.dtb kirkwood-ts219-6282.dtb
> +dtb-$(CONFIG_SOC_IMX6Q)	+= imx6q-arm2.dtb imx6q-sabrelite.dtb \

Ditto

> +			   imx6q-sabresd.dtb

This does not follow the indention pattern.

> +dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb imx23-olinuxino.dtb \
> +	 imx23-stmp378x_devb.dtb imx28-apx4devkit.dtb \
> +	 imx28-cfa10036.dtb imx28-evk.dtb \
> +	 imx28-m28evk.dtb imx28-tx28.dtb

Ditto

> +dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb \
> +	   vexpress-v2p-ca9.dtb vexpress-v2p-ca15-tc1.dtb \
> +	   vexpress-v2p-ca15_a7.dtb

Ditto

CONFIG_ARCH_MXS and CONFIG_ARCH_VEXPRESS entries are not well sorted.
They should be in the CONFIG_ARCH_* section.

Otherwise,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

PS. A little heads-up: if this lands on 3.7, there will be conflict
on arch/arm/mach-mxs/Makefile.boot which gets new entries in this
cycle.

-- 
Regards,
Shawn
