From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 22 Mar 2010 13:38:32 -0500
Subject: [PATCH 0/3] arm: add a /proc/cpuinfo platform extension
Message-ID: <0D753D10438DA54287A00B02708426976368DDCD31@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an optional platform specific extension to /proc/cpuinfo.

Many platforms have custom cpu information that could be exposed
to user space using /proc/cpuinfo.

Patch 1/3 adds the necessary core support to allow a platform
specific callback to dump this information.

Patch 2/3 adds a callback to mach-ep93xx that exposes the two
unique MaverickKey IDs as well as the processor silicon revision
and a number of boot configuration options.

Patch 3/3 hooks up all the ep93xx platforms.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

This is a repost of the patch series due to some requests from
ep93xx users.  It has been rebased to 2.6.34-rc2.
