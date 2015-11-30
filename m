From: davem@davemloft.net (David Miller)
Date: Sun, 29 Nov 2015 22:52:14 -0500 (EST)
Subject: [PATCH net] drivers: net: xgene: fix possible use after free
In-Reply-To: <1448470930.24696.10.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1448468256.24696.5.camel@edumazet-glaptop2.roam.corp.google.com>
 <20151125163402.GA29094@leverpostej>
 <1448470930.24696.10.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <20151129.225214.564332641043989256.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 25 Nov 2015 09:02:10 -0800

> From: Eric Dumazet <edumazet@google.com>
> 
> Once TX has been enabled on a NIC, it is illegal to access skb,
> as this skb might have been freed by another cpu, from TX completion
> handler.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>

Applied, thanks Eric.
