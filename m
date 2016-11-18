From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 18 Nov 2016 11:56:15 +0000
Subject: [GIT PULL v2] firmware: SCPI updates for v4.10
In-Reply-To: <20161028112920.GB12241@e107155-lin>
References: <20161028112920.GB12241@e107155-lin>
Message-ID: <20161118115615.GB14913@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC Team,

I have decoupled the platform specific binding from generic SCPI. Also
I have renamed "arm,legacy-scpi" to "arm,scpi-pre-1.0". Since I haven't
heard back any objections from Olof/Rob for my response, I am sending
the pull request now.

--
Regards,
Sudeep

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scpi-updates-4.10

for you to fetch changes up to 8358c6b5fc8c160d0af8654f313b8a7745f8e304:

  firmware: arm_scpi: add support for pre-v1.0 SCPI compatible (2016-11-17 16:31:20 +0000)

----------------------------------------------------------------
SCPI updates for v4.10

1. Adds support for pre-v1.0 SCPI protocol versions

2. Adds support for SCPI used on Amlogic GXBB SoC platforms using the
   newly added pre-v1.0 SCPI protocol

3. Decouples some platform specific details from generic SCPI binding

----------------------------------------------------------------
Neil Armstrong (4):
      firmware: arm_scpi: increase MAX_DVFS_OPPS to 16 entries
      firmware: arm_scpi: add alternative legacy structures, functions and macros
      firmware: arm_scpi: allow firmware with get_capabilities not implemented
      Documentation: bindings: Add support for Amlogic GXBB SCPI protocol

Sudeep Holla (4):
      firmware: arm_scpi: add command indirection to support legacy commands
      Documentation: bindings: decouple juno specific details from generic binding
      Documentation: bindings: add compatible specific to pre v1.0 SCPI protocols
      firmware: arm_scpi: add support for pre-v1.0 SCPI compatible

 .../devicetree/bindings/arm/amlogic,scpi.txt       |  20 ++
 Documentation/devicetree/bindings/arm/arm,scpi.txt |  25 +-
 .../devicetree/bindings/arm/juno,scpi.txt          |  26 ++
 drivers/firmware/arm_scpi.c                        | 276 ++++++++++++++++++---
 4 files changed, 301 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic,scpi.txt
 create mode 100644 Documentation/devicetree/bindings/arm/juno,scpi.txt
