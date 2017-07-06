From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 6 Jul 2017 09:02:10 +0200
Subject: [PATCH v2 0/3] pwm: sun4i: switch to atomic PWM
In-Reply-To: <20170706070016.asujxs3ibkqq6jzj@piout.net>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
 <20170706064922.GI16144@ulmo.fritz.box>
 <20170706070016.asujxs3ibkqq6jzj@piout.net>
Message-ID: <20170706090210.3bbfd3e6@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Jul 2017 09:00:16 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> On 06/07/2017 at 08:49:22 +0200, Thierry Reding wrote:
> > On Tue, May 30, 2017 at 09:32:06PM +0200, Alexandre Belloni wrote:  
> > > Switch to atomic PWM. The main goal is to properly wait for a period before
> > > disabling a channel to ensure the correct level is set on the output.
> > > 
> > > Changes in v2:
> > >  - fixed remaining checkpatch warnings
> > >  - split the series to ease reviews
> > >  - changed the delay handling to ensure the proper amount of time has elapsed
> > >    before disabling a channel
> > >  - dropped RDY bit handling as it doesn't have any real effect.
> > > 
> > > Alexandre Belloni (3):
> > >   pwm: sun4i: improve hardware read out
> > >   pwm: sun4i: switch to atomic PWM
> > >   pwm: sun4i: drop legacy callbacks
> > > 
> > >  drivers/pwm/pwm-sun4i.c | 263 +++++++++++++++++++++++++++---------------------
> > >  1 file changed, 148 insertions(+), 115 deletions(-)  
> > 
> > Series applied, though you could've just squashed together patches 2 and
> > 3 because they don't make sense apart.
> >   
> 
> Ok, thanks. IIRC, Boris suggested the split ;)

Yes, I did it because the diff was really hard to review.
