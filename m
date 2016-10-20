From: davem@davemloft.net (David Miller)
Date: Thu, 20 Oct 2016 14:48:51 -0400 (EDT)
Subject: [PATCH -next] net: ethernet: mediatek: use dev_kfree_skb_any
 instead of dev_kfree_skb
In-Reply-To: <1476982832-27932-1-git-send-email-weiyj.lk@gmail.com>
References: <1476982832-27932-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20161020.144851.26048248768064960.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Thu, 20 Oct 2016 17:00:32 +0000

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Replace dev_kfree_skb with dev_kfree_skb_any in mtk_start_xmit()
> which can be called from hard irq context (netpoll) and from
> other contexts. mtk_start_xmit() only frees skbs that it has
> dropped.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied.
