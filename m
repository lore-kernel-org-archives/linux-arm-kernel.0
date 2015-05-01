From: pawel.moll@arm.com (Pawel Moll)
Date: Fri,  1 May 2015 18:36:25 +0100
Subject: [PATCH 0/5] ARM CCN driver updates
Message-ID: <1430501790-26918-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here's a short set of updates to the ARM CCN driver, aiming at 4.2.

No major functional changes, just a bunch of smaller and larger bug
fixes and getting the driver in line with the latest perf tool
features.

The series can be also pulled:

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawel.moll/linux.git tags/ccn/updates-for-4.2

for you to fetch changes up to 57006d3e6f62def53c01ae3ffc338caebd866e89:

  bus: arm-ccn: Allocate event when it is being added, not initialised (2015-05-01 17:51:05 +0100)

----------------------------------------------------------------
Set of ARM CCN PMU driver updates:
- fixed a nasty bitfield mangling bug
- added new hints to the perf userspace tool
- pinned events processing to a single PMU
- modified events initialisation so they can be rotated now

----------------------------------------------------------------

Pawel Moll (5):
  bus: arm-ccn: Fix node->XP config conversion
  bus: arm-ccn: cpumask attribute
  bus: arm-ccn: Provide required event arguments
  bus: arm-ccn: Do not group CCN events with other PMUs
  bus: arm-ccn: Allocate event when it is being added, not initialised

 Documentation/arm/CCN.txt |  17 +--
 drivers/bus/arm-ccn.c     | 273 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 226 insertions(+), 64 deletions(-)

-- 
2.1.0
