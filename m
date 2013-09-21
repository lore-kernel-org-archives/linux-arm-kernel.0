From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Fri, 20 Sep 2013 22:03:09 -0300
Subject: [PATCH 0/3] sunxi clock fixes
Message-ID: <1379725392-30202-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This small series contains two bug fixes and a patch to solve the issue
of accidental clock gating, as discussed earlier on my RFC patch, "of: 
add a basic memory driver".

I believe the two first patches should go into -rcN, although I have not
noticed any issues so far coming from the bugs themselves.

The third patch should be a no-op for now, and I'd like to have it
merged before these clocks actually appear on the driver; in this way
they will never be gated accidentally, and it remains bisectable. I will 
be sending PLL5/6 support patches in short order.

Cheers,

Emilio

Emilio L?pez (3):
  clk: sunxi: factors: fix off-by-one masks
  clk: sunxi: factors: clear variables before using them
  clk: sunxi: protect core clocks from accidental shutdown

 drivers/clk/sunxi/clk-factors.c |  4 ++--
 drivers/clk/sunxi/clk-sunxi.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

-- 
1.8.4
