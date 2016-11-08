From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue,  8 Nov 2016 19:57:20 +0100
Subject: [PATCH v4 0/3] [PART 1/4] USB: ohci-da8xx: Allow a regulator for VBUS
 and over current
Message-ID: <20161108185723.17518-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the first of 4 series of patches to convert the
da8xx-ohci driver to use a regulator and probe form device tree 

To be able to use device tree to probe the driver, we need to remove
the platform callbacks that are handling vbus and over current.

These patches prepare the stage by allowing to use a regulator
instead of the platform callbacks.

DEPENDENCIES:
1. [PATCH 0/3] fix ohci phy name
https://lkml.org/lkml/2016/11/2/208
2. [PATCH/RFC v2 0/3] regulator: handling of error conditions for usb drivers
https://lkml.org/lkml/2016/11/3/188

A branch with all the dependencies can be found here:
https://github.com/axelhaslamx/linux-axel/commits/ohci-da8xx-dt-v4

Changes from v3->v4
* separate the series into smaller series for driver and arch/arm code,
  to ease review and merging to different trees.

Changes form v2->v3
* drop patches that have been integrated to arch/arm
* drop regulator patches which will be integrated through regulator tree
* use of the accepted regulator API to get over current status
* better patch separation with the use of wrappers

Changes from v1->v2
* Rebased and added patch to make ohci a separate driver
* Use a regulator instead of handling Gpios (David Lechner)
* Add an over current mode to regulator framework
* Fixed regulator is able to register for and over current irq
* Added patch by Alexandre to remove build warnings
* Moved global variables into private hcd structure.

Axel Haslam (3):
  USB: ohci: da8xx: use ohci priv data instead of globals
  USB: ohci: da8xx: Prepare to remove platform callbacks
  USB: ohci: da8xx: Allow a regulator to handle VBUS

 drivers/usb/host/ohci-da8xx.c | 284 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 234 insertions(+), 50 deletions(-)

-- 
2.10.1
