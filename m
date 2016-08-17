From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 17 Aug 2016 12:05:08 +0100
Subject: [GIT PULL] CCN driver fixes for 4.8
Message-ID: <1471431908.7117.50.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I've got a small series of fixes for the CCN driver. A couple of them
are cc-ed to stable, starting at 3.17 (the very beginning of the
driver...).

Please consider pulling:

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:

? Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

? git://git.linaro.org/people/pawel.moll/linux.git tags/ccn/fixes-for-4.8

for you to fetch changes up to 787f718ca39c06144d70c496d22d7e5f72d3554e:

? arm-ccn: make event groups reliable (2016-08-17 11:42:48 +0100)

----------------------------------------------------------------
bus: ARM CCN PMU driver updates:
- Fixes and improvements for XP watchpoint and events handling
- Added missing condition checks for KVM-related exclusions
- Improved interrupt affinity handling
- Fix for hrtimer use in polling mode
- Event grouping implementation improvement

----------------------------------------------------------------
Mark Rutland (3):
??????arm-ccn: fix PMU interrupt flags
??????arm-ccn: fix hrtimer registration
??????arm-ccn: make event groups reliable

Pawel Moll (5):
??????bus: arm-ccn: Fix PMU handling of MN
??????bus: arm-ccn: Do not attempt to configure XPs for cycle counter
??????bus: arm-ccn: Fix XP watchpoint settings bitmask
??????bus: arm-ccn: Correct required arguments for XP PMU events
??????bus: arm-ccn: Add missing event attribute exclusions for host/guest

?Documentation/arm/CCN.txt |??16 ++++---
?drivers/bus/arm-ccn.c?????| 112 ++++++++++++++++++++++++++++++++--------------
?2 files changed, 89 insertions(+), 39 deletions(-)
