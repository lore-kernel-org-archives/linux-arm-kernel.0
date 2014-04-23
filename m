From: robherring2@gmail.com (Rob Herring)
Date: Wed, 23 Apr 2014 17:57:39 -0500
Subject: [PATCH 0/2] DT irq deferred probe support
Message-ID: <1398293861-7682-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

This is atleast the 4th attempt to fix a long standing issue with DT 
irq resolution needing to support deferred probe when irq parent is not 
yet initialized. This version implements Russell King's suggestion to do 
irq resolution when platform_get_irq is called. 

Tony, I squashed your warning fix (dropping the other part) and stole 
much of your commit message. Let me know if you have any issues with 
that.

Rob

Rob Herring (2):
  of: selftest: add deferred probe interrupt test
  of/irq: do irq resolution in platform_get_irq

 drivers/base/platform.c                        |  7 +++++-
 drivers/of/irq.c                               | 26 +++++++++++++++++++++
 drivers/of/platform.c                          |  4 +++-
 drivers/of/selftest.c                          | 32 ++++++++++++++++++++++++++
 drivers/of/testcase-data/tests-interrupts.dtsi | 12 ++++++++++
 include/linux/of_irq.h                         |  7 +++++-
 6 files changed, 85 insertions(+), 3 deletions(-)

-- 
1.9.1
