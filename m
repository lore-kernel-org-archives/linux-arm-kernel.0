From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 19 May 2017 18:38:33 +0100
Subject: [PATCH] arm: boot/compressed: fix decompressor header layout for
 v7-M
In-Reply-To: <20170519173400.GJ3559@e103592.cambridge.arm.com>
References: <20170519145959.26569-1-ard.biesheuvel@linaro.org>
 <20170519164603.GH3559@e103592.cambridge.arm.com>
 <CAKv+Gu-yAT+kZ_oMT_+n6_RSOKOoqkZtGYjBKq=Wwhj31BgUgQ@mail.gmail.com>
 <67bd95eb-1f4b-d9d2-9a68-3574d03ac072@arm.com>
 <20170519173400.GJ3559@e103592.cambridge.arm.com>
Message-ID: <20170519173832.GL3559@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 06:34:01PM +0100, Dave Martin wrote:
> On Fri, May 19, 2017 at 06:16:36PM +0100, Robin Murphy wrote:

[...]

> > Hmm, couldn't it be ISA-agnostic?
> > 
> > 	ldr pc, 1f
> > 	.ltorg
> > THUMB(	.thumb	)
> > 	...
> > 
> > given that that should be interworking on anything where THUMB() is
> > valid in the first place.
> 
> Did you mean
> 
> 	ldr	pc, =BSYM(1f)
> ?
> 
> Otherwise this is quite neat: providing there are no pending literals
> when the assembler reaches the ldr pc, and providing that the ldr pc is
> word-aligned (it certainly should be) then that sequence should always
> expand to two words.

Modulo Ard's comment about position-independence...  Curses.

Cheers
---Dave
