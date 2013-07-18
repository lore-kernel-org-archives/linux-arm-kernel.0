From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 17 Jul 2013 23:28:32 -0400
Subject: [PATCH 0/4] MCPM backends updates
Message-ID: <1374118116-16836-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1:
Fixes to the existing Vexpress DCSCB backend.

Patch 2:
Lorenzo's minimal SPC driver required by the TC2 MCPM backend.
As discussed on the list, this is not considered to be a MFD driver.
This hardly qualify as a bus driver either.  Conceptually, this is
a very platform specific register multiplex driver allowing subsystem
drivers to hook into.  I therefore moved it to drivers/platform/vexpress/.

Patch 3:
This is the MCPM backend enabling SMP secondary boot and CPU hotplug
on the VExpress TC2 big.LITTLE platform.

Patch 4:
Add MCPM suspend method to the TC2 backend allowing basic CPU idle/suspend.
The cpuidle driver that hooks into this will be submitted separately.

The TC2 MCPM patches have been reviewed here:
http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=242408

The latest SPC driver discussion is here:
http://news.gmane.org/group/gmane.linux.kernel/thread=1525836


Nicolas
