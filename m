From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sat, 17 Jan 2015 11:43:00 +0100
Subject: [PATCH] USB: host: ehci_atmel: Add suspend/resume support
In-Reply-To: <20150117103609.276efecf@bbrezillon>
References: <1421437274-31615-1-git-send-email-sylvain.rochet@finsecur.com>
 <20150117013442.GV3843@piout.net>
 <20150117103609.276efecf@bbrezillon>
Message-ID: <20150117104259.GA24176@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,


On Sat, Jan 17, 2015 at 10:36:09AM +0100, Boris Brezillon wrote:
> On Sat, 17 Jan 2015 02:34:42 +0100 Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > 
> > We should definitely find a way to get rid of
> > at91_suspend_entering_slow_clock() at some point in time.
> 
> Can't we just disable clocks without testing for target_state ==
> PM_SUSPEND_MEM (which is exactly what at91_suspend_entering_slow_clock
> does [1]) when entering suspend ?
> I mean, IMHO other kind of suspend should still benefit from the power
> save induced by this PLL deactivation.

I agree, but it depends on what we mean with standby vs mem, there 
should be a difference between the two sleep mode.

This behavior follows what the Atmel OHCI driver is currently doing.


> Is there such a big penalty when resuming the device if the PLL and
> peripheral clocks are disabled ?

There is a penalty, starting up a PLL takes about 500 ?s, however I 
can't decide if this is a small or a big penalty.


Sylvain
