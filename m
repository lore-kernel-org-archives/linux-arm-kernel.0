From: davem@davemloft.net (David Miller)
Date: Wed, 20 Nov 2013 13:52:21 -0500 (EST)
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: <1384968607.10637.14.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1384710098.8604.58.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131120171227.GG8581@1wt.eu>
 <1384968607.10637.14.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <20131120.135221.974195642039657856.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 20 Nov 2013 09:30:07 -0800

> max (128KB , 1-2 ms) of buffering per flow should be enough to reach
> line rate, even for a single flow, but this means the sk_sndbuf value
> for the socket must take into account the pipe size _plus_ 1ms of
> buffering.

And we can implement this using the estimated pacing rate.
