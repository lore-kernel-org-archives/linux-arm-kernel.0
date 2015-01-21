From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Jan 2015 14:55:39 -0800
Subject: [GIT PULL] Renesas ARM Based SoC Sh73a0 Multiplatform Updates
 for v3.20
In-Reply-To: <cover.1421371996.git.horms+renesas@verge.net.au>
References: <cover.1421371996.git.horms+renesas@verge.net.au>
Message-ID: <20150121225539.GF24851@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 11:35:25AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC sh73a0 multiplatform updates for v3.20.
> 
> This pull request is based on a merge of:
> 
> * Renesas ARM Based SoC Drivers Updates for v3.20,
>   tagged as renesas-drivers-for-v3.20, which I have also sent
>   a built request for.
> 
> * "Renesas ARM Based SoC sh73a0 CCF Updates for v3.20",
>   tagged as renesas-sh73a0-ccf-for-v3.20.
> 
> It is my understnding that both of those dependencies are required in
> order to transition to a bootable muliplatform kernel for the kzm9g board.
> 
> 
> This pull request has several minor conflicts with the arm-soc/for-next
> branch:
> 
> * There is a conflict in arch/arm/mach-shmobile/Makefile.boot
>   with the pull-request "Renesas ARM Based SoC Lager Board Removal for
>   v3.20", tagged as renesas-lager-board-removal-for-v3.20, which you have
>   pulled into the next/cleanup branch.
> 
>   A resolution for this conflict is in the renesas-next-20150114-v3.19-rc1
>   tag of my renesas tree.
> 
>   In words the solution is to remove both
>   CONFIG_MACH_KZM9G_REFERENCE and CONFIG_MACH_LAGER.
> 
>   The resulting section of arch/arm/mach-shmobile/Makefile.boot is as follows.
> 
> loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
> loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
> loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
> loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
> loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
> 
> * There is a conflict in arch/arm/boot/dts/Makefile with
>   cb612390e54691863 ("ARM: dts: Only build dtb if associated Arch and/or
>   SoC is enabled").
> 
>   A resolution for this can be found in next-20150115.
> 
>   In words the resolution is to take the formating from cb612390e54691863,
>   and the dtb file removan and addtion from this pull-request.
> 
>   The resulting section of arch/arm/boot/dts/Makefile is as follows.
> 
> 
> dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
>         r8a73a4-ape6evm.dtb \
>         r8a73a4-ape6evm-reference.dtb \
>         r8a7740-armadillo800eva.dtb \
>         r8a7778-bockw.dtb \
>         r8a7778-bockw-reference.dtb \
>         r8a7779-marzen.dtb \
>         sh7372-mackerel.dtb \
>         sh73a0-kzm9g.dtb
> dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
>         emev2-kzm9d.dtb \
>         r7s72100-genmai.dtb \
>         r8a73a4-ape6evm.dtb \
>         r8a7740-.dtb \
>         r8a7779-marzen.dtb \
>         r8a7790-lager.dtb \
>         r8a7791-henninger.dtb \        r8a7791-koelsch.dtb \
>         r8a7794-alt.dtb \
>         sh73a0-kzm9g.dtb
> dtb-$(CONFIG_ARCH_SOCFPGA) += \
>         socfpga_arria5_socdk.dtb \
> 
> * arch/arm/boot/dts/sh73a0-kzm9g-reference.dts should be removed
> 
> 
> 
> The following changes since commit 26bcc66a8b05febf3c4b5ac3365caf23eb103b4f:
> 
>   Merge branch 'drivers-for-v3.20' into sh73a0-multiplatform-for-v3.20.base (2015-01-14 09:39:24 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh73a0-multiplatform-for-v3.20
> 
> for you to fetch changes up to 93c9f0228a3d0a14640f86b3e8aeaf3c9b449bb7:
> 
>   ARM: shmobile: kzm9g-reference: Remove board C code and DT file (2015-01-14 09:46:48 +0900)

Since this is bringing in the drivers/bus branch I can't merge this one either.


-Olof
