From: romain.perier@gmail.com (Romain Perier)
Date: Wed, 17 Feb 2016 18:28:32 +0100
Subject: [PATCH 0/2] Adding support to show SoC revision in /proc/cpuinfo
Message-ID: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds support to retrieve the SoC serial and revision of the current
Meson8 platform. Basically, in the first patch I register a soc_device and retrieve
information from a syscon register, then I populate system_rev and system_serial.
In the second patch I add the device_node to the devicetree.

Romain Perier (2):
  ARM: meson: Adding support to retrieve serial and SoC revision
  ARM: dts: meson: Adding hwrev syscon node

 arch/arm/boot/dts/meson8b.dtsi |  5 ++++
 arch/arm/mach-meson/meson.c    | 55 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

-- 
2.5.0
