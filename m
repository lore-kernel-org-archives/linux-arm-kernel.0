From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 20 Jun 2014 16:35:51 +0200
Subject: [PATCH v2 0/2] Improve mvebu_get_soc_id
Message-ID: <1403274953-21790-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The first use -ENODEV as return value instead of -1 as suggested by
Arnd for the second patch.

The second patch allows to get the SoC Id and the revision without using
the PCI register on Armada 38x.

Thanks,

Gregory

Changelog:

v1 -> v2:

- Fix typo in mvebu_system_controller_get_soc_id.
- Use -ENODEV as return value instead of -1


Gregory CLEMENT (2):
  ARM: mvebu: Use the a standard errno in mvebu_get_soc_id
  ARM: mvebu: Use system controller to get the soc id when possible

 arch/arm/mach-mvebu/common.h            |  1 +
 arch/arm/mach-mvebu/mvebu-soc-id.c      | 22 ++++++++++++++++++++--
 arch/arm/mach-mvebu/system-controller.c | 19 +++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

-- 
1.8.1.2
