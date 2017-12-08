From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 08 Dec 2017 11:07:44 +0000
Subject: CC[NI] driver fixes for 4.15
Message-ID: <1512731264.3038.120.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

A small series of fixes for the CCN driver, plus (one time only, guest
staring) one for CCI.

Please consider pulling:

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.linaro.org/people/pawel.moll/linux.git tags/ccn/fixes-for-4.15

for you to fetch changes up to b69f63ebf553504739cc8534cbed31bd530c6f0b:

  bus: arm-ccn: fix module unloading Error: Removing state 147 which has instances left. (2017-12-04 17:15:20 +0000)

----------------------------------------------------------------
bus: ARM CCN and CCI PMU driver fixes

This is a bunch of fixes CCN and (guest starring this time) CCI drivers.

* Check for potential of failed allocation for the driver name string
* Manage CPU ID properly at allocation (both CCN and CCI)
* Fix module unload warnings related to objects release order
* Small improvements like using allocating printfs and proper
  attributes constification

The one fixing potential issues have been cc-ed to stable.

----------------------------------------------------------------
Arvind Yadav (1):
      bus: arm-ccn: constify attribute_group structures.

Christophe JAILLET (2):
      bus: arm-ccn: Check memory allocation failure
      bus: arm-ccn: Simplify code

Kim Phillips (1):
      bus: arm-ccn: fix module unloading Error: Removing state 147 which has instances left.

Marc Zyngier (2):
      bus: arm-ccn: Fix use of smp_processor_id() in preemptible context
      bus: arm-cci: Fix use of smp_processor_id() in preemptible context

 drivers/bus/arm-cci.c |  7 +++++--
 drivers/bus/arm-ccn.c | 25 +++++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)
