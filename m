From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Apr 2018 09:31:48 +0100
Subject: [PATCH] arm64: export tishift functions to modules
In-Reply-To: <CAHmME9oa-DX721K_yRe14AbLk5-raOXEji2SWsf41UtUTP=guQ@mail.gmail.com>
References: <CAHmME9oO_5X6M3NLe2tWp=ZY5EQY17GQ6BUomHLBscMejiXTvw@mail.gmail.com>
 <20180424154055.GC25964@arm.com>
 <CAHmME9oa-DX721K_yRe14AbLk5-raOXEji2SWsf41UtUTP=guQ@mail.gmail.com>
Message-ID: <20180426083147.GB27583@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Apr 24, 2018 at 05:56:39PM +0200, Jason A. Donenfeld wrote:
> On Tue, Apr 24, 2018 at 5:40 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Apr 24, 2018 at 03:43:04PM +0200, Jason A. Donenfeld wrote:
> >> On Tue, Apr 24, 2018 at 3:34 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> > I've not run into any build issues here -- is this specifically with some
> >> > out-of-tree module?
> >>
> >> I received a bug report email about this. I'm not sure which specific
> >> module, and I assumed from the email that it was actually a result of
> >> in-tree configuration options rather than an out-of-tree module, but
> >> I'm not sure exactly. Either way, I was able to reproduce the problem
> >> by coding up a little PoC out-of-tree module, so it is certainly a
> >> real problem.
> >
> > Any chance you could share the module, please? I tried to write one but
> > the compiler just inlines the __in128 arithmetic.
> 
> Sure. I didn't save my original but just cooked a new one up and
> verified it errors out. The below will get these errors on mainline
> when compiled as a module, even as an in-tree module:

Thanks for sharing the module source, I can reproduce the issue on my
machine. Putting both the prototype and the EXPORT_SYMBOL in arm64ksyms.c
appears to resolve the issue and is my preference since these functions
shouldn't be called directly anyway. Would you be able to spin a v2 doing
that, please? I can take it as fix.

I've also queued your clang int128 patch.

Cheers,

Will
