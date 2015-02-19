From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 19 Feb 2015 08:39:53 +0000
Subject: [PATCH 0/2] regmap: fix range checks in _regmap_raw_read/write()
Message-ID: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches attempts to fix range checks in _regmap_raw_read()
and _regmap_raw_write() functions. Without these patches I hit kernel
crash when I attempt to dump the mmio regmap range using regmap_bulk_read().


Srinivas Kandagatla (2):
  regmap: Add range check in _regmap_raw_read()
  regmap: Add range check in _regmap_raw_write()

 drivers/base/regmap/regmap.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
1.9.1
