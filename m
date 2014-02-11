From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 11 Feb 2014 17:37:54 +0000
Subject: [PATCH v2] ARM: asm: rename logical shift macros push pull into
 lspush lspull
In-Reply-To: <alpine.LFD.2.11.1402111159230.17677@knanqh.ubzr>
References: <1392063589-24111-1-git-send-email-victor.kamensky@linaro.org>
 <1392063589-24111-2-git-send-email-victor.kamensky@linaro.org>
 <alpine.LFD.2.11.1402101607120.17677@knanqh.ubzr>
 <20140211155437.GC3035@e103592.cambridge.arm.com>
 <alpine.LFD.2.11.1402111159230.17677@knanqh.ubzr>
Message-ID: <20140211173754.GE3035@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 12:09:35PM -0500, Nicolas Pitre wrote:
> On Tue, 11 Feb 2014, Dave Martin wrote:
> 
> > On Mon, Feb 10, 2014 at 04:30:01PM -0500, Nicolas Pitre wrote:
> > > On Mon, 10 Feb 2014, Victor Kamensky wrote:
> > > 
> > > > Renames logical shift macros, 'push' and 'pull', defined in
> > > > arch/arm/include/asm/assembler.h, into 'lspush' and 'lspull'.
> > > 
> > > I don't have any fundamental objection to the idea, except maybe for the 
> > > actual names.  I just can't come up with anything better though.  
> > 
> > For consistency with the get_byte_ stuff, how about:
> > 
> > 	push -> towards_byte_0
> > 	pull -> from_byte_0
> > 
> > That may make the purpose a little clearer, too.
> 
> I don't know if
> 
> 	mov	r0, r1, from_byte_0 #8
> 
> is that much clearer though.
> 
> > (Assuming I've got them the right way around...)
> 
> As you later noticed you got it wrong.  :-)
> Most likely because "full from" and "push towards" are common english 
> constructs.

No more so than "pull towards" and "push from".

I'll blame it on the fact that the get_byte_ macros have wrong-
endian numbering, which I didn't look at carefully enough ;)

But I think we proved that my suggestion didn't really make things
easier to understand...

Cheers
---Dave
