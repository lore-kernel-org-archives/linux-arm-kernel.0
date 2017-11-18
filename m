From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 11:14:25 +0530
Subject: [PATCH 0/2] misc: Fix platform_get_irq's error checking
Message-ID: <1510983867-2344-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Arvind Yadav (2):
  [PATCH 1/2] misc: aspeed-lpc-snoop: Fix platform_get_irq's error checking
  [PATCH 2/2] misc: atmel-ssc: Fix platform_get_irq's error checking

 drivers/misc/aspeed-lpc-snoop.c | 4 ++--
 drivers/misc/atmel-ssc.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4
