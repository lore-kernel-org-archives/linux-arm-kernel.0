From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  4 Aug 2016 10:21:44 +0100
Subject: [PATCH 0/9] remoteproc: Allow platform-specific drivers to request
 resources
Message-ID: <20160804092153.23032-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once this patch-set has been applied; platform-specific remoteproc
drivers will be able to amend existing resource table entries,
provide new entries to be appended to an existing resource table
(if one already exists), start a new resource table (if one does
not already exist), and dump out resource table contents during
development/debugging.  It will also be possible to start remote
processors which do not require a resource table without being
forced to provide a fake one.

We're also taking the liberty to provide some simple fix-ups.

Lee Jones (9):
  remoteproc: core: Ensure error message is clear
  remoteproc: core: Trivial: Improve error checking, spelling and debug
    prints
  remoteproc: core: Remove pointless OOM print
  remoteproc: core: New API to add new resources to the resource table
  remoteproc: core: Add function to amend an existing resource table
    entry
  remoteproc: core: Add function to append a new resource table entry
  remoteproc: core: Add function to over-ride current resource table
  remoteproc: core: Skip resource table integrity checks if there are
    amendments
  remoteproc: core: Support empty resource tables

 drivers/remoteproc/remoteproc_core.c | 354 +++++++++++++++++++++++++++++++++--
 include/linux/remoteproc.h           |  21 +++
 2 files changed, 358 insertions(+), 17 deletions(-)

-- 
2.9.0
