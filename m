From: ajellisuk@yahoo.co.uk (Ellis Andrew)
Date: Wed, 12 Sep 2012 17:18:22 +0100 (BST)
Subject: Kernel panic - not syncing: No init found
Message-ID: <1347466702.70460.YahooMailNeo@web133201.mail.ir2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

After a lot of searching with Google I have found this is a common 
problem, unfortunately none of the solutions I have found, fix the 
problem.

The original error I got was:

Kernel panic - not syncing: No init found.  Try passing init= option to kernel.

The command line option was:
root=/dev/mtdblock3 rootfstype=jffs2 rw console=ttyMCS mem=64M at 0x0

I after digging around with google, I found a suggestion which I tried, I made my command line:
root=/dev/mtdblock3 rootfstype=jffs2 rw console=ttyMCS mem=64M at 0x0 init=/sbin/init panic=4

But I now get the following error:

Freeing init memory: 88K
Failed to execute /sbin/init.  Attempting defaults...
Kernel panic - not syncing: No init found.  Try passing init= option to kernel.

I can see that the Root drive is being mounted.

The contents of the init file is:

#!/bin/busybox ash
/bin/busybox mount -t sysfs /dev/sys /sys
/bin/busybox mount -t proc  /proc
/bin/busybox mount -t devpts /dev/pts
# Populate /dev according to /sys
/bin/busybox mdev -s
/bin/busybox --install -s
/linuxrc
exec /sbin/init "$@"?  </dev/console >/dev/console 2>&1

Does anyone have any suggestions on how to fix this please? 


Kind regards

Andrew Ellis
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120912/a9a75241/attachment-0001.html>
