From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 19 May 2017 18:29:34 +0100
Subject: [PATCH] arm: boot/compressed: fix decompressor header layout for
 v7-M
In-Reply-To: <CAKv+Gu-yAT+kZ_oMT_+n6_RSOKOoqkZtGYjBKq=Wwhj31BgUgQ@mail.gmail.com>
References: <20170519145959.26569-1-ard.biesheuvel@linaro.org>
 <20170519164603.GH3559@e103592.cambridge.arm.com>
 <CAKv+Gu-yAT+kZ_oMT_+n6_RSOKOoqkZtGYjBKq=Wwhj31BgUgQ@mail.gmail.com>
Message-ID: <20170519172934.GI3559@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 05:59:47PM +0100, Ard Biesheuvel wrote:
> On 19 May 2017 at 17:46, Dave Martin <Dave.Martin@arm.com> wrote:

[...]

> > Spelling it out might be more readable:
> >
> >    ARM(                 mov     r0, r0          )
> >    ARM(                 mov     r0, r0          )
> >
> >  THUMB( AR_CLASS(       sub     pc, pc, #3      ))
> >  THUMB( M_CLASS(        nop.w                   ))
> >  THUMB(                 .thumb                  )
> >  THUMB(                 b.w     1f              )
> >
> > But I guess it works either way.
> >
> 
> Indeed. Apart from the error in the second line, this sequence should
> be equivalent, but the nested macro invocations don't make it clearer
> imo.

Err, yes.  Actually I means to write

	b	1f
	mov	r0, r0

(since executing that nop before branching is presumably pointless).

Cheers
---Dave
