From: hari.vyas@broadcom.com (Hari Vyas)
Date: Thu, 19 Jul 2018 15:18:53 +0530
Subject: [PATCH] arm64: fix for restoring console loglevel after handling traps
Message-ID: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

changes in v1:
	Separate functions for changing, retrieving, storing and restoring
	console loglevel messages.
	Restoring console loglevel message is done from arm64 trap handling
	code but can be extended on need basis by other user.
	Restoring is actually required in die() function only and other places
	kernel will panic but added considering code completion

Hari Vyas (1):
  arm64: fix for restoring console loglevel after handling traps

 arch/arm64/kernel/traps.c |  6 +++++-
 include/linux/printk.h    | 38 +++++++++++++++++++++++++++++++++++---
 kernel/printk/printk.c    |  3 +++
 3 files changed, 43 insertions(+), 4 deletions(-)

-- 
1.9.1
