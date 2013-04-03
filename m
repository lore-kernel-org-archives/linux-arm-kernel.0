From: horms@verge.net.au (Simon Horman)
Date: Wed, 3 Apr 2013 10:36:04 +0900
Subject: Renesas ARM SoC board updates for v3.10 #3
In-Reply-To: <1364879483-11144-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879483-11144-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130403013604.GA7202@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Olof pointed out that there are some attribution problems in
renesas-pinmux2-for-v3.10. I will resolve them, rebase and re-send
this pull request (renesas-boards3-for-v3.10).

On Tue, Apr 02, 2013 at 02:11:12PM +0900, Simon Horman wrote:
> Hi Arnd, Hi Olof,
> 
> The following changes since commit df16da03fc60fcfbc7f4b0cb849f9c1fc956a991:
> 
>   Merge branch 'pinmux' into boards-base (2013-04-02 13:21:54 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards3-for-v3.10
> 
> for you to fetch changes up to b9a2f94954622b8fab222b1029fbfcdbed558b44:
> 
>   ARM: shmobile: mackerel: clean up MMCIF vs. SDHI1 selection (2013-04-02 13:22:54 +0900)
> 
> ----------------------------------------------------------------
> Third round of  Renesas ARM SoC board updates for v3.10
> 
> Highlights:
> 
> * Add Lager board support
> * Add ape6evm board support
> * Add Bock-W board support
> * Mackerel MMCIF/SDHI clean ups
> * Add ethernet support to kzm9g-reference
> 
> This pull request is based on a merge of:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-pinmux2-for-v3.10
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-boards2-for-v3.10
> 
> ----------------------------------------------------------------
> Guennadi Liakhovetski (6):
>       ARM: shmobile: kzm9g-reference: add ethernet support
>       ARM: shmobile: mackerel: SDHI resources do not have to be numbered
>       ARM: shmobile: mackerel: remove OCR masks, where regulators are used
>       ARM: shmobile: mackerel: switch SDHI and MMCIF interfaces to slot-gpio
>       ARM: shmobile: mackerel: add interrupt names for SDHI0
>       ARM: shmobile: mackerel: clean up MMCIF vs. SDHI1 selection
> 
> Kuninori Morimoto (1):
>       ARM: shmobile: add R-Car M1A Bock-W platform support
> 
> Magnus Damm (4):
>       ARM: shmobile: APE6EVM base support
>       ARM: shmobile: APE6EVM PFC support
>       ARM: shmobile: APE6EVM LAN9220 support
>       ARM: shmobile: Initial r8a7790 Lager board support
> 
>  arch/arm/boot/dts/Makefile                   |    3 +
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts        |   52 ++++++++++++
>  arch/arm/boot/dts/r8a7778-bockw.dts          |   32 ++++++++
>  arch/arm/boot/dts/r8a7790-lager.dts          |   31 +++++++
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   13 +++
>  arch/arm/configs/bockw_defconfig             |   66 +++++++++++++++
>  arch/arm/mach-shmobile/Kconfig               |   21 ++++-
>  arch/arm/mach-shmobile/Makefile              |    3 +
>  arch/arm/mach-shmobile/board-ape6evm.c       |   94 ++++++++++++++++++++++
>  arch/arm/mach-shmobile/board-bockw.c         |   43 ++++++++++
>  arch/arm/mach-shmobile/board-lager.c         |   46 +++++++++++
>  arch/arm/mach-shmobile/board-mackerel.c      |  111 ++++++++++----------------
>  12 files changed, 443 insertions(+), 72 deletions(-)
>  create mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm.dts
>  create mode 100644 arch/arm/boot/dts/r8a7778-bockw.dts
>  create mode 100644 arch/arm/boot/dts/r8a7790-lager.dts
>  create mode 100644 arch/arm/configs/bockw_defconfig
>  create mode 100644 arch/arm/mach-shmobile/board-ape6evm.c
>  create mode 100644 arch/arm/mach-shmobile/board-bockw.c
>  create mode 100644 arch/arm/mach-shmobile/board-lager.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
