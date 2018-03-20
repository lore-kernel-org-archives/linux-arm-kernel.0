From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 20 Mar 2018 16:48:49 +0800
Subject: Failed to boot ARM64 boards for recent linux-next
Message-ID: <dae4b3b8-3da4-4a86-ac4a-0631802fa546@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

     I was able to boot my RK3399 board with in linux-next-20180314,
but not today. My bisect robot shows me it was introduced by

commit d6062a6d62c643a06c393745d032da3e6441d4bd
Author: Marc Zyngier <marc.zyngier@arm.com>
Date:   Fri Mar 9 14:53:19 2018 +0000

     irqchip/gic-v3: Reset APgRn registers at boot time

     Booting a crash kernel while in an interrupt handler is likely
     to leave the Active Priority Registers with some state that
     is not relevant to the new kernel, and is likely to lead
     to erratic behaviours such as interrupts not firing as their
     priority is already active.

     As a sanity measure, wipe the APRs clean on startup. We make
     sure to wipe both group 0 and 1 registers in order to avoid
     any surprise.


The panic log is here:
https://paste.ubuntu.com/p/7WrJJDG6JQ/

Is it a known issue or is there a coming patch for that?
