From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 26 Aug 2016 09:31:54 +0100
Subject: [GIT PULL v2] CCN driver fixes for 4.8
In-Reply-To: <20160826001823.GF6209@localhost>
References: <20160826001823.GF6209@localhost>
Message-ID: <1472200314-32445-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I've got a small series of fixes for the CCN driver. A couple of them
are cc-ed to stable, starting at 3.17 (the very beginning of the
driver...). I've unified the subject prefixes in this v2.

Please consider pulling:

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawel.moll/linux.git tags/ccn/fixes-for-4.8-v2

for you to fetch changes up to d662ed2e50c9dab1d4c25e80fa3e01ebe257bd65:

  bus: arm-ccn: make event groups reliable (2016-08-26 09:16:18 +0100)

----------------------------------------------------------------
bus: ARM CCN PMU driver updates:
- Fixes and improvements for XP watchpoint and events handling
- Added missing condition checks for KVM-related exclusions
- Improved interrupt affinity handling
- Fix for hrtimer use in polling mode
- Event grouping implementation improvement

----------------------------------------------------------------
Mark Rutland (3):
      bus: arm-ccn: fix PMU interrupt flags
      bus: arm-ccn: fix hrtimer registration
      bus: arm-ccn: make event groups reliable

Pawel Moll (5):
      bus: arm-ccn: Fix PMU handling of MN
      bus: arm-ccn: Do not attempt to configure XPs for cycle counter
      bus: arm-ccn: Fix XP watchpoint settings bitmask
      bus: arm-ccn: Correct required arguments for XP PMU events
      bus: arm-ccn: Add missing event attribute exclusions for host/guest

 Documentation/arm/CCN.txt |  16 ++++---
 drivers/bus/arm-ccn.c     | 112 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 89 insertions(+), 39 deletions(-)
