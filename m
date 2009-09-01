From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 1 Sep 2009 23:48:57 +0200
Subject: [RFC/RFT 1/3] iop: clocksource support
In-Reply-To: <19101.33037.189854.375398@pilspetsen.it.uu.se>
References: <200908221204.n7MC4t2v029350@pilspetsen.it.uu.se>
	<63386a3d0908241607t4546b488oa19f43fbbef0ade5@mail.gmail.com>
	<19101.33037.189854.375398@pilspetsen.it.uu.se>
Message-ID: <63386a3d0909011448k6f221118k81cc7d993c65ac20@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/1 Mikael Pettersson <mikpe@it.uu.se>:

> ?> Calculate this using the algorithm in arch/mips/kernel/time.c
> ?> they have a dynamically changing clocksource...
>
> The algorithm always computes the largest shift/mult pair that
> solves the equation:
>
> ? ? ? ?// 0 <= shift && shift <= 32
> ? ? ? ?u64 mult = ((u64)1E9 << shift) / hz;
> ? ? ? ?(mult >> 32) == 0
>
> Can I assume that this is to minimize precision loss?

So I think, I asked the question of how to calculate div but noone
answered IIRC, then I found the MIPS code and it contained this
clue. Ralf Baechle from the MIPS camp wrote this code so lets
ask him.

Linus Walleij
