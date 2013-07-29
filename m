From: a0393675@ti.com (Keerthy)
Date: Mon, 29 Jul 2013 15:27:08 +0530
Subject: [PATCH 0/9] ARM: dts: omap5-uevm: fixup wrong regulator
 configuration
In-Reply-To: <1374079538-19548-1-git-send-email-nm@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
Message-ID: <51F63C74.6070503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

On Wednesday 17 July 2013 10:15 PM, Nishanth Menon wrote:
> Due to wrong older revision of documentation used as reference, we
> seem to have a bunch of LDOs wrongly configured on OMAP5 uEVM. This
> series is based power tree on production board 750-2628-XXX platform.
> Unfortunately, the wrong voltages may be detrimental to OMAP5 as they
> supply hardware blocks at voltages that are out of specification.

This series looks good to me.

Acked-by:  J Keerthy <j-keerthy@ti.com>
> Also available at:
> based on v3.11-rc1 tag
> http link: https://github.com/nmenon/linux-2.6-playground/commits/push/omap5-palmas-fixes
> git link: git://github.com/nmenon/linux-2.6-playground.git
> branch: push/omap5-palmas-fixes
>
> Tested with https://patchwork.kernel.org/patch/2545061/
>   + https://git.kernel.org/cgit/linux/kernel/git/ssantosh/linux.git/log/?h=for_3.11/out_of_tree/omap5_clk_data
> Test result: http://pastebin.com/YqASYkXG
>
> Relevant documentation:
> - OMAP5 uEVM documentation: https://www.svtronics.com/omap/omap54xx?product_id=33
> - OMAP5432 Data Manual: http://www.ti.com/product/OMAP5432
> - TWL6037 / OTP information: Currently available only under NDA
>
> Nishanth Menon (9):
>    ARM: dts: omap5-uevm: document regulator signals used on the actual
>      board
>    ARM: dts: omap5-uevm: update SMPS9 settings
>    ARM: dts: omap5-uevm: update and disable unused regulators LDO[28]
>    ARM: dts: omap5-uevm: update LDO1 voltage to 1.5V and settings
>    ARM: dts: omap5-uevm: update LDO3 voltage to 1.5V and settings
>    ARM: dts: omap5-uevm: update LDO4 voltage to 1.5V and settings
>    ARM: dts: omap5-uevm: update LDO6 voltage to 1.2V
>    ARM: dts: omap5-uevm: update LDO7 voltage to 2V and settings
>    ARM: dts: omap5-uevm: update SDCARD LDO9 and resource REGEN3
>
>   arch/arm/boot/dts/omap5-uevm.dts |   78 ++++++++++++++++++++++++--------------
>   1 file changed, 49 insertions(+), 29 deletions(-)
>
Regards,
Keerthy
