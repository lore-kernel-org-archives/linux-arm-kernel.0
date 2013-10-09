From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Oct 2013 17:54:16 +0100
Subject: [GIT PULL] CCI PMU driver for 3.13
Message-ID: <20131009165416.GG8378@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin,

Please can you pull this CCI PMU driver series for 3.13? I previously sent a
pull request for 3.12, but the device-tree binding wasn't ready and it
missed the last merge window. So here's the new and improved series with the
relavant acks.

Cheers,

Will

--->8

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-perf-3.13

for you to fetch changes up to fee4f2c66a3b0f0e97e16b3084e8c4151ae9196f:

  drivers: CCI: fix the error handle in cci_pmu_probe() (2013-09-24 14:03:05 +0100)

----------------------------------------------------------------
Addition of an ARM PMU driver for the CCI-400 coherent interconnect
found on big.LITTLE systems, such as TC2.

This was originally sent for 3.12, but the device-tree bindings hadn't
settled down so here's the improved version for 3.13. I think the code
has benefited from the wait.

----------------------------------------------------------------
Punit Agrawal (3):
      ARM: dts: Improve CCI bindings documentation
      ARM: dts: Document the CCI PMU DT bindings
      drivers: CCI: add ARM CCI PMU support

Wei Yongjun (1):
      drivers: CCI: fix the error handle in cci_pmu_probe()

 Documentation/devicetree/bindings/arm/cci.txt |  60 ++-
 drivers/bus/arm-cci.c                         | 617 +++++++++++++++++++++++++-
 2 files changed, 669 insertions(+), 8 deletions(-)
