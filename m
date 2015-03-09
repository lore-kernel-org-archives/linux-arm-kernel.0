From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  9 Mar 2015 12:46:29 +0000
Subject: [PATCH 0/3] [4.0] arm/arm64: Do not group hardware events from
 different PMUs
Message-ID: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This is a collection of fixes which denies grouping hardware events
from different PMUs. They also fix crashes triggered by perf_fuzzer
on Linux-4.0-rc2.

Pawel,

Similar fix is required in ARM CCN PMU driver. I didn't find it
straight forward to fix it there. Could you please take a look
into it ?


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
