From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 02 Jul 2014 10:13:23 -0700
Subject: [GIT PULL] Samsung clock fixes for v3.16
In-Reply-To: <1404319926-6178-1-git-send-email-t.figa@samsung.com>
References: <1404319926-6178-1-git-send-email-t.figa@samsung.com>
Message-ID: <20140702171323.7440.76631@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tomasz Figa (2014-07-02 09:52:06)
> The following changes since commit b640a6037c9ecd1f0ad23a8e9b4ca5f5b4112508:
> 
>   Merge tag 'sunxi-clk-for-3.16-2' of https://github.com/mripard/linux into clk-next (2014-06-11 07:11:59 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tfiga/samsung-clk.git tags/for_3.16/samsung-clk-fixes
> 
> for you to fetch changes up to 44ff0254b89079a8a95e652635e760d93196ac1f:
> 
>   clk: exynos5420: Remove aclk66_peric from the clock tree description (2014-06-30 14:47:33 +0200)

Pulled into clk-fixes. Thanks for the great tag description as well.

Regards,
Mike

> 
> ----------------------------------------------------------------
> Samsung clock fixes for v3.16.
> 
> This pull request contains fixes for various issues found while testing
> -rc versions of Linux 3.16. Mostly two kinds of patches:
> 
> * Fixes of incorrectly defined clocks
> 
> 1) a37c82a clk: samsung: exynos4: Remove SRC_MASK_ISP gates
> 
>     Issue present since v3.10.
> 
> 2) 0b1643b clk/exynos5250: fix bit number for tv sysmmu clock
> 
>     Issue present since v3.16.
> 
> 3) 44ff025 clk: exynos5420: Remove aclk66_peric from the clock tree description
> 
>     Issue present since v3.11.
> 
> * Adding things missed by original patches
> 
> 1) cec1cde clk: samsung: fix several typos to fix boot on s3c2410
> 2) 34ece9e clk: samsung: add more aliases for s3c24xx
> 
>     Both issues present since the driver was added in v3.16.
> 
> 3) a92dda4 clk: s3c64xx: Hookup SPI clocks correctly
> 
>     Issue present since v3.12.
> 
> ----------------------------------------------------------------
> Charles Keepax (1):
>       clk: s3c64xx: Hookup SPI clocks correctly
> 
> Doug Anderson (1):
>       clk: exynos5420: Remove aclk66_peric from the clock tree description
> 
> Rahul Sharma (1):
>       clk/exynos5250: fix bit number for tv sysmmu clock
> 
> Tomasz Figa (1):
>       clk: samsung: exynos4: Remove SRC_MASK_ISP gates
> 
> Vasily Khoruzhick (2):
>       clk: samsung: fix several typos to fix boot on s3c2410
>       clk: samsung: add more aliases for s3c24xx
> 
>  drivers/clk/samsung/clk-exynos4.c      | 16 ++-----
>  drivers/clk/samsung/clk-exynos5250.c   |  2 +-
>  drivers/clk/samsung/clk-exynos5420.c   | 85 ++++++++++++++++++++++------------
>  drivers/clk/samsung/clk-s3c2410.c      |  9 +++-
>  drivers/clk/samsung/clk-s3c64xx.c      |  6 ++-
>  include/dt-bindings/clock/exynos5420.h |  1 -
>  6 files changed, 71 insertions(+), 48 deletions(-)
