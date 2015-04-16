From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 15 Apr 2015 21:30:57 -0700
Subject: [Xen-devel] "tcp: refine TSO autosizing" causes performance
 regression on Xen
In-Reply-To: <20150416042005.GA12179@gondor.apana.org.au>
References: <20150416042005.GA12179@gondor.apana.org.au>
Message-ID: <1429158657.7346.160.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-04-16 at 12:20 +0800, Herbert Xu wrote:
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> > We already have netdev->gso_max_size and netdev->gso_max_segs
> > which are cached into sk->sk_gso_max_size & sk->sk_gso_max_segs
> 
> It is quite dangerous to attempt tricks like this because a
> tc redirection or netfilter nat could change the destination
> device rendering such hints incorrect.

Right but we are talking of performance hints, on quite basic VM setup.

Here the guest would use xen and this hint would apply.
