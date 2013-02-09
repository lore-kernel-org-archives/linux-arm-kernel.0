From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat,  9 Feb 2013 21:44:24 +0100
Subject: [PATCH RFC 0/7] ARM: OMAP: add DT binding for gpmc-smsc911x
Message-ID: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is an RFC to add Device Tree support for SMSC LAN chips connected
to OMAP processors though its General-Purpose Memory Controller.

The patch-set is composed of the following patches:

[PATCH RFC 1/7] platform: add a device node
[PATCH RFC 2/7] net: smsc911x: add pinctrl support
[PATCH RFC 3/7] ARM: OMAP: gpmc-smsc911x: add DT dev node init function
[PATCH RFC 4/7] ARM: OMAP: gpmc-smsc911x: pass a dev node to platform
[PATCH RFC 5/7] ARM: OMAP: gpmc: add support for gpmc-smsc911x child
[PATCH RFC 6/7] ARM: dts: OMAP: Add an GPMC node for OMAP3
[PATCH RFC 7/7] ARM: dts: omap3-igep0020: Add SMSC911x LAN chip support

It is an RFC because I had to modify the platform_device_register_resndata()
platform device registration function to allow passing a device node and
associate to the platform device after allocation. The patch-set updates all
current users and this shouldn't have a function effect on them.

I think that the need for platform code to pass the DT device node to the
platform registration infraestructure will be needed for other devices too
whose probe function needs to access the device node associated with the
device.

The binding has been tested on an TI OMAP3 based board (IGEPv2) and added
support is included on the RFC as an example.

It is based on Linus' latest master branch + linux-omap/omap-for-v3.9/gpmc
+ linux-omap-dt/for_3.9/dts

Thanks a lot and best regards,
Javier
