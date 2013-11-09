From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Nov 2013 00:01:23 +0000
Subject: [PATCH] ARM: Support arch_irq_work_raise() via self IPIs
In-Reply-To: <527D7621.2000105@codeaurora.org>
References: <526DBEAA.4030707@linaro.org>
 <1382984701-2371-1-git-send-email-sboyd@codeaurora.org>
 <878uxcq1m7.fsf@linaro.org> <20131029060058.GD21983@codeaurora.org>
 <CAOesGMhjC=NDn4YiY4tQ3ZcW_rK9_qOY03CVD1eyVFC74ucdrA@mail.gmail.com>
 <CAOesGMhB2Akf_B2_J3LVdt1bDvcsTE7+8Kq=NvsXmkf3EwGsiw@mail.gmail.com>
 <527D5D5C.2080409@codeaurora.org>
 <CAOesGMhyPaMUs3XJshqZ-KYhtWhenttq7qDpF0+4dQ9PvBYVGA@mail.gmail.com>
 <527D7621.2000105@codeaurora.org>
Message-ID: <20131109000123.GV16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 03:39:13PM -0800, Stephen Boyd wrote:
> On 11/08/13 15:35, Olof Johansson wrote:
> > On Fri, Nov 8, 2013 at 1:53 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >>
> >> Ah yes. We don't have IPI support on UP kernels but SMP_ON_UP exposes
> >> arch_irq_work_raise(). How about this? We should just skip this function
> >> if we're running on UP.
> > Yep.
> >
> > Tested-by: Olof Johansson <olof@lixom.net>
> >
> > Send it to Russell's tracker, plz.
> >
> 
> Thanks. 7887/1.

It's probably going to miss Stephen's pull from my tree this evening (if
he even does one) so... that gives me two options: either drop the original
commit or apply this.

I think I'll apply this and put it in place just after the original commit
which caused the breakage.

Thanks.
