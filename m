From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 12 Aug 2015 17:06:25 -0500
Subject: [PATCH 0/2] Enable smsc911x for use with ACPI
Message-ID: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches enables the front Ethernet port on the
ARM Juno development platform when used with an ACPI enabled kernel.

These patches covert the of_property* calls in the driver to the
DT/ACPI agnostic device_property* calls, and add the arm hardware
id to the acpi_match_table.

To support the above changes I copied a couple routines from
of_net into the properties.c file, and modified them to
be ACPI/DT agnostic. I'm not 100% sure this is the correct location
for these functions. But I think they are required to avoid having
a dozen different implementations scattered across assorted Ethernet
adapters that are being enabled to use ACPI properties.

Jeremy Linton (2):
  Add a matching set of device_ functions for determining mac/phy
  Convert smsc911x to use ACPI as well as DT

 drivers/base/property.c              | 73 ++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/smsc/smsc911x.c | 48 +++++++++++-------------
 include/linux/property.h             |  4 ++
 3 files changed, 99 insertions(+), 26 deletions(-)

-- 
2.4.3
