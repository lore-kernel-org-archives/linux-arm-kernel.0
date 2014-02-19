From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 19 Feb 2014 13:01:42 +0100
Subject: [PATCH v6 00/18] ahci: library-ise ahci_platform,
 add sunxi driver and cleanup imx driver
Message-ID: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here is v6 of my patchset for adding ahci-sunxi support. This has been
tested with Allwinner A10, Allwinner A20 and Freeware imx6x SoCs, including
suspend / resume. Note that since my last revision the ahci_imx driver has
also grown imx53 sata support, it would be good if some-one could test that
with this series.

History:

v1, by Olliver Schinagl:
This was using the approach of having a platform device which probe method
creates a new child platform device which gets driven by ahci_platform.c,
as done by ahci_imx.c .

v2, by Hans de Goede:
Stand-alone platform driver based on Olliver's work

v3, by Hans de Goede:
patch-series, with 4 different parts
a) Make ahci_platform.c more generic, handle more then 1 clk, target pwr
   regulator
b) New ahci-sunxi code only populating ahci_platform_data, passed to
   ahci_platform.c to of_device_id matching.
c) Refactor ahci-imx code to work the same as the new ahci-sunxi code, this
   is the reason why v3 is an RFC, I'm waiting for the wandboard I ordered to
   arrive so that I can actually test this.
d) dts bindings for the sunxi ahci parts

v4, by Hans de Goede:
patch-series, with 5 different parts:
a) Make ahci_platform.c more generic, handle more then 1 clk, target pwr
   regulator
b) Turn parts of ahci_platform.c into a library for use by other drivers
c) New ahci-sunxi driver using the ahci_platform.c library functionality
d) Refactor ahci-imx code to work the same as the new ahci-sunxi code
e) dts bindings for the sunxi ahci parts

v5:
v4 + the following changes:
1) fsl,imx6q driver is now tested
2) fixed suspend / resume on fsl,imx6q
3) Modifed devicetree node naming to match dt spec
4) Reworked the busy waiting code in the sunxi-phy handling as suggested by
   Russell King

v6:
v5 rebased on top of 3.14-rc3 + the following changes
1) Added Roger Quadros' generic phy support series
2) Added a "ARM: sun4i: dt: Remove grouping + simple-bus for regulators" dts
   patch

Tejun, can you please add patches 1-15 to your ata tree for 3.15 ?

Maxime, can you please add patch 16-18 to your dts tree for 3.15 ?

Thanks & Regards,

Hans 
