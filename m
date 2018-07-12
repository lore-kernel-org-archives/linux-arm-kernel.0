From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Thu, 12 Jul 2018 11:28:21 +0200
Subject: [PATCH 0/3] ARM: hisi: fix of_iomap errors
Message-ID: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set addresses two issues in arch/arm/mach-hisi/hotplug.c

1) The hisi hotplug functions were using a few unchecked 
   of_iomap() while at the same time the system relied on
   those mappings. Checks for !NULL were inserted.

2) Further some mandatory of_node_put() were missing and have
   been inserted.
