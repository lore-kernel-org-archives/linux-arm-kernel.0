From: s-anna@ti.com (Suman Anna)
Date: Wed, 6 Apr 2016 18:37:16 -0500
Subject: [PATCH 0/4] OMAP mailbox suspend/resume support
Message-ID: <1459985840-1106-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series adds the suspend/resume support through the PM
callbacks to the OMAP mailbox driver. The functionality is added mainly
in Patch 2. Patch 4 kills the legacy API exported to the mailbox clients
to save and restore the context.

The series is based on 4.6-rc2 + the OMAP Mailbox legacy platform device
support removal series [1].

regards
Suman

[1] http://marc.info/?l=linux-omap&m=145996429717184&w=2

Suman Anna (4):
  mailbox/omap: store mailbox interrupt type in omap_mbox_device
  mailbox/omap: add support for suspend/resume
  mailbox/omap: check for any unread messages during suspend
  mailbox/omap: kill omap_mbox_{save/restore}_ctx() functions

 drivers/mailbox/omap-mailbox.c | 106 +++++++++++++++++++++--------------------
 include/linux/omap-mailbox.h   |   2 -
 2 files changed, 55 insertions(+), 53 deletions(-)

-- 
2.7.4
