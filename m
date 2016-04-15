From: stanislav.meduna@nxtcontrol.com (Stanislav Meduna)
Date: Fri, 15 Apr 2016 18:17:45 +0200
Subject: i.MX53 restart via watchdog does not work
Message-ID: <57111429.6040802@nxtcontrol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am using an TQMa53 board, which expects to be resetted
by watchdog circuit. In older kernels ths was done in
by mxc_restart defined in arch/arm/mach-imx/system.c
and initialized and wired in mach-imx53.c.

Current kernels however do not use this and the mach-imx53.c
does not set .restart. I am getting
  imx2-wdt 53f98000.wdog: Device shutdown: Expect reboot!
  reboot: Restarting system
and the system just hangs there.

What is the correct way to accomplish this? I can of course
try to merge the old code back, but I expect there is
a reason why it was removed. Is writing the restart function
where I get and enable the clock, get an I/O mapping and
write the watchdog registers the correct approach?
Or should this be controlled by the device tree? Are there
maybe some patches flying (I was not able to google
anything relevant)?

Thanks
-- 
                                Stano
