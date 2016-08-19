From: Nitin.Chaudhary@zii.aero (Nitin Chaudhary)
Date: Thu, 18 Aug 2016 18:17:36 -0700
Subject: [PATCH v3 0/3]Re:Re:Re:[PATCH v2] Added perf functionality to mmdc
 driver
In-Reply-To: <DB5PR04MB1430487C8BFA276E285493959F150@DB5PR04MB1430.eurprd04.prod.outlook.com>
References: <DB5PR04MB1430487C8BFA276E285493959F150@DB5PR04MB1430.eurprd04.prod.outlook.com>
Message-ID: <1471569459-1546-1-git-send-email-Nitin.Chaudhary@zii.aero>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series of patch resolve the kernel compilation errors with the
proposed perf functionality integration into MMDC driver by Zhengyu Shen and
hence provide the working code which can be enhanced upon as per the reviews
from Mark Rutland and Peter Zilstra. The code still retains the original working
as was proposed by Zhengyu except a few minor changes to resolve probe failure
in the latest version of kernel. These patchsets are second version of patches
incorporating the inputs from Zhengyu. The below is description:
 v2 - Migrated driver to use state machine based CPU notifier
 v3 - Fixed the code for probe failure while polling on MMDC MAPSR bit 4

Any review & comments are welcomed!

Nitin Chaudhary (3):
  Error: Fix mmdc compilation errors due to cpu notifier
  [i.MX6Q] Code cleanup & verification after fixing compilation error
  [i.MX6Q]Removed MMDC Auto Power saving timeout error

 arch/arm/mach-imx/mmdc.c   | 122 +++++++++++++++++++++++++--------------------
 include/linux/cpuhotplug.h |   1 +
 2 files changed, 69 insertions(+), 54 deletions(-)

--
2.7.4


________________________________


This email and any files transmitted with it are confidential & proprietary to Zodiac Inflight Innovations. This information is intended solely for the use of the individual or entity to which it is addressed. Access or transmittal of the information contained in this e-mail, in full or in part, to any other organization or persons is not authorized.
