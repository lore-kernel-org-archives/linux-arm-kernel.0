From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 27 Jan 2013 11:40:21 +0100
Subject: [PATCH v2 0/2] Do not gate ge0/1 and runit clocks on Kirkwood
Message-ID: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

kernel 3.8-rc5 will hang on kirkwood DT if the Ethernet driver is built
as a module or when no driver claiming the runit clock is built in. 
(Usually, at least the serial driver is built in, but it won't request
the clock if "clock-frequency" is given in DT.) In the past, we fixed
this by keeping the clocks ticking.

These two patches re-enable the ethernet fix for DT and declare the
"runit" clock as not to gated even if unused.

Changes:

v2:

- Do not turn on ge[01] clocks unconditionally. Instead, fix the
  previous way we handled this on kirkwood.



Simon Baatz (2):
  ARM: kirkwood: Ensure that kirkwood_ge0[01]_init() finds its clock
  clk: mvebu: Do not gate runit clock on Kirkwood

 arch/arm/mach-kirkwood/common.c     |   13 +++++++++----
 drivers/clk/mvebu/clk-gating-ctrl.c |    5 ++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
1.7.9.5
