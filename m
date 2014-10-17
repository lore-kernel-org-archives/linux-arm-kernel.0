From: benjamin.poirier@gmail.com (Benjamin Poirier)
Date: Fri, 17 Oct 2014 13:55:30 -0700
Subject: Regarding tx-nocache-copy in the Sheevaplug
In-Reply-To: <20141016174628.GL1972@vicerveza.homeunix.net>
References: <20141013105246.GD1972@vicerveza.homeunix.net>
 <20141015215701.GA4109@f1.synalogic.ca>
 <1413413127.17186.5.camel@edumazet-glaptop2.roam.corp.google.com>
 <20141016173401.GA16515@f1.synalogic.ca>
 <20141016174628.GL1972@vicerveza.homeunix.net>
Message-ID: <20141017205530.GA7367@f1.synalogic.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/10/16 19:46, Llu?s Batlle i Rossell wrote:
[...]
> 
> Hello all,
> 
> it seems I was a bit wrong - although enabling back tx-nocache-copy makes the
> tx-errors happen much less often (ssh complaining about HMAC), they still
> happen. It seems that something was introduced in some recent kernels that broke
> the tx offload.
> 
> I have no idea what it can be, but since 2.6 until at least 3.10 the network
> driver worked fine with tx offload in this sheevaplug board.

It's not the most pleasant alternative but if you can be sure enough
whether the problem is occurring or not, you could try bisecting,
possibly limiting the bisection to mv643xx

$ git bisect start v3.16.3 v3.10 -- drivers/net/ethernet/marvell/mv643xx_eth.c
Bisecting: 16 revisions left to test after this (roughly 4 steps)

The problem might be outside of the driver though.
