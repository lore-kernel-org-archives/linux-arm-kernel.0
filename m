From: emil@limesaudio.com (Emil Lundmark)
Date: Mon, 10 Oct 2016 12:03:04 +0200
Subject: [PATCH v2 0/2] clk: imx: fix AV PLL rate setting
Message-ID: <cover.1476092427.git.emil@limesaudio.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I did not use a cover letter in v1, so here is a summary instead.

I discovered a problem when trying to set the rate of the audio PLL
(pll4_post_div) on an i.MX6Q. The rate I wanted to set was 196.608 MHz, but
the actual rate I got was 192.000570 MHz. This patch series fixes this
issue and also improves the precision of the audio/video PLL.

There are no code changes in v2, only clarifications in the commit
messages.

Changes since v1:
- Use correct subsystem name in commit summary.
- Use 'Fixes:' tag to indicate bug fix.
- Revise argument for choosing the denominator register value after
  comments from Lothar Wa?mann.

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/460350.html

Emil Lundmark (2):
  clk: imx: fix integer overflow in AV PLL round rate
  clk: imx: improve precision of AV PLL to 1 Hz

 drivers/clk/imx/clk-pllv3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.7.4
