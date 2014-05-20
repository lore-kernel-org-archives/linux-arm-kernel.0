From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 May 2014 18:55:28 +0100
Subject: [PATCH 1/7] mfd: twl4030-power: Fix hang on reboot if sleep
 configuration was loaded earlier
In-Reply-To: <20140520174827.GF27830@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-2-git-send-email-tony@atomide.com>
 <20140520150119.GW24991@lee--X1>
 <20140520150748.GD27830@atomide.com>
 <20140520173705.GA1458@lee--X1>
 <20140520174827.GF27830@atomide.com>
Message-ID: <20140520175528.GB1458@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > > Looks like we can still hit the issue of wrong load order of
> > > > > twl4030 configuration. If we have a sleep configuration loaded,
> > > > > and do a warm reset, the device can hang while initializing the
> > > > > wakeup12 sequence. We do have a warning message about wrong order
> > > > > of twl4030 configuration, but in this case it does not help as
> > > > > the sleep configuration was loaded during the previous boot and
> > > > > the state of twl4030 is maintained throughout the warm reset.
> > > > > 
> > > > > Fix the issue by clearing any existing sleep configuration
> > > > > before we load the warm reset configuration.
> > > > > 
> > > > > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > > ---
> > > > >  drivers/mfd/twl4030-power.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > Can't vouch for the semantics of the patch, but the code looks good.
> > > > 
> > > >   Acked-by: Lee Jones <lee.jones@linaro.org>
> > > > 
> > > > Can I just apply this, or would you like Peter to review it first?
> > > 
> > > As far as I'm concerned you can go ahead an apply, it's been
> > > floating on the list for a while and Peter is probably busy
> > > with other things.
> > 
> > No problem.  Just a couple of things for you to look at in the other
> > patches, then we can go ahead and apply for v3.16.
> 
> OK thanks yeah saw those. Will fix them up and test today. Then
> maybe you can apply them to the immutable branch we set earlier
> or I can send you a pull request against that branch whichever
> you prefer.

Probably be easier if I update and re-tag the original one.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
