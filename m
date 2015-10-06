From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 6 Oct 2015 09:33:23 +0200
Subject: [PATCH v4 4/4] misc: atmel_tclib: get and use slow clock
In-Reply-To: <20151005165816.GI2694@piout.net>
References: <1439717026-30634-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
 <20151005152706.GC17612@ulmo> <20151005165816.GI2694@piout.net>
Message-ID: <20151006073323.GA18633@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 06:58:16PM +0200, Alexandre Belloni wrote:
> On 05/10/2015 at 17:27:06 +0200, Thierry Reding wrote :
> > On Sun, Aug 16, 2015 at 11:23:46AM +0200, Alexandre Belloni wrote:
> > > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > 
> > > Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> > > hang") added a workaround for the slow clock as it is not properly handled
> > > by its users.
> > > 
> > > Get and use the slow clock as it is necessary for the timer counters.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: linux-pwm at vger.kernel.org
> > >  drivers/clocksource/tcb_clksrc.c | 10 +++++++++-
> > >  drivers/misc/atmel_tclib.c       |  4 ++++
> > >  drivers/pwm/pwm-atmel-tcb.c      | 26 +++++++++++++++++++-------
> > >  include/linux/atmel_tc.h         |  1 +
> > >  4 files changed, 33 insertions(+), 8 deletions(-)
> > 
> > This doesn't seem to apply anymore. Does it need to be rebased? Or do I
> > need some other patch as a dependency?
> > 
> 
> It will apply cleanly after [PATCH v4 3/4] clocksource: tcb_clksrc: fix
> setup_clkevents error path
> 
> It already has Daniel's ack so you can also take it if you want. Else,
> we can take it through at91.

Might be best to take it all into the at91 tree, so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/a6966e61/attachment-0001.sig>
