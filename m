From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 15 Mar 2012 10:21:34 +0100
Subject: [PATCH v4 09/10] pwm: Add PXA support
In-Reply-To: <20120315090540.GW3852@pengutronix.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-10-git-send-email-thierry.reding@avionic-design.de>
 <4F61343A.80103@gmail.com>
 <20120315065631.GB20502@avionic-0098.mockup.avionic-design.de>
 <20120315090540.GW3852@pengutronix.de>
Message-ID: <20120315092134.GA29841@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sascha Hauer wrote:
> On Thu, Mar 15, 2012 at 07:56:31AM +0100, Thierry Reding wrote:
> > Actually I wasn't planning on keeping this patch at all. Sascha already has
> > the existing PWM providers converted to his original framework and offered to
> > rebase them onto this series once the dust settles. I only used them as
> > testbed to see how the driver interface works out for different hardware. But
> > I also think that if Sascha hasn't cleaned the driver up yet it should either
> > be done in his conversion patches or as follow ups.
> 
> All I have is a simple conversion to the new framework, nothing more.  I
> rebased my patches yesterday onto this series (unfortunately due to the
> additional argument pwm_device the patches do not look like just moving
> the drivers anymore). I also skipped the PXA patch since I saw that you
> already have this one. I just posted the patches to the list.

Okay, I'll keep my Blackfin and PXA converted drivers then and will fix the
issues with the PXA driver brought up by Ryan. Would you be okay if I took
your conversion patches and added them to my series? I was trying to avoid
the additional work but I think it might make things easier if they are part
of the same series.

> > Sascha: how do you plan on going forward with this? It seems like the driver
> > interface is pretty much done now and I expect the next round to be the last,
> > unless I forget to properly work through the TODO list again. If you are busy
> > with other stuff I can probably find some time to help with porting your
> > converted drivers.
> 
> I haven't done drivers/mfd/twl6030-pwm.c. This one needs a bit more work
> as it currently does not register itself as a subdriver to the twl6030
> but just uses a globally available twl_i2c_write_u8() function. So if
> you have some time to spare it would be great if you could do this.

Okay, I'll have a look. I guess the next round won't be the last after all.
:-)

> > I'm also wondering which tree this will go in through. Does it make sense to
> > have an extra tree just for the PWM framework or can it go in via some other
> > general purpose tree? Who do I need to prod?
> 
> Good question, I don't know.

Okay, maybe Arnd can comment on it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/d0cf8fb3/attachment.sig>
