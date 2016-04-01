From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Apr 2016 08:48:02 -0700
Subject: [GIT PULL] enable dm814x and dra62x clock driver for v4.6 merge
 window
In-Reply-To: <20160303231031.GH4469@atomide.com>
References: <20160303231031.GH4469@atomide.com>
Message-ID: <20160401154801.GL9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

* Tony Lindgren <tony@atomide.com> [160303 15:12]:
> The following changes since commit 8a8b6eb7a87f12804f44128d6e4c59b19f224308:
> 
>   clk: ti: Fix some errors found by static checkers (2016-03-01 16:21:25 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/dt-ti81xx-signed
> 
> for you to fetch changes up to 5d7e23a79444385d03717dc19cc58dd2d5883052:
> 
>   ARM: dts: Add clocks for dm814x ADPLL (2016-03-01 17:14:22 -0800)
> 
> ----------------------------------------------------------------
> Enable dm814x and dra62x clock driver. This branch has a dependency
> to the clk-ti branch from the Linux clk tree for the ADPLL clock driver.
> Otherwise things won't keep booting properly when we flip over to use
> the clock driver instead of fixed clocks set up by the bootloader.
> 
> ----------------------------------------------------------------
> Tony Lindgren (1):
>       ARM: dts: Add clocks for dm814x ADPLL
> 
>  arch/arm/boot/dts/dm814x-clocks.dtsi | 243 ++++++++++++++++++++++++++++++-----
>  arch/arm/boot/dts/dra62x-clocks.dtsi |  26 ++++
>  2 files changed, 238 insertions(+), 31 deletions(-)

Looks like this patch is still missing. It has been in Linux next
for close to a month now, and the clock dependency is now merged.
And I believe this fixes booting on hp t410 for some firmware versions.

So it would be good to have this merged during the early -rc cycle.

Regards,

Tony
