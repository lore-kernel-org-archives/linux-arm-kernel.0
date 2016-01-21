From: emilio.lopez@collabora.co.uk (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Thu, 21 Jan 2016 11:10:37 -0300
Subject: [PATCH 0/2] defer clk_gets on orphan clocks
Message-ID: <1453385439-10154-1-git-send-email-emilio.lopez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is mostly a resend of Heiko's patch from [0] together with a fix for
the breakage seen on sunxi when it was applied.

Ideally we would move off our own protected clocks thing to the CCF
implementation when it is merged and solve this nicely. Meanwhile, we
can solve this non-intrusively by delaying the clock protection a bit.
This way the rk people can enjoy the happiness brought by working sensors
and WiFi[1] while sunxi boards still boot and operate just fine.

I have tested this on a Cubieboard 1 (A10) and A10S OLinuXino Micro (A10S)
as well as remotely boot-tested a Radxa Rock2 Square (rk3288)

As always, all comments welcome :)

Thanks!
Emilio

[0] http://www.spinics.net/lists/arm-kernel/msg462821.html
[1] http://www.spinics.net/lists/arm-kernel/msg473236.html

Emilio L?pez (1):
  clk: sunxi: delay protected clocks until arch initcall

Heiko Stuebner (1):
  clk: defer clk_gets on orphan clocks

 drivers/clk/clk-conf.c        |  5 +++--
 drivers/clk/clk.c             | 48 ++++++++++++++++++++++++++++++++++---------
 drivers/clk/clk.h             | 10 ++++++---
 drivers/clk/clkdev.c          |  4 ++--
 drivers/clk/sunxi/clk-sunxi.c | 22 ++++++++++++++++----
 5 files changed, 68 insertions(+), 21 deletions(-)

-- 
2.7.0
