From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 25 Oct 2018 17:29:24 +0200
Subject: [PATCH RFC 00/11] staging: vc04_services: Improve driver load/unload
Message-ID: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series improves the load/unload of bcm2835 camera and audio
drivers. It has been tested with Raspberry Pi 3 B and a camera module V1.

This series based on current linux-next and Phil Elwell's series ("Improve VCHIQ
cache line size handling"). After Nicolas' series ("staging: vc04_services:
Some dead code removal") has been applied, i will rebase my series.

Stefan Wahren (11):
  staging: bcm2835-camera: Abort probe if there is no camera
  staging: bcm2835-camera: fix module autoloading
  staging: bcm2835-camera: Move module info to the end
  staging: vchiq_arm: Fix platform device unregistration
  staging: vchiq_arm: Fix camera device registration
  staging: vchiq_arm: Register a platform device for audio
  staging: bcm2835-audio: Enable compile test
  staging: bcm2835-audio: use module_platform_driver() macro
  staging: bcm2835-audio: Drop DT dependency
  staging: bcm2835-camera: Provide more specific probe error messages
  staging: bcm2835-camera: Add hint about possible faulty config

 .../staging/vc04_services/bcm2835-audio/Kconfig    |  2 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 61 ++++++-----------
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 78 +++++++++++++++-------
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |  5 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 27 ++++++--
 5 files changed, 102 insertions(+), 71 deletions(-)

-- 
2.7.4
