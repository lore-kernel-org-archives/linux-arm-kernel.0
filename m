From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 16 Apr 2015 12:20:06 +0800
Subject: [Xen-devel] "tcp: refine TSO autosizing" causes performance
 regression on Xen
In-Reply-To: <1429121867.7346.136.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <20150416042005.GA12179@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> We already have netdev->gso_max_size and netdev->gso_max_segs
> which are cached into sk->sk_gso_max_size & sk->sk_gso_max_segs

It is quite dangerous to attempt tricks like this because a
tc redirection or netfilter nat could change the destination
device rendering such hints incorrect.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
