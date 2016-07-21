From: joel@jms.id.au (Joel Stanley)
Date: Thu, 21 Jul 2016 23:13:50 +0930
Subject: [PATCH v2 0/3] clocksource: Add support for Aspeed timer
Message-ID: <1469108633-7940-1-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel,

This adds support for the Aspeed ast2400 and ast2500 families of BMC SoCs to
the moxart driver.

I've dropped the first patch and respun the others so they apply. I've also
boot tested on our hardware, so they are good to go.

It would be great to seem them make it for the upcoming merge window so I can
focus my time on cleaning up the the other drivers we have on their way.

Cheers,

Joel

Joel Stanley (3):
  drivers/clocksource/moxart: Refactor enable/disable
  drivers/clocksource/moxart: Use struct to hold state
  drivers/clocksource/moxart: Add Aspeed support

 .../bindings/timer/moxa,moxart-timer.txt           |   4 +-
 drivers/clocksource/moxart_timer.c                 | 195 ++++++++++++++-------
 2 files changed, 134 insertions(+), 65 deletions(-)

-- 
2.8.1
