From: s-anna@ti.com (Suman Anna)
Date: Wed, 7 Jun 2017 19:24:44 -0500
Subject: [PATCH v2 0/3] Add Keystone2 Remoteproc driver
Message-ID: <20170608002447.47580-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v2 of the patchset that adds the DT binding and the driver for
loading and booting the DSP devices present on various Keystone2 SoC families.
The current series supports the 66AK2H/K, 66AK2L and 66AK2E SoC families.
The DTS nodes will be posted separately once the binding is accepted,
and dependent patches from Loic are merged. See v1 cover-letter for details.

Main changes are in the binding to address various comments from 
Rob Herring. The driver is updated to construct firmware names based on
alias property. Exact changes are summarized in each patch.

v1:
http://marc.info/?t=149581802500004&r=1&w=2

regards
Suman

Andrew F. Davis (1):
  remoteproc/keystone: Ensure the DSPs are in reset in probe

Suman Anna (2):
  dt-bindings: remoteproc: Add Keystone DSP remoteproc binding
  remoteproc/keystone: Add a remoteproc driver for Keystone 2 DSPs

 .../bindings/remoteproc/ti,keystone-rproc.txt      | 135 ++++++
 drivers/remoteproc/Kconfig                         |  13 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/keystone_remoteproc.c           | 525 +++++++++++++++++++++
 4 files changed, 674 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt
 create mode 100644 drivers/remoteproc/keystone_remoteproc.c

-- 
2.12.0
