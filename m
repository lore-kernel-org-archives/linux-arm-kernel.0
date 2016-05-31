From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue, 31 May 2016 14:08:07 +0800
Subject: [PATCH 0/3] watchdog,
 sbsa_gwdt: Update SBSA watchdog with the new infrastructure of
 watchdog.
Message-ID: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patchset:
    (1)Try to fix an issue about min and max timeout validity check:
    when max_hw_heartbeat_ms is defined, this check should be skipped.

    (2)Use max_hw_heartbeat_ms instead of max_timeout in SBSA watchdog.

    (3)Set WDOG_HW_RUNNING, when SBSA watchdog is already running before
    it's initialized.

Changelog:
v1: The first formal upstreaming version

RFC: https://lkml.org/lkml/2016/5/3/145

Pratyush Anand (3):
  watchdog: skip min and max timeout validity check when
    max_hw_heartbeat_ms is defined
  sbsa_gwdt: Use max_hw_heartbeat_ms instead of max_timeout
  sbsa_gwdt: Set WDOG_HW_RUNNING, when watchdog is already running.

 drivers/watchdog/sbsa_gwdt.c     | 6 ++++--
 drivers/watchdog/watchdog_core.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.5.5
