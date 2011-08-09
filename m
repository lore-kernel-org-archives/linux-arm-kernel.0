From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 9 Aug 2011 16:35:17 +0530
Subject: [PATCH 0/6] spi/spi-pl022 fixes
Message-ID: <cover.1312887860.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This patchset mainly covers following fixes:
- formatting related issues
- Passing GFP_NOWAIT for sg allocation from tasklet
- Fixing calculate_effective_freq() routine
- Allocate/free DMA channels as and when required.

I have rebased them on linux-next/master over following patch:

commit 9be355da3bae9feb09cdaf80c3ab560f1f0172cb
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Aug 9 13:30:19 2011 +1000

    Add linux-next specific files for 20110809
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Looking forward to see your view on the patchset.

Viresh Kumar (6):
  spi/spi-pl022: Resolve formatting issues
  spi/spi-pl022: Use GFP_NOWAIT for allocation from tasklet
  spi/spi-pl022: Don't allocate more sg than required.
  spi/spi-pl022: calculate_effective_freq() must set rate <= requested
    rate
  spi/spi-pl022: Call pl022_dma_remove(pl022) only if enable_dma is
    true
  spi/spi-pl022: Request/free DMA channels as and when required.

 drivers/spi/spi-pl022.c |  265 ++++++++++++++++++++++++++---------------------
 1 files changed, 147 insertions(+), 118 deletions(-)

-- 
1.7.2.2
