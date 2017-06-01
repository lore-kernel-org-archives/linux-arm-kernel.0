From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 1 Jun 2017 17:52:06 +0100
Subject: [PATCH 3/4] arm64/kasan: don't allocate extra shadow memory
In-Reply-To: <CACT4Y+aCKDF95mK2-nuiV0+XineHha3y+6PCW0-EorOaY=TFng@mail.gmail.com>
References: <20170601162338.23540-1-aryabinin@virtuozzo.com>
 <20170601162338.23540-3-aryabinin@virtuozzo.com>
 <20170601163442.GC17711@leverpostej>
 <CACT4Y+aCKDF95mK2-nuiV0+XineHha3y+6PCW0-EorOaY=TFng@mail.gmail.com>
Message-ID: <20170601165205.GA8191@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 06:45:32PM +0200, Dmitry Vyukov wrote:
> On Thu, Jun 1, 2017 at 6:34 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Jun 01, 2017 at 07:23:37PM +0300, Andrey Ryabinin wrote:
> >> We used to read several bytes of the shadow memory in advance.
> >> Therefore additional shadow memory mapped to prevent crash if
> >> speculative load would happen near the end of the mapped shadow memory.
> >>
> >> Now we don't have such speculative loads, so we no longer need to map
> >> additional shadow memory.
> >
> > I see that patch 1 fixed up the Linux helpers for outline
> > instrumentation.
> >
> > Just to check, is it also true that the inline instrumentation never
> > performs unaligned accesses to the shadow memory?
> 
> Inline instrumentation generally accesses only a single byte.

Sorry to be a little pedantic, but does that mean we'll never access the
additional shadow, or does that mean it's very unlikely that we will?

I'm guessing/hoping it's the former!

Thanks,
Mark.
