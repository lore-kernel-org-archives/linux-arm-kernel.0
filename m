From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Feb 2016 15:54:03 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.6
In-Reply-To: <cover.1455303757.git.horms+renesas@verge.net.au>
References: <cover.1455303757.git.horms+renesas@verge.net.au>
Message-ID: <20160217065403.GN11534@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 12, 2016 at 08:06:22PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC updates for v4.6.
> 
> This pull request is based on "Renesas ARM Based SoC Cleanup for v4.6",
> tagged as cleanup-for-v4.6, which you have already pulled.

I would like to withdraw this pull request.

I noticed that there is an error in the base I chose for the pull
request which has resulted in the inclusion of a patch
"ARM: shmobile: Consolidate SCU mapping code", which is already present
in your tree due to another pull request of mine which you have accepted.

I will respin this pull request accordingly.

> The following changes since commit e24f317c859f2d904d1eb87cbb503c309e6dead7:
> 
>   ARM: shmobile: Typo s/MIPDR/MPIDR/ (2016-02-04 15:09:30 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.6
> 
> for you to fetch changes up to 9c9c1320111449c770a51488ca74a5902835e227:
> 
>   ARM: shmobile: emev2: Move declaration of emev2_smp_ops to emev2.h (2016-02-09 21:16:16 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Updates for v4.6
> 
> * Move emev2_smp_ops to emev2
> * Remove legacy map_io callbacks on r8a7740 and emev2 SoCs
> * Clean up SCU mapping code
> * Migrate to generic l2c OF initialization on r8a7740
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (8):
>       ARM: shmobile: r8a7779: Remove remainings of removed SCU boot setup code
>       ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
>       ARM: shmobile: r8a7740: Remove mapping of L2 cache controller registers
>       ARM: shmobile: Move shmobile_scu_base from .text to .data
>       ARM: shmobile: Consolidate SCU mapping code
>       ARM: shmobile: r8a7740: Remove legacy machine_desc.map_io() callback
>       ARM: shmobile: emev2: Remove legacy machine_desc.map_io() callback
>       ARM: shmobile: emev2: Move declaration of emev2_smp_ops to emev2.h
> 
>  arch/arm/mach-shmobile/common.h        |  5 ++---
>  arch/arm/mach-shmobile/emev2.h         |  6 ++++++
>  arch/arm/mach-shmobile/headsmp-scu.S   |  6 ------
>  arch/arm/mach-shmobile/platsmp-scu.c   | 11 ++++++++--
>  arch/arm/mach-shmobile/setup-emev2.c   | 22 ++-----------------
>  arch/arm/mach-shmobile/setup-r8a7740.c | 39 ++--------------------------------
>  arch/arm/mach-shmobile/smp-emev2.c     |  5 +++--
>  arch/arm/mach-shmobile/smp-r8a7779.c   |  5 +----
>  arch/arm/mach-shmobile/smp-sh73a0.c    |  3 +--
>  9 files changed, 26 insertions(+), 76 deletions(-)
>  create mode 100644 arch/arm/mach-shmobile/emev2.h
> 
