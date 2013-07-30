From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 30 Jul 2013 14:08:14 -0700
Subject: [PATCH v4 0/6] clk/exynos5250: add clocks for hdmi subsystem
In-Reply-To: <1374728857-4208-1-git-send-email-rahul.sharma@samsung.com>
References: <1374728857-4208-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <20130730210814.5270.44742@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rahul Sharma (2013-07-24 22:07:31)
> Add clock changes for hdmi subsystem for exynos5250 SoC. These
> include addition of new clocks like mout_hdmi and smmu_tv, associating
> ID to clk_hdmiphy and some essential corrections.
> 
> This set is based on kukjin's for-next branch at
> http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git.

I've taken patches 2-4 into the clk-next branch. Patch #1 can be
dropped.

Patches 5 & 6 need to be rebased onto clk-next as the g2d clock has
reserved mapping 345.  Also I've cc'd Cho KyongHo who is rebasing his
system mmu clock patch[1] onto clk-next. Can the two of your coordinate
your changes to avoid mapping conflicts in the binding? Perhaps Rahul
can carry Cho's patch in his next version when he rebases patches 5 & 6.

Thanks,
Mike

[1] https://lkml.org/lkml/2013/7/30/51

> 
> V4:
> 1) Added Arun's patch hdmi clock number correction in this series.
> 2) Corrected clock number for smmu_mixer
> 
> V3:
> 1) Rebase to kgene for-next based on 3.11-rc1.
> 2) Added Tushar's patch in the series.
> 
> V2:
> 1) Dropped "clk/exynos5250: Fix HDMI clock number in documentation" as
> it already get merged.
> 
> Arun Kumar K (1):
>   clk/exynos5250: Fix HDMI clock number in documentation
> 
> Rahul Sharma (4):
>   clk/exynos5250: add mout_hdmi mux clock for hdmi
>   clk/exynos5250: add sclk_hdmiphy in the list of special clocks
>   clk/exynos5250: add clock for mixer sysmmu
>   clk/exynos5250: change parent to aclk200_disp1 for hdmi subsystem
> 
> Tushar Behera (1):
>   Documentation: exynos5250-clock: Add div_i2s1 and div_i2s2
> 
>  .../devicetree/bindings/clock/exynos5250-clock.txt |   14 +++++++++++++-
>  drivers/clk/samsung/clk-exynos5250.c               |   20 ++++++++++++++------
>  2 files changed, 27 insertions(+), 7 deletions(-)
> 
> -- 
> 1.7.10.4
