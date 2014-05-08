From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 08 May 2014 15:15:23 -0700
Subject: omap4-panda-es boot issues with v3.15-rc4
In-Reply-To: <20140508184055.GC2198@atomide.com> (Tony Lindgren's message of
 "Thu, 8 May 2014 11:40:56 -0700")
References: <536B7E44.2040303@ti.com> <7hppjos2w2.fsf@paris.lan>
 <CAGa+x84VB3CXDm71JWxHx1-Qk1xVNeXdwUjZnb42_wg+piOzzA@mail.gmail.com>
 <20140508165558.GB2198@atomide.com>
 <20140508184055.GC2198@atomide.com>
Message-ID: <7hha4zsyro.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

[...]

> ..but I think I found the cause for recent hangs on panda, just a wild
> guess based on looking at the recent cpuidle patches after v3.14.
>
> Looks like reverting 0b89e9aa2856 (cpuidle: delay enabling interrupts
> until all coupled CPUs leave idle) makes booting work reliably again
> on panda.
>
> Can you guys confirm, so far no issues here after few boot tests,
> but it might be too early to tell.

Reverting that makes things a bit more stable, but it still eventually
fails in the same way.  For me it took 8 boots for it to eventually
fail.

However, if I build with CONFIG_CPU_IDLE=n, it becomes much more stable
(20+ boots in a row and still going.)

Kevin
