From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu,  9 Mar 2017 15:27:10 +0000
Subject: [PATCH 0/2] coresight: Allow sharing of STM
Message-ID: <1489073232-5093-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes the coresight generic layer to handle the reference
counting for the STM source properly, to allow multiple applications
to share the STM. Without this series, the STM is disabled when the
first user closes its connection, causing trace data losses.

Suzuki K Poulose (2):
  coresight: Disable the path only when the source is disabled
  coresight: Fix reference count for software sources

 drivers/hwtracing/coresight/coresight.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.7.4
