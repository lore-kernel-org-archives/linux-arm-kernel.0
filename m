From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 17 Apr 2011 23:01:53 +0200
Subject: [PATCH 0/14] Remove sysdev suspend/resume and shutdown operations
In-Reply-To: <201103280125.11750.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl>
Message-ID: <201104172301.54115.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series of patches fixes bugs related to the introduction
of struct syscore_ops later in this cycle, replaces sysdev suspend/resume
operations in all of the architectures still using them with struct
syscore_ops-based PM callbacks and finally removes the suspend/resume
and shutdown operations from struct sysdev_class and struct sysdev_driver.

Patches [1/14] and [2/14] are important bug fixes targeted at 2.6.39.
The remaining patches are regareded as 2.6.40 material, but I'd like to
put them into linux-next shortly, if there are no objections, to catch
problems that they may introduce before they hit the mainline.  Again,
if there are no objections I'd like to merge these patches through the
suspend-2.6 tree.

[1/14] - Fix error code paths executed after failing syscore_suspend()
[2/14] - Add missing syscore_suspend() and syscore_resume() calls to
         subsystems that should use them in addition to sysdev calls.

[3/14] - Use struct syscore_ops for core PM (instead of sysdevs) in the
         common ARM code.
[4/14] - Use struct syscore_ops for core PM (instead of sysdevs) in ARM OMAP
         code.
[5/14] - Use struct syscore_ops for core PM (instead of sysdevs) in ARM
         Integrator code.
[6/14] - Use struct syscore_ops for core PM (instead of sysdevs) in ARM SA1100
         code.
[7/14] - Use struct syscore_ops for core PM (instead of sysdevs) in ARM PXA
         code.
[8/14] - Use struct syscore_ops for core PM (instead of sysdevs) in ARM Samsung
         code.
[9/14] - Use struct syscore_ops for core PM (instead of sysdevs) in Blackfin
         arch code.
[10/14] - Use struct syscore_ops for core PM (instead of sysdevs) in MIPS
         arch code.
[11/14] - Use struct syscore_ops for core PM (instead of sysdevs) in AVR32
         arch code.
[12/14] - Use struct syscore_ops for core PM (instead of sysdevs) in Unicore32
         arch code.
[13/14] - Use struct syscore_ops for core PM (instead of sysdevs) in PowerPC
         arch code.
[14/14] - Remove sysdev suspend/resume and shutdown operations.

Thanks,
Rafael
