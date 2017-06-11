From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Sun, 11 Jun 2017 08:20:59 +0200
Subject: patch "arm: ecard: fix dev_groups patch typo" added to
 driver-core-next
Message-ID: <14971620599888@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    arm: ecard: fix dev_groups patch typo

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From 1b8b02f0d084a2d9a966d5ae004d49c8e76aa8cc Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 10 Jun 2017 14:31:21 +0200
Subject: arm: ecard: fix dev_groups patch typo

Commit 71d1e5d71cec ("arm: ecard: use dev_groups and not dev_attrs for bus_type")
had a typo in the resource attribute definition.  Fix that up.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: 71d1e5d71cec ("arm: ecard: use dev_groups and not dev_attrs for bus_type")
Cc: Russell King <linux@armlinux.org.uk>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Greg Kroah-Hartman gregkh at linuxfoundation.org
---
 arch/arm/mach-rpc/ecard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index f75b8b562d57..5966964222b5 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -789,7 +789,7 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 
 	return str - buf;
 }
-static DEVICE_ATTR_RO(resource_show)
+static DEVICE_ATTR_RO(resource)
 
 static ssize_t vendor_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-- 
2.13.1
