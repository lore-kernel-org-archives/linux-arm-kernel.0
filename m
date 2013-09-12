From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 12 Sep 2013 09:50:38 -0700
Subject: [PATCH 0/2] arm: zynq: Enable global timer
Message-ID: <1379004640-15117-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm sitting on this for a while and was waiting for Stephen's patch to
get merged somewhere. Unfortunately that didn't happen yet.
The patch to enable the global timer is pretty straight forward.
Stephen's patch is the result of this thread: https://lkml.org/lkml/2013/7/22/649
and required to prevent the global_timer from becoming the broadcast
device, since the system will hang otherwise.

Soren Brinkmann (1):
  arm: zynq: Enable arm_global_timer

Stephen Boyd (1):
  tick: broadcast: Deny per-cpu clockevents from being broadcast sources

 arch/arm/boot/dts/zynq-7000.dtsi | 8 ++++++++
 arch/arm/mach-zynq/Kconfig       | 1 +
 kernel/time/tick-broadcast.c     | 3 +++
 3 files changed, 12 insertions(+)

-- 
1.8.4
