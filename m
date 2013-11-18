From: w@1wt.eu (Willy Tarreau)
Date: Mon, 18 Nov 2013 11:52:58 +0100
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B742A@saturn3.aculab.com>
References: <8761s0cqhh.fsf@natisbad.org>
 <slrnl83jr5.49f.xiyou.wangcong@linux-6brj.site> <87y54u59zq.fsf@natisbad.org>
 <20131112083633.GB10318@1wt.eu> <87a9hagex1.fsf@natisbad.org>
 <20131112100126.GB23981@1wt.eu> <87vbzxd473.fsf@natisbad.org>
 <20131113072257.GB10591@1wt.eu> <20131117141940.GA18569@1wt.eu>
 <AE90C24D6B3A694183C094C60CF0A2F6026B742A@saturn3.aculab.com>
Message-ID: <20131118105258.GB26398@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 10:09:53AM -0000, David Laight wrote:
> > So it is fairly possible that in your case you can't fill the link if you
> > consume too many descriptors. For example, if your server uses TCP_NODELAY
> > and sends incomplete segments (which is quite common), it's very easy to
> > run out of descriptors before the link is full.
> 
> Or you have a significant number of active tcp connections.
> 
> Even if there were no requirement to free the skb quickly you still
> need to take a 'tx done' interrupt when the link is transmit rate limited.
> There are scenarios when there is no receive traffic - eg asymmetric
> routing, but testable with netperf UDP transmits.

Yes absolutely, but I was talking about the current situation that Arnaud
is facing and which I could reproduce with a large window.

Willy
