From: olof@lixom.net (Olof Johansson)
Date: Mon, 4 Feb 2013 23:10:10 -0800
Subject: [GIT PULL  3/4] ARM: mvebu: boards for v3.9
In-Reply-To: <1359733919.c3D01c3.22262@triton>
References: <pull-1359733919-342140>
 <1359733919.c3D01c3.22262@triton>
Message-ID: <20130205071010.GD13049@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 01, 2013 at 03:51:59PM +0000, Jason Cooper wrote:
> The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:
> 
>   Linux 3.8-rc5
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/boards_for_v3.9
> 
> for you to fetch changes up to c7064904895f69b2e33117b450a05746f75abf3a:
> 
>   ARM: kirkwood: convert Guruplug Server Plus to use the device tree
> 
> ----------------------------------------------------------------
> mvebu boards for v3.9
>      - Guruplug Server Plus DT board
>      - RD-A370-A1 board
>      - mvebu improved SMP support in interrupt controller
>      - update defconfigs
>      - split legacy and DT setup for dove
>      - remove some redundant clock aliases
>     
>     depends on:
>      - tags/mvebu_fixes_for_v3.8-rc6
>      - tags/cleanup_for_v3.9_round2
>      - tags/drivers_for_v3.9
>      - mmc/mmc-next up to:
>         d293875 mmc: mvsdio: add pinctrl integration

Hm. What do you need the mmc branch for? Is it just the removal of the
redundant SDIO clock alias?

If so, I'd say let's keep that as a cleanup until 3.10 instead of bringing this
in as a dependency. If it's something more substantial than that, then let me
know and we'll still pull this in.

Also, it's really hard to tell where code came from when you just merge in
a hash like below:

> Jason Cooper (4):
>       Merge tag 'tags/mvebu_fixes_for_v3.8-rc6' into mvebu/boards
>       Merge tag 'tags/cleanup_for_v3.9_round2' into mvebu/boards
>       Merge tag 'tags/drivers_for_v3.9' into mvebu/boards
>       Merge commit 'd293875' into mvebu/boards

That's the mmc-next branch at that commit, but it'd be nice to have a
more descriptive summary in the shortlog.


-Olof
