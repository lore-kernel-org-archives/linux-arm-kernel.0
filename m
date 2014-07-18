From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 18 Jul 2014 14:08:12 -0400 (EDT)
Subject: [PATCH] ARM: zImage: add DSB and ISB barriers after relocating
 code
In-Reply-To: <53C95A14.5030300@gmail.com>
References: <1400808472-401-1-git-send-email-marc.ceeeee@gmail.com>
 <alpine.LFD.2.11.1405222155240.17310@knanqh.ubzr>
 <537EB8F2.3090401@gmail.com>
 <20140602095324.GA3855@e103592.cambridge.arm.com>
 <53C95A14.5030300@gmail.com>
Message-ID: <alpine.LFD.2.11.1407181407170.3647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jul 2014, Marc C wrote:

> Hi Dave,
> 
> My apologies for not addressing this prior to submitting my v2 of the patch.
> 
> > How is what we're trying to achieve here different from the operation
> > that needs to be done in between decompressing the kernel and jumping
> > to it?  Can't we just call cache_clean_flush?
> >
> > Except that a possibly-redundant flush of the D-cache will be done,
> > this should do exactly the right thing.
> 
> I agree - I don't see why we can't just perform a cache_clean_flush
> prior to jumping to the relocated code. It seems like a simpler and less
> error-prone solution.

Agreed.


Nicolas
