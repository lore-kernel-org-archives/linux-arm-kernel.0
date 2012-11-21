From: dianders@chromium.org (Doug Anderson)
Date: Wed, 21 Nov 2012 10:26:00 -0800
Subject: [PATCH 0/2] Add automatic bus number support for i2c busses with
 device tree
In-Reply-To: <1353450428-2615-2-git-send-email-dianders@chromium.org>
References: <1353450428-2615-2-git-send-email-dianders@chromium.org>
Message-ID: <1353522362-25519-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was suggested by Mark Brown in response to a patch for adding
this functionality only for the s3c2410 bus:
  https://lkml.org/lkml/2012/11/20/681

I have also modified the i2c-pxa driver to use this new functionality
but have no good way to test that patch.  Hopefully someone else can
test and ack.  The patch adding the generic functionality could go in
even if the i2c-pxa patch needs changes.


Doug Anderson (2):
  i2c-core: dt: Pick i2c bus number from i2c alias if present
  i2c: pxa: Use i2c-core to get bus number now

 drivers/i2c/busses/i2c-pxa.c |    8 +---
 drivers/i2c/i2c-core.c       |  105 ++++++++++++++++++++++++++++++-----------
 2 files changed, 78 insertions(+), 35 deletions(-)

-- 
1.7.7.3
