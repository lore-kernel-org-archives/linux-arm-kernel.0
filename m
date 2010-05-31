From: p.osciak@samsung.com (Pawel Osciak)
Date: Mon, 31 May 2010 11:08:49 +0200
Subject: [PATCH 0/6] Various s3c-fb updates
Message-ID: <1275296935-2693-1-git-send-email-p.osciak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series is rebased onto Ben Dook's framebuffer branch available at:
git://git.fluff.org/bjdooks/linux.git dev/s3c-fb

The main changes are the addition of an ability to wait for VSYNC and
display panning.

The first patch attempts to fix some NULL pointer dereferences in case
of a failed framebuffer memory allocation attempt. This is a quick
fix, so please treat it more as an indication of what may be wrong
with the code in the probe function and not as something to merge.

Patches 3-4 add "new style" device name initialization for various
S3C/S5P devices. The 4th patch also separates S5PC100 and S5PV210 as
their framebuffer registers sets differ.


[PATCH 1/6] s3c-fb: Fix various null references on framebuffer memory alloc failure
[PATCH 2/6] s3c-fb: Correct FRAMESEL1 bitfield defines for VIDINTCON0 register
[PATCH 3/6] s3c-fb: Add device name initialization.
[PATCH 4/6] s3c-fb: Separate S5PC100 and S5PV210 framebuffer driver data structures
[PATCH 5/6] s3c-fb: Add support for display panning
[PATCH 6/6] s3c-fb: Add wait for VSYNC ioctl

Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
