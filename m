From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Wed, 25 Jan 2017 17:36:22 +0530
Subject: [PATCH 0/2] More ethtool support and BGX configuration changes
Message-ID: <1485345984-28163-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

These patches adds support to set queue sizes from ethtool and changes 
the way serdes lane configuration is done by BGX driver on 81/83xx 
platforms.

Sunil Goutham (2):
  net: thunderx: Support to configure queue sizes from ethtool
  net: thunderx: Leave serdes lane config on 81/83xx to firmware

 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    | 39 ++++++++-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 19 ++++-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h | 16 +++-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  | 95 ++++------------------
 4 files changed, 83 insertions(+), 86 deletions(-)

-- 
2.7.4
