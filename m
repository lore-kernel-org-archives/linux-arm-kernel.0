From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 21 Sep 2013 11:59:43 +0200
Subject: [PATCH v2 0/2] ASoC: kirkwood: fix loss of external clock at probe
 time
Message-ID: <20130921115943.336c6ec3@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes the loss of clock when the requested clock
device is not yet initialized at probe time.

The first patch adds a -EPROBE_DEFER when the clock referenced by a
phandle is not available.

The second patch uses this feature to fix such a problem in the
kirkwood audio driver.

v2:
- return the probe defer from the clock subsystem (Marc Brown remark)

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
