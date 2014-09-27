From: daniel@zonque.org (Daniel Mack)
Date: Sat, 27 Sep 2014 20:08:51 +0200
Subject: pxa-dt and multiple platforms support
In-Reply-To: <877g0pc5g6.fsf@free.fr>
References: <877g0pc5g6.fsf@free.fr>
Message-ID: <5426FD33.8080404@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 09/27/2014 07:56 PM, Robert Jarzmik wrote:
> When you added support for device-tree for pxa3xx, in commit "ARM: pxa3xx: add
> generic DT machine code" (e7749a2) you wrote : "This file can be extended to
> also support pxa2xx".
> 
> I was wondering is that is really possible with the current pxa status, because
> :
>  - you have to include mach/pxa3xx.h
>    => this includes mach/pxa3xx-regs.h
>    => this is specific to pxa3xx architecture
> 
> If I add pxa27x support into the same file, I'll have to include mach/pxa27x.h
> (because the initialization functions are there, same reason as yours for
> mach/pxa3xx-regs.h).
>    => this includes mach/pxa2xx-regs.h
>    => this is specific to pxa2xx architecture
> 
> Of course there will be a lot of defines conflicts, as both platforms share the
> same register names ...
> 
> So did you have something specific in mind, or should I rename pxa-dt.c into
> pxa3xx-dt.c, and create pxa27-dt.c (this last option is my current choice unless
> a better ideas emerges) ?

I think the latter is fine for now. I certainly didn't work on pxa27x DT
bits yet.


Thanks,
Daniel
