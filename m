From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Oct 2013 13:53:54 +0900
Subject: [GIT PULL] Second round of Renesas ARM based SoC cleanups for
 v3.13
In-Reply-To: <cover.1381222967.git.horms+renesas@verge.net.au>
References: <cover.1381222967.git.horms+renesas@verge.net.au>
Message-ID: <20131009045354.GA8369@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 06:05:24PM +0900, Simon Horman wrote:
> Hi Kevin, Olof and Arnd,
> 
> please consider this Second round of Renesas ARM based SoC cleanups for v3.13.
> It is based on renesas-cleanup-for-v3.13 which you have previously pulled.

This pull-request causes some conflicts in
arch/arm/mach-shmobile/board-bockw.c. In general the resolution
strategy should be to take everything.

A sample merge is provided in the renesas-next-20131008 tag
of my renesas tree.

> 
> 
> The following changes since commit cde214a890f81797a5eee94fffc89c1de21ed991:
> 
>   ARM: shmobile: r8a7790: Constify platform data and resources (2013-09-19 14:33:44 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup2-for-v3.13
> 
> for you to fetch changes up to 27113d63daac0aacaa26b1fabfc23391de4284f4:
> 
>   ARM: shmobile: lager: Constify platform data and resources (2013-09-30 16:33:17 +0900)
> 
> ----------------------------------------------------------------
> Second round of Renesas ARM based SoC cleanups for v3.13
> 
> * Constify platform data and resources in lager board code
> * Clean up registration of VIN and sh_eth in r8a7778 SoC and
>    bockw board code
> * Make r8a7778_register_hspi() static in r8a7778 SoC code
> 
> ----------------------------------------------------------------
> Kuninori Morimoto (3):
>       ARM: shmobile: r8a7778: cleanup registration of vin
>       ARM: shmobile: r8a7778: cleanup registration of sh_eth
>       ARM: shmobile: r8a7778: r8a7778_register_hspi() become static
> 
> Laurent Pinchart (1):
>       ARM: shmobile: lager: Constify platform data and resources
> 
>  arch/arm/mach-shmobile/board-bockw.c          | 46 ++++++++++++++++++++----
>  arch/arm/mach-shmobile/board-lager.c          | 14 ++++----
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |  3 --
>  arch/arm/mach-shmobile/setup-r8a7778.c        | 50 +--------------------------
>  4 files changed, 47 insertions(+), 66 deletions(-)
> 
