From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Sep 2013 10:20:00 -0700
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a7791 SoC support
In-Reply-To: <CANqRtoQ0dnG6HwjJSrK8+Qt8wvJhqsJHxgj-LGvnJvS0KT81nw@mail.gmail.com>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034557.12546.97503.sendpatchset@w520>
 <CACRpkdb7QkqCmTMua1yJNJxSAWff=0f6a2SWkf6K9SqbW0BOVg@mail.gmail.com>
 <CANqRtoQzLKk3EKcm=EiZCg73fgDBZ1xjPi_6fH_PsGdkr6w5sA@mail.gmail.com>
 <CACRpkdZGLR3=UZ7f-9r02Gea2hTomp+6+bz0BDQOvk9zRHTxxw@mail.gmail.com>
 <CANqRtoQ0dnG6HwjJSrK8+Qt8wvJhqsJHxgj-LGvnJvS0KT81nw@mail.gmail.com>
Message-ID: <20130918172000.GA27340@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Coming across this somewhat old email thread, apologies for the delay in
response.

On Mon, Sep 09, 2013 at 05:05:18PM +0900, Magnus Damm wrote:
> On Mon, Sep 9, 2013 at 4:45 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Sep 9, 2013 at 9:21 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >
> >> Fortunately there are plans to convert several mach-shmobile SoCs to
> >> common clocks over the next 6 months. As you know, we spent much time
> >> and efforts converting to pinctrl last two 6 month periods, and now we
> >> will be targeting common clocks.
> >
> > I trust you on this, it's not for me to decide but for the ARM SoC
> > maintainers. I think Arnd basically said at one point that it is OK
> > to add some new cruft as long as you remove more old cruft at
> > the same time, so I guess you will have to make an argument that
> > this is happening.
> 
> Yeah, I agree. I hope to discuss this in person later this Autumn.
> 
> >> There are several incremental patches available for r8a7791, but since
> >> this is a new and rare platform it won't be the first SoC we convert
> >> to common clocks. So CCF development will happen on r8a7791, but it
> >> won't be the first platform.
> >
> > This is pretty much the inverse argument of the usual stance of
> > the ARM SoC tree - usually we ask that new platforms should use
> > new frameworks. I do understand it from a practical point of view,
> > that new SoCs only exist in few prototypes.
> 
> I suppose negotiation has to happen on some level, and I appreciate
> the higher level give-and-take approach that Arnd has been taking. At
> this time though, apart from common clocks, extended DT support and
> multiplatform I'm not so sure what desired cleanup-wise.

We have definitely been OK with new code going in together with cleanups,
but I think we're reaching a point where there's a lot of new code going
in on shmobile platforms now, and we've had some growing pains on the
platform for it -- conflicts with other maintainer trees because they have
picked up board file changes, etc.

I think much of this wouldn't be a problem if the conversions to
DT/multiplatform was completed, so it would be great if the conversion
could be given priority on the Renesas side, especially given the rate
of new additions as of late -- I think we're seeing new SoCs almost
every release cycle as of late.

So, bottom line: I'm not going to refuse taking this new platform,
but you're close to the limits and please try to prioritize finishing
conversion.  In particular since all this "new legacy code" you're adding
will all have to be converted soon -- in some cases it might be better
to wait with adding it until after conversion.


-Olof
