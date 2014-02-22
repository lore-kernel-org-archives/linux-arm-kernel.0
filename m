From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Feb 2014 16:36:41 -0800
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.15
In-Reply-To: <20140218164639.GX7862@titan.lakedaemon.net>
References: <20140218164639.GX7862@titan.lakedaemon.net>
Message-ID: <20140222003641.GF13233@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 11:46:39AM -0500, Jason Cooper wrote:
> All,
> 
> Heads up!  This branch changes the name of mvebu_defconfig to
> mvebu_v7_defconfig to make room for kirkwood (mvebu_v5) in mach-mvebu/.
> Olof and Kevin's build/boot farm will need to be tweaked.  I did warn
> about this :)
> 
> Other than that, pretty quiet.
> 
> Since these are defconfig changes, and oldconfig will remove unused
> symbols, I've gone ahead and sent the whole branch, including the
> changes for the new Armada 375 and 38x SoCs.
> 
> Please pull.
> 
> thx,
> 
> Jason.
> 
> 
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.15
> 
> for you to fetch changes up to dd1d03afe8a0825d718f5d74225ad57978599a89:
> 
>   ARM: mvebu: update defconfigs for Armada 375 and 38x (2014-02-17 22:48:39 +0000)
> 
> ----------------------------------------------------------------
> mvebu defconfig changes for v3.15
> 
>  - dove
>     - remove UBI support
>     - enable watchdog
> 
>  - mvebu
>     - rename mvebu_defconfig mvebu_v7_defconfig
>     - enable audio
>     - enable watchdog
>     - add Armada 375 and 38x
> 
> ----------------------------------------------------------------
> Ezequiel Garcia (3):
>       ARM: dove: Remove UBI support from defconfig
>       ARM: mvebu: Enable watchdog support in defconfig
>       ARM: dove: Enable watchdog support in the defconfig
> 
> Thomas Petazzoni (3):
>       ARM: mvebu: rename mvebu_defconfig to mvebu_v7_defconfig
>       ARM: mvebu: enable audio options in mvebu_defconfig
>       ARM: mvebu: update defconfigs for Armada 375 and 38x
> 
>  arch/arm/configs/dove_defconfig                          | 3 ++-
>  arch/arm/configs/multi_v7_defconfig                      | 4 ++++
>  arch/arm/configs/{mvebu_defconfig => mvebu_v7_defconfig} | 9 +++++++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
>  rename arch/arm/configs/{mvebu_defconfig => mvebu_v7_defconfig} (91%)

Jason,

multi_v7_defconfig updates get messy, and we ask that people send them as
patches instead of in branches. Still, in this case it's a whole branch of just
defconfig updates so I think we'll be OK. Be mindful of it in the future
though, please.

Branch has been merged into next/boards.


-Olof
