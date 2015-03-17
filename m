From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 17 Mar 2015 18:14:57 +0000
Subject: [PATCHv2 0/3] [4.0] arm/arm64: Do not group hardware events from
 different PMUs
Message-ID: <1426616100-31628-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This is a collection of fixes which denies grouping hardware events
from different PMUs. They also fix crashes triggered by perf_fuzzer
on Linux-4.0-rc2.

This series hasn't changed since V1, except for better commit messages.

Similar fixes are required in ARM-CCN PMU driver and is not straight forward
as these changes.

Suzuki K. Poulose (3):
  arm/pmu: Reject groups spanning multiple hardware PMUs
  arm64/pmu: Reject groups spanning multiple HW PMUs
  arm-cci: Reject groups spanning multiple HW PMUs

 arch/arm/kernel/perf_event.c   |   21 +++++++++++++++------
 arch/arm64/kernel/perf_event.c |   21 +++++++++++++++------
 drivers/bus/arm-cci.c          |   19 ++++++++++++++-----
 3 files changed, 44 insertions(+), 17 deletions(-)

-- 
1.7.9.5
