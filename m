From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 17:34:05 +0100
Subject: CFT: move outer_cache_sync() out of line
In-Reply-To: <20150112163648.GL12302@n2100.arm.linux.org.uk>
References: <20150112163648.GL12302@n2100.arm.linux.org.uk>
Message-ID: <4576899.a2tdJxHBKo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 January 2015 16:36:48 Russell King - ARM Linux wrote:

> Theoretically, this should help overall system performance, since the
> branch predictor should be able to predict this better, but it's entirely
> possible that trying to benchmark a single workload won't be measurably
> different.
> 
> In terms of kernel size figures, this change alone saves almost 17K of
> 10MB of kernel text on my iMX6 kernels - which is bordering on
> insignificant since that's not quite a 0.2% saving.
> 
> So... right now I can't justify this change, but I'm hoping some can come
> up with some figures which shows that it benefits their workload without
> causing a performance regression for others.

>From the theory, I think it can only help to do this. I would guess that
the time spent inside of the cache_sync function dwarfs both the extra
unconditional branch you introduce and the possible misprediction, so
17K in space savings sounds like more than enough justification to just
do it.

Acked-by: Arnd Bergmann <arnd@arndb.de>
