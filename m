From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 10 Aug 2011 14:20:53 +0530
Subject: [PATCH V2 0/6] spi/spi-pl022 fixes
Message-ID: <cover.1312965741.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

I have added Tested-by: Linus Walleij <linus.walleij@linaro.org> on all patches.

This patchset mainly covers following fixes:
- formatting related issues
- Passing GFP_ATOMIC for sg allocation from tasklet
- Fixing calculate_effective_freq() routine
- Allocate/free DMA channels as and when required.

Changes since V1:
- Replace GFP_NOWAIT with GFP_ATOMIC
- Wrote inline routine spi_rate instead of macro

Viresh Kumar (6):
  spi/spi-pl022: Resolve formatting issues
  spi/spi-pl022: Use GFP_ATOMIC for allocation from tasklet
  spi/spi-pl022: Don't allocate more sg than required.
  spi/spi-pl022: calculate_effective_freq() must set rate <= requested
    rate
  spi/spi-pl022: Call pl022_dma_remove(pl022) only if enable_dma is
    true
  spi/spi-pl022: Request/free DMA channels as and when required.

 drivers/spi/spi-pl022.c |  269 ++++++++++++++++++++++++++---------------------
 1 files changed, 151 insertions(+), 118 deletions(-)

-- 
1.7.2.2
