From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Oct 2011 11:13:21 +0200
Subject: [PATCH v2 1/5] ARM: SPMP8000: Add machine base files
In-Reply-To: <CAGVye5PR3rDbGOf48sPtnZHJXPCa_eY1JqeUZKyeLGk4s_LNHA@mail.gmail.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1409922.Ostx0EbfK3@wuerfel>
	<CAGVye5PR3rDbGOf48sPtnZHJXPCa_eY1JqeUZKyeLGk4s_LNHA@mail.gmail.com>
Message-ID: <201110241113.21837.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 October 2011, Zoltan Devai wrote:
> 2011/10/19 Arnd Bergmann <arnd@arndb.de>:
> > On Wednesday 19 October 2011 18:01:54 Zoltan Devai wrote:
> >> Files needed for the basic machine support of SPMP8000
> >>
> >> Signed-off-by: Zoltan Devai <zoss@devai.org>
> >
> > Hi Zoltan,
> >
> > This version looks very nice, only a few small things remain that I noticed
> > reading through it again:
> OK, will correct these.
> 
> What's next then ?

We talked about it at the ARM subarchitecture maintainer summit, and I think
I'll just merge your platform code for 3.2 if you send the fixed version
in time. I'm not going to merge your clk support patch (2/5) though, since
there is a lot of work going into the common clk framework right now, and
I don't want to cause more work going into rewriting your code.

Please instead replace that patch with a stubbed-out version that builds
but doesn't actually do anything. Obviously you won't be able to run on
actual hardware then but you still have the patch you did and know how to
apply it for testing ;-). 

> I assume I'd need some more review on at least the dts file.

It seems all good to me, but I would definitely appreciate Grant and Rob
to take a closer look.

> Also, can the timer code go through your tree into drivers/clocksource ?

It can, but it needs an Acked-by from John and/or Thomas in that case.
Alternatively, feel free to stick my acked-by on the patch and have
Thomas handle the patch.

	Arnd
