From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Dec 2011 10:57:08 +0000
Subject: [RFC PATCH] ARM: Fix the bug in dcache flush all API.
In-Reply-To: <CAJ7qFScn07xH2t_PSH2jSPG+4NLed7sptWy=UV8Whv=hKgdLRA@mail.gmail.com>
References: <1324026157-32628-1-git-send-email-r.sricharan@ti.com>
 <20111216103830.GA30477@mudshark.cambridge.arm.com>
 <CAJ7qFScn07xH2t_PSH2jSPG+4NLed7sptWy=UV8Whv=hKgdLRA@mail.gmail.com>
Message-ID: <20111216105707.GC30477@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 10:52:48AM +0000, R, Sricharan wrote:
>     When we work out the shift to extract the cache type bits it will go wrong
>     once we hit the 4th iteration (r10 == 6) because we'll calculate a shift of
>     10 instead of 9.
> 
> 
>         add     r2, r10, r10, lsr #1            @ work out 3x current cache
> level
>         mov     r1, r0, lsr r2                  @ extract cache type bits from
> clidr
>        
>          Here when r10=6, then r2 will be 9 , which is correct shift ?

Yes, of course, I'm on my second coffee now. I still think the line size
calculation is plain wrong though (should be 1 << (ls + 2) instead of (ls +
4)).

I'll take another look@your patch.

Will
