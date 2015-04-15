From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 16:17:31 +0200
Subject: [PATCH net-next 3/6] net: hip04: Solve the problem of the skb
 memory allocation failure
In-Reply-To: <1429101008-9464-4-git-send-email-dingtianhong@huawei.com>
References: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
 <1429101008-9464-4-git-send-email-dingtianhong@huawei.com>
Message-ID: <2443005.XhuHWvJbTU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 April 2015 20:30:05 Ding Tianhong wrote:
> The driver will alloc some skb buffer for hareware queue, but without
> considering the case of memory allocation failure, when memory is low,
> the skb may be null and panic the system, so break the loop when skb is
> null and try to alloc the memory again to fix this problem.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Joe Perches <joe@perches.com>
> 

Looks reasonable to me, though I haven't done a deep analysis
to see if there are remaining problems in this area.

	Arnd
