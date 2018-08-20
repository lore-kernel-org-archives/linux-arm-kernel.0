From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Mon, 20 Aug 2018 20:13:30 +0200
Subject: [PATCH 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for MODEM
Message-ID: <20180820181333.2527-1-jmkrzyszt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Convert modem related GPIO setup from integer space to GPIO descriptors.
Also, restore original initialization order of the MODEM device and its
related GPIO pins.

Cleanup of MODEM relaated regulator setup is postponed while waiting for
upcoming conversion of fixed regulator API to GPIO descriptors.


Janusz Krzysztofik (3):
      ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
      ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
      ARM: OMAP1: ams-delta: register MODEM device earlier


diffstat:
 board-ams-delta.c |  120 +++++++++++++++++++++++++++++++++++++++---------------
 board-ams-delta.h |    7 ---
 2 files changed, 88 insertions(+), 39 deletions(-)
