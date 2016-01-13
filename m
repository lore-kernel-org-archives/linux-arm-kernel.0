From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 12 Jan 2016 17:20:12 -0800
Subject: stage2_unmap_vm - softlockup watchdog
Message-ID: <5695A64C.2010701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While running tests on foundation and fast models. stage2_unmap_vm()
triggers the softlockup watchdog (on a reboot). I have not tried to reproduce
on hardware or work with the thresholds (watchdog_thresh()) these could
be more aggressive and usually are in more critical environments.

I think that calling 'touch_softlockup_watchdog()' someplace while walking
second stage tables should prevent this.

On hardware huge VMs may be susceptible to this.

This is only likely to happen when main memory is fragmented and 2nd stage
tables are backed by pages. With huge pages only everything appears to work fine.

- Mario
