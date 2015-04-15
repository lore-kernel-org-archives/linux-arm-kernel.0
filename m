From: dingtianhong@huawei.com (Ding Tianhong)
Date: Wed, 15 Apr 2015 20:30:02 +0800
Subject: [PATCH net-next 0/6] net: hip04: fix some problem for hip04 drivers
Message-ID: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches series was used to fix the issues of the hip04 driver, and added
some optimizations according to some good suggestion. 

Thanks.

Ding Tianhong (6):
  net: hip04: Set more appropriate value for tx coalesce num
  net: hip04: use the big endian for tx and rx desc
  net: hip04: Solve the problem of the skb memory allocation failure
  net: hip04: Don't free the tx skb when the buffer is not ready for
    xmit
  net: hip04: remove the unnecessary check
  net: hip04: add ratelimit for rx/tx drops skb

 drivers/net/ethernet/hisilicon/hip04_eth.c | 109 ++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 33 deletions(-)

-- 
1.8.0
