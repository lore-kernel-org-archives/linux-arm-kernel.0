From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 30 Mar 2018 18:33:32 +0800
Subject: [PATCH v2 0/2] net: mvneta: improve suspend/resume
Message-ID: <20180330183332.3e180a1a@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to optimize the mvneta's suspend/resume
implementation by only taking necessary actions.

Since v1:
 - unify ret check
 - try best to keep the suspend/resume behavior
 - split txq deinit into sw/hw parts as well
 - adjust mvneta_stop_dev() location

I didn't add Thomas's Ack tag to patch1, because in v2, I added new code
to split the txq deinit into two parts.

Jisheng Zhang (2):
  net: mvneta: split rxq/txq init and txq deinit into SW and HW parts
  net: mvneta: improve suspend/resume

 drivers/net/ethernet/marvell/mvneta.c | 156 +++++++++++++++++++++++++++-------
 1 file changed, 127 insertions(+), 29 deletions(-)

-- 
2.16.3
