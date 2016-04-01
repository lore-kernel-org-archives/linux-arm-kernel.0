From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  1 Apr 2016 16:22:37 +0200
Subject: [PATCH 0/2] clocksource: sp804: Add OX810SE 24bit mode Support
Message-ID: <1459520559-13110-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset includes support for Oxford Semiconductor OX810SE SoC by adding
variable width support. It selects the 24bit mode with a new compatible string.

It adds a timer_sp804 structure used to configure the clocksource and
clockevents.

It was originally posted part of a platform patchset available here :
http://lkml.kernel.org/r/1458838215-23314-1-git-send-email-narmstrong at baylibre.com

Changes this v3 patchset :
- Get rid of PLX Technology, replace by Oxford Semiconductor
- Switch to timer_sp804 structure to configure clocksource and clockevents

Neil Armstrong (2):
  clocksource: sp804: Add support for OX810SE 24bit timer width
  dt-bindings: timer: sp804: add new compatible for OX810SE SoC

 .../devicetree/bindings/timer/arm,sp804.txt        |   2 +-
 drivers/clocksource/timer-sp804.c                  | 107 +++++++++++++--------
 include/clocksource/timer-sp804.h                  |  42 ++++++--
 3 files changed, 103 insertions(+), 48 deletions(-)

-- 
1.9.1
