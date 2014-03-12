From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 12 Mar 2014 12:41:40 -0300
Subject: [PATCH 0/1] clk: mvebu: Core Divider fix for v3.15-rc1
Message-ID: <1394638901-13368-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Jason:

While working on the Core Divider clock for A380, I spotted a small
bug introduced during the Armada 375 core divider clock submission.

The clock ratio register offset is set at 0x8, but the correct value
for this SoC is 0x4.

It's a tiny fix, but given v3.15-rc1 is just around the corner,
I think we can prepare it to be pushed for v3.15-rc2.

Thanks!

Ezequiel Garcia (1):
  clk: mvebu: Fix ratio register offset on A375 SoC

 drivers/clk/mvebu/clk-corediv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.9.0
