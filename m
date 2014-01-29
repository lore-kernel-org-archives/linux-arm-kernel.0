From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Wed, 29 Jan 2014 17:24:05 +0100
Subject: [PATCH 0/3] CCF clock divider changes
Message-ID: <1391012648-12481-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

First patch fixes round_rate for power-of-two and table-based dividers when
the CLK_SET_RATE_PARENT flag isn't set.

Second patch introduces a new flag to give the possibility to round the
divider to the closest one, instead of rounding up by default.

Third patch optimizes the for-loop when CLK_SET_RATE_PARENT is set for
power-of-two and table-based dividers.

The series applies on top of v3.13 tag.

Maxime Coquelin (3):
  clk: divider: Fix best div calculation for power-of-two and table
    dividers
  clk: divider: Add round to closest divider
  clk: divider: Optimize clk_divider_bestdiv loop

 drivers/clk/clk-divider.c    |  118 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/clk-provider.h |    3 ++
 2 files changed, 118 insertions(+), 3 deletions(-)

-- 
1.7.9.5
