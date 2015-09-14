From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 14 Sep 2015 14:47:43 +0800
Subject: [PATCH RESEND 0/2] arm: berlin: add cpu hotplug support
Message-ID: <1442213265-1002-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches try to add cpu hotplug support for Marvell BG2, BG2Q SoCs.
These SoCs can't power off cpu independently, but we still want cpu hotplug
support for them. However, we need to address "CPU still sat on kernel text"
as pointed out by Mark Rutland[1]. We achieved this by putting the dying CPU
in WFI state after the coherency is disabled, then asserting the dying CPU
reset bit to put the CPU in reset state.

patch1 use non-self-cleared control register to reset cpu. This is to prepare
for the next cpu hotplug commit.

patch2 adds the cpu hotplug support finally.


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/342642.html


Jisheng Zhang (2):
  arm: berlin: use non-self-cleared reset register to reset cpu
  arm: berlin: add CPU hotplug support

 arch/arm/mach-berlin/platsmp.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

-- 
2.5.1
