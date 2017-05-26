From: s-anna@ti.com (Suman Anna)
Date: Fri, 26 May 2017 15:21:36 -0500
Subject: [PATCH 0/4] Add DT support for davinci remoteproc driver
Message-ID: <20170526202140.10472-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series adds the device tree support to the Davinci
remoteproc driver. The TI Davinci family has boards booting both
in legacy mode and DT mode, so both modes are still supported by
this driver. Patches are baselined on 4.12-rc1 + the "Davinci
remoteproc cleanups/fixes" series [1].

Following is the patch summary:
 - Patch 1 uses resource names for retrieving resources to be
   independent of the resource order, and prepare the driver
   for DT.
 - Patch 2 parses the internal memory regions, to be able to
   support loading into DSP internal memory regions.
 - Patch 3 adds the binding
 - Patch 4 adds the DT adaptation to the existing driver.

The first 2 patches are dependent on the resource name additions
(no direct build dependencies) to the davinci-rproc devices added
in series [2] for maintaining functional parity for legacy-mode
devices. This series is already accepted and being staged to be
merged for v4.13. DTS nodes for the OMAP-L138 LCDK board will be
added for a subsequent merge window once these patches are picked
up.

regards
Suman

[1] http://marc.info/?l=linux-arm-kernel&m=149514538506046&w=2
[2] http://marc.info/?l=linux-kernel&m=149497287512869&w=2
[3] https://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git/?h=v4.13/soc

Suman Anna (4):
  remoteproc/davinci: Switch to platform_get_resource_byname()
  remoteproc/davinci: add support to parse internal memories
  Documentation: dt: Add bindings for Davinci DSP processors
  remoteproc/davinci: Add device tree support for OMAP-L138 DSP

 .../bindings/remoteproc/ti,davinci-rproc.txt       | 92 ++++++++++++++++++++
 drivers/remoteproc/da8xx_remoteproc.c              | 98 ++++++++++++++++++++--
 2 files changed, 185 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt

-- 
2.12.0
