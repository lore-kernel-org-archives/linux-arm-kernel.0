From: manabian@gmail.com (Joachim Eastwood)
Date: Wed,  6 May 2015 00:10:25 +0200
Subject: [PATCH v3 0/2] reset driver for NXP LPC18xx family
Message-ID: <1430863827-21898-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a reset driver for NXP LPC18xx/43xx devices.

Changes in v3:
* add patch descriptions
* change parameter name in to_rgu_data macro to avoid a potential
  issue if code is changed.

Changes in v2:
* clean up header includes
* prefix M0 reset defines with LPC43XX
* fix comment about M0 reset lines
* reorganize reset call chains
* add reset number table to dt doc

There are no dependencies in this patch set. The DTS changes will
be sent separately to arm-soc once this patch set goes upstream.

Base support for the NXP LPC18xx family can be found here:
http://marc.info/?l=linux-arm-kernel&m=143016894704253&w=2

Joachim Eastwood (2):
  reset: add driver for lpc18xx rgu
  doc: dt: add documentation for lpc1850-rgu reset driver

 .../devicetree/bindings/reset/nxp,lpc1850-rgu.txt  |  84 +++++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-lpc18xx.c                      | 258 +++++++++++++++++++++
 3 files changed, 343 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt
 create mode 100644 drivers/reset/reset-lpc18xx.c

-- 
1.8.0
