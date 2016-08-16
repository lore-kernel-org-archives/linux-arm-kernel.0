From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 16 Aug 2016 12:01:00 +0100
Subject: [GIT PULL] SCPI/Vexpress fixes for v4.8-rc
Message-ID: <f232ba19-e359-3ef4-cce5-e76b0f35d078@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi ARM-SoC guys,

I have couple of missing of_node_put fixes in vexpress/scpi drivers.
I am not sure if these are considered as more cleanup patches rather
than fixes as OF reference counting is not something religiously checked
always. Let me know, I will move these to v4.9 queue otherwise.

-- 
Regards,
Sudeep

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
tags/vexpress-fixes-4.8-rc

for you to fetch changes up to b079bd555f6060cd6b435a1eb58ec3b8d255ebd0:

   firmware: arm_scpi: add missing of_node_put after calling 
of_parse_phandle (2016-08-08 14:31:09 +0100)

----------------------------------------------------------------
SCPI/Vexpress fixes for v4.8-rc

Couple of minor fixes to add missing of_node_put after calling
of_parse_phandle in SCPI and vexpress-config bus drivers(Peter Chen)

----------------------------------------------------------------
Peter Chen (2):
       bus: vexpress-config: add missing of_node_put after calling 
of_parse_phandle
       firmware: arm_scpi: add missing of_node_put after calling 
of_parse_phandle

  drivers/bus/vexpress-config.c | 1 +
  drivers/firmware/arm_scpi.c   | 5 +++--
  2 files changed, 4 insertions(+), 2 deletions(-)
