From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 Jan 2013 11:35:44 +0800
Subject: [PATCH 2/2] usb: chipidea: imx: Add system suspend/resume API
In-Reply-To: <1358477428-2605-2-git-send-email-peter.chen@freescale.com>
References: <1358477428-2605-1-git-send-email-peter.chen@freescale.com>
 <1358477428-2605-2-git-send-email-peter.chen@freescale.com>
Message-ID: <20130118033543.GB29282@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 10:50:28AM +0800, Peter Chen wrote:
> During the system suspend/resume procedure, the USB also
> needs to go suspend/resume procedure, this patch adds
> related APIs. It is tested at i.mx6q sabrelite. Meanwhile,
> it fixes the bug that the USB will out of work after
> system suspend/resume.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

Haven't reviewed the patches, but I've seen the series fix an imx6q
USB issue - the USB will be broken after system suspend/resume
operation as below.  So for both patches,

Tested-by: Shawn Guo <shawn.guo@linaro.org>

Shawn

$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
mmc0: card a8a5 removed
mmc1: card b368 removed
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
PM: Entering mem sleep
fec_stop : Graceful transmit stop did not complete !
PM: suspend of devices complete after 14.490 msecs
PM: suspend devices took 0.020 seconds
PM: late suspend of devices complete after 1.645 msecs
PM: noirq suspend of devices complete after 2.432 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
PM: noirq resume of devices complete after 1.217 msecs
PM: early resume of devices complete after 1.590 msecs
hub 2-1:1.0: hub_port_status failed (err = -71)
hub 2-1:1.0: hub_port_status failed (err = -71)
hub 2-1:1.0: hub_port_status failed (err = -71)
PM: resume of devices complete after 70.677 msecs
PM: resume devices took 0.080 seconds
PM: Finishing wakeup.
Restarting tasks ... done.
mmc0: new high speed SDHC card at address a8a5
mmcblk0: mmc0:a8a5 SD04G 3.69 GiB
 mmcblk0: p1 p2 p3
mmc1: SD Status: Invalid Allocation Unit size.
mmc1: card lacks mandatory switch function, performance might suffer.
mmc1: new SD card at address b368
mmcblk1: mmc1:b368 MS    121 MiB
 mmcblk1: p1
root at freescale ~$ ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
ci_hdrc ci_hdrc.1: port 1 reset error -110
hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 2-1:1.0: hub_port_status failed (err = -19)
hub 2-1:1.0: hub_port_status failed (err = -19)
hub 2-1:1.0: hub_port_status failed (err = -19)
hub 2-1:1.0: activate --> -19
usb 2-1: USB disconnect, device number 2
...
