From: Russ.Dill@ti.com (Russ Dill)
Date: Thu, 29 Aug 2013 11:28:17 -0700
Subject: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
In-Reply-To: <20130829180353.GP10783@sirena.org.uk>
References: <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 <20130829110534.GV10783@sirena.org.uk>
 <CAGa+x85u0OpB9o71xUTs15wt8Te-o5f0C9o22GHzZwOjn5F6=w@mail.gmail.com>
 <20130829154929.GJ10783@sirena.org.uk>
 <CA+Bv8XYbpqQAYwJ3=vkP0gXDMTp7_VNVzB0NXLG6GHDi=Z1img@mail.gmail.com>
 <20130829173022.GN10783@sirena.org.uk>
 <CA+Bv8Xb38bwby78Q--nEGffBknj5ZD98x0OuRX5N1EFNjbh7zA@mail.gmail.com>
 <20130829180353.GP10783@sirena.org.uk>
Message-ID: <CA+Bv8XaquSBKUpDbVZwcGEbmDB2Lw1ZaZu3gSU4FnG9qBKTViA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 11:03 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 29, 2013 at 10:47:04AM -0700, Russ Dill wrote:
>> On Thu, Aug 29, 2013 at 10:30 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > So this is done from cpuidle rather than system suspend.
>
>> It is done for system suspend. It isn't possible to do this in a
>> cpuidle use case as the memory controller would need to come out of
>> idle automatically to service DMA requests.
>
> OK, so it's all part of the core power down sequence for the SoC?  I'm
> not sure that makes a big difference but it at least means that there
> are fewer runtime interactions to worry about.

 Well, core suspend sequence for the SoC.

>> > I mean describe the intended sequence of events in the system rather
>> > than the raw register commands to accomplish them.
>
>> I'm still not sure what you mean.
>
> Say "set voltage X" or even "regulator X supplies Y" not "send this
> bytestream to the device".

That's already known at the SoC level, "set the vdd core regulator to
0.95V". What isn't known is how to do that for each board.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
