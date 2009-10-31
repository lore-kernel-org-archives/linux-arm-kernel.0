From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 31 Oct 2009 20:56:19 +0800
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <20091031013427.GL14091@buzzloop.caiaq.de>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
Message-ID: <f17812d70910310556r56e4bea1tb186de08827b5b33@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 31, 2009 at 9:34 AM, Daniel Mack <daniel@caiaq.de> wrote:
> Is anyone using suspend/resume with a recent git mainline kernel on PXA
> or other ARM embedded boards? My platform used to suspend and resume
> just fine on 2.6.31 but now as I rebased it, it fails the resume part.
>
> Unfortunately, I can't bisect it as the platform is not mainline yet and
> so I always have mandatory patches (without my platform won't do
> anything) on top of the git repository. Which breaks the bisect logic.
>
> What puzzles me is that I see the current raising at wakeup time, so at
> least the processor seems to resume, but I can't see any serial console
> output, just like if the kernel crashed very early after wakeup.
> 'no_console_suspend' didn't help either.
>

That will be very difficult to debug then. There are not many changes to
the suspend/resume as I can recall since 2.6.31. One suggestion if
you want to debug this is - add a dead loop at the suspicious place,
and see if you JTAG debugger can connect at that time - and of course
the PC is pointing to that dead loop to identify the point it can reach.

> Does anyone use that successfully? Any idea for possible regressions?
>
> Daniel
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
