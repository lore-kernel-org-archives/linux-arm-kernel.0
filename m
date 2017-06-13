From: s-anna@ti.com (Suman Anna)
Date: Tue, 13 Jun 2017 18:45:10 -0500
Subject: [PATCH v3 0/3] Add Keystone2 Remoteproc driver
Message-ID: <20170613234513.7624-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

This is v3 of the patchset that adds the DT binding and the driver for
loading and booting the DSP devices present on various Keystone2 SoC families.
The binding and driver patches have already been acked by Rob Herring and Santosh
Shilimkar respectively, and this is just a minor refresh with one small comment
from Rob addressed in the binding (Patch 1). There are no code changes in remaining
patches. I have picked up their Acks in all the relevant patches.

Appreciate it if you can pick up the series for v4.13.

v2:
http://marc.info/?l=linux-kernel&m=149688154304565&w=2
v1:
http://marc.info/?t=149581802500004&r=1&w=2

regards
Suman

Andrew F. Davis (1):
  remoteproc/keystone: Ensure the DSPs are in reset in probe

Suman Anna (2):
  dt-bindings: remoteproc: Add Keystone DSP remoteproc binding
  remoteproc/keystone: Add a remoteproc driver for Keystone 2 DSPs

 .../bindings/remoteproc/ti,keystone-rproc.txt      | 133 ++++++
 drivers/remoteproc/Kconfig                         |  13 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/keystone_remoteproc.c           | 525 +++++++++++++++++++++
 4 files changed, 672 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt
 create mode 100644 drivers/remoteproc/keystone_remoteproc.c

-- 
2.13.1
