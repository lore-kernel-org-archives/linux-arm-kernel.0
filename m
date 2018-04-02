From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Mon, 2 Apr 2018 11:22:29 +0800
Subject: [PATCH v3 0/2] net: mvneta: improve suspend/resume
Message-ID: <20180402112229.508e1feb@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to optimize the mvneta's suspend/resume
implementation by only taking necessary actions.

Since v2:
 - keep rtnl lock when calling mvneta_start_dev() and mvneta_stop_dev()
   Thank Russell for pointing this out

Since v1:
 - unify ret check
 - try best to keep the suspend/resume behavior
 - split txq deinit into sw/hw parts as well
 - adjust mvneta_stop_dev() location

I didn't add Thomas's Ack tag to patch1, because in v2, I add new code
to split the txq deinit into two parts.

Jisheng Zhang (2):
  net: mvneta: split rxq/txq init and txq deinit into SW and HW parts
  net: mvneta: improve suspend/resume

 drivers/net/ethernet/marvell/mvneta.c | 154 ++++++++++++++++++++++++++++------
 1 file changed, 128 insertions(+), 26 deletions(-)

-- 
2.16.3
