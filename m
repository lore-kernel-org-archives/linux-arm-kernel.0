From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Mar 2013 10:04:08 +0000
Subject: [PATCH] ARM: timer: Shutdown clock event device when stopping
 local timer
In-Reply-To: <CAH3Oq6QA0DCEDc-Yh+k=3bgUH7xzKxHSC1aWSoL4NzaYCZZHbg@mail.gmail.com>
References: <1364549049-29278-1-git-send-email-ning.n.jiang@gmail.com>
 <5155DE43.4000601@codeaurora.org>
 <CAH3Oq6QA0DCEDc-Yh+k=3bgUH7xzKxHSC1aWSoL4NzaYCZZHbg@mail.gmail.com>
Message-ID: <20130330100408.GA17995@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 30, 2013 at 05:57:38PM +0800, Ning Jiang wrote:
> 2013/3/30 Stephen Boyd <sboyd@codeaurora.org>:
> > On 03/29/13 02:24, ning.n.jiang at gmail.com wrote:
> >> From: Ning Jiang <ning.n.jiang@gmail.com>
> >>
> >> Currently there are two problems when we try to stop local timer.
> >> First, it calls set_mode function directly so mode state is not
> >> updated for the clock event device. Second, it makes the device
> >> unused instead of shutdown.
> >
> > What device is this a problem on? I believe this only matters to drivers
> > which enable their timer in their set_next_event() callback? But even
> > then, does anything actually happen because the interrupt should have
> > been disabled in the local timer stop callback.
> >
> 
> Right. Drivers which enable timer in set_next_event() will have this problem.
> It will not have functional problem in my case. But my device cannot enter
> low power mode with a pending interrupt even if it is disabled.

You're not telling us what you have discovered.  How does set_next_event()
get called after we've set the mode to UNUSED in the current code?
