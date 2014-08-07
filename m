From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 7 Aug 2014 23:36:10 +0200
Subject: [PATCH v2 00/12] defconfigs: add MTD_SPI_NOR (new subsystem
 dependency for M25P80)
In-Reply-To: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
References: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <CAMuHMdVZmJR=Cu1Wvpyx+KqgdKRRtnAO94k4imXChUwfC_GPTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Thu, May 1, 2014 at 8:26 AM, Brian Norris
<computersforpeace@gmail.com> wrote:
> v1 --> v2: split ARM defconfig changes into their sub-architectures. No change
>            in the overall diff.
>
> Hi all,
>
> We are introducing a new SPI-NOR subsystem/framework for MTD, to support
> various types of SPI-NOR flash controllers which require (or benefit from)
> intimate knowledge of the flash interface, rather than just the relatively dumb
> SPI interface. This framework borrows much of the m25p80 driver for its
> abstraction and moves this code into a spi-nor module.
>
> This means CONFIG_M25P80 now has a dependency on CONFIG_MTD_SPI_NOR, which
> should be added to the defconfigs. I expect that each (sub)architecture
> maintainer can merge these patches to their own tree.
>
> Note that without the new CONFIG_MTD_SPI_NOR symbol in your defconfig, Kconfig
> will automatically drop M25P80 for you.
>
> Please keep general comments to the cover letter, so all parties can see.
>
> This series is based on 3.15-rc1.
>
> The SPI-NOR development code (in -next, queued for 3.16) is here:
>
>   git://git.infradead.org/l2-mtd.git +spinor
>
> This defconfig series is available in the same repo at:
>
>   git://git.infradead.org/l2-mtd.git +defconfigs
>
> Thanks,
> Brian
>
> Brian Norris (12):
>   ARM: imx/mxs defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: keystone: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: tegra: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: lpc32xx: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: at91: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: shmobile: add MTD_SPI_NOR (new dependency for M25P80)
>   ARM: marvell: add MTD_SPI_NOR (new dependency for M25P80)
>   blackfin: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
>   mips: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
>   powerpc: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
>   sh: defconfig: add MTD_SPI_NOR (new dependency for M25P80)
>
>  arch/arm/configs/bockw_defconfig               | 2 +-
>  arch/arm/configs/dove_defconfig                | 2 +-
>  arch/arm/configs/imx_v6_v7_defconfig           | 1 +
>  arch/arm/configs/keystone_defconfig            | 1 +
>  arch/arm/configs/kirkwood_defconfig            | 1 +
>  arch/arm/configs/koelsch_defconfig             | 1 +
>  arch/arm/configs/lager_defconfig               | 1 +
>  arch/arm/configs/lpc32xx_defconfig             | 2 +-
>  arch/arm/configs/multi_v5_defconfig            | 1 +
>  arch/arm/configs/multi_v7_defconfig            | 1 +
>  arch/arm/configs/mvebu_v5_defconfig            | 1 +
>  arch/arm/configs/mvebu_v7_defconfig            | 1 +
>  arch/arm/configs/mxs_defconfig                 | 1 +
>  arch/arm/configs/sama5_defconfig               | 2 +-
>  arch/arm/configs/shmobile_defconfig            | 1 +
>  arch/arm/configs/tegra_defconfig               | 1 +
>  arch/blackfin/configs/BF526-EZBRD_defconfig    | 2 +-
>  arch/blackfin/configs/BF527-EZKIT-V2_defconfig | 2 +-
>  arch/blackfin/configs/BF527-EZKIT_defconfig    | 2 +-
>  arch/blackfin/configs/BF548-EZKIT_defconfig    | 2 +-
>  arch/blackfin/configs/BF609-EZKIT_defconfig    | 2 +-
>  arch/blackfin/configs/BlackStamp_defconfig     | 3 +--
>  arch/blackfin/configs/H8606_defconfig          | 3 +--
>  arch/mips/configs/ath79_defconfig              | 3 +--
>  arch/mips/configs/db1xxx_defconfig             | 1 +
>  arch/mips/configs/rt305x_defconfig             | 2 +-
>  arch/powerpc/configs/corenet32_smp_defconfig   | 2 +-
>  arch/powerpc/configs/corenet64_smp_defconfig   | 2 +-
>  arch/powerpc/configs/mpc85xx_defconfig         | 2 +-
>  arch/powerpc/configs/mpc85xx_smp_defconfig     | 2 +-
>  arch/sh/configs/sh7757lcr_defconfig            | 2 +-
>  31 files changed, 31 insertions(+), 21 deletions(-)

FWIW, this change still hasn't propagated to the following defconfigs:

arch/arm/configs/axm55xx_defconfig
arch/arm/configs/bockw_defconfig
arch/arm/configs/koelsch_defconfig
arch/arm/configs/lager_defconfig
arch/arm/configs/lpc32xx_defconfig
arch/arm/configs/multi_v5_defconfig
arch/arm/configs/multi_v7_defconfig
arch/arm/configs/qcom_defconfig
arch/arm/configs/sama5_defconfig
arch/arm/configs/shmobile_defconfig
arch/powerpc/configs/85xx/kmp204x_defconfig
arch/powerpc/configs/corenet32_smp_defconfig
arch/powerpc/configs/corenet64_smp_defconfig
arch/powerpc/configs/mpc85xx_defconfig
arch/powerpc/configs/mpc85xx_smp_defconfig
arch/sh/configs/sh7757lcr_defconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
