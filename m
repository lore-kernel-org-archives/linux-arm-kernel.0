From: x0095840@ti.com (Fernando Guzman Lugo)
Date: Thu, 18 Feb 2010 01:06:34 -0600
Subject: [PATCH] Mailbox: Fix some issues in mailbox module
Message-ID: <mailman.215.1266476776.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches fix some issue I found when I was working
with mailbox module.

Fernando Guzman Lugo (4):
  Mailbox: free mailbox interrupt before freeing blk queue
  Mailbox: flush pending deferred works before freeing blk queue
  Mailbox: Check valid registered callback before calling
  Mailbox: disable mailbox interrupt when request queue

Hiroshi DOYU (1):
  Mailbox: new mutext lock for h/w mailbox configuration

 arch/arm/plat-omap/mailbox.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)
