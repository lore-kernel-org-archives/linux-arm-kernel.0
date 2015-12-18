From: pablo@netfilter.org (Pablo Neira Ayuso)
Date: Fri, 18 Dec 2015 21:37:17 +0100
Subject: [PATCH] ila: add NETFILTER dependency
In-Reply-To: <20151218180931.GC29573@breakpoint.cc>
References: <2011239.T7zzuZGeyk@wuerfel> <20151218172606.GB1299@salvia>
 <20151218180931.GC29573@breakpoint.cc>
Message-ID: <20151218203717.GA14846@salvia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 07:09:31PM +0100, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > I'm afraid this extra Kconfig dependency that Arnd adds to fix this is
> > a symptom that there is something that doesn't belong there.
> > 
> > I overlook this new hook on priority -1, how does this integrate into
> > our infrastructure?
> 
> Looks problematic since address changes post ipv6 dnat translations,
> its certainly unexpected for nft since we have magic address mangling
> after -2 and 0 priroized tables...

David indicated that this should be sort of transparent and integrated
into separated infrastructure.

The existing hook will break IPv6 conntrack and NAT for us, and the
extra hook is suboptimal as it

I'd suggest you add a static key and specific hook before netfilter to
deal with this.
