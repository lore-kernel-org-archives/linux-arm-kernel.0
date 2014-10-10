From: kever.yang@rock-chips.com (Kever Yang)
Date: Fri, 10 Oct 2014 15:25:13 -0700
Subject: [PATCH 0/2] Fix up rk3288 smp cpu hotplug
Message-ID: <1412979915-19746-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the CA12/CA17 MPCore multiprocessor, the active processors might be
stalled when the individual processor is powered down.
For rk3288, we can avoid this prolbem by softreset the processor before
power it down.


Kever Yang (2):
  ARM: rockchip: fix up rk3288 smp cpu hotplug
  ARM: dts: rockchip: add reset for CPU nodes

 arch/arm/boot/dts/rk3288.dtsi    |  4 ++++
 arch/arm/mach-rockchip/platsmp.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

-- 
1.9.1
