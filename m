From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 22 Mar 2018 15:44:56 -0700
Subject: [PATCH] arm/arm64: smccc: Use xN for arm64 register constraints
 with clang
In-Reply-To: <CAKwvOdk4Tos1Q8dyQvic4PUX3cjy3q1hn3FkK=xiVSChht+gEg@mail.gmail.com>
References: <20180322212705.141175-1-mka@chromium.org>
 <CAKwvOdk4Tos1Q8dyQvic4PUX3cjy3q1hn3FkK=xiVSChht+gEg@mail.gmail.com>
Message-ID: <20180322224456.GB78232@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Thu, Mar 22, 2018 at 10:26:18PM +0000 Nick Desaulniers ha dit:

> Note that a patch in this form has previously been implemented by:
> 
> Andrey Konovalov <andreyknvl@google.com>:
> https://gist.github.com/xairy/ee11682ea86044a45c0291c528cd936f
> 
> and another by:
> 
> Greg Hackmann <ghackmann@google.com>:
> https://android-review.googlesource.com/c/kernel/common/+/645181
> 
> If you used either as a reference, you may want to credit them with a
> `Suggested-by:` in the commit message.

Not really, but I think I prefer Greg's version over mine and might
use it in a respin if nobody raises objections.

> On Thu, Mar 22, 2018 at 2:28 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > +#ifndef __clang__
> > +#define __reg__ "r"
> > +#else
> > +#define __reg__ "x"
> > +#endif
> 
> Can this be flipped to #ifdef __clang__ ?  having an if...else where the
> conditional negated is kind of funny.

Sure, my thought was "common case first", but I agree that the negated
condition isn't ideal either.
