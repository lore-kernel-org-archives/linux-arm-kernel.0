From: davem@davemloft.net (David Miller)
Date: Fri, 30 Mar 2018 12:28:11 -0400 (EDT)
Subject: [PATCH] net: mvneta: remove duplicate *_coal assignment
In-Reply-To: <20180329172940.4a5f592c@xhacker.debian>
References: <20180329172940.4a5f592c@xhacker.debian>
Message-ID: <20180330.122811.462608073364510854.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Thu, 29 Mar 2018 17:29:40 +0800

> The style of the rx/tx queue's *_coal member assignment is:
> 
> static void foo_coal_set(...)
> {
> 	set the coal in hw;
> 	update queue's foo_coal member; [1]
> }
> 
> In other place, we call foo_coal_set(pp, queue->foo_coal), so the above [1]
> is duplicated and could be removed.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied.

We could make this convention even more explicit by not passing
the coalescing parameter into these helpers, but instead using
the value in rxq->foo and txq->foo.
