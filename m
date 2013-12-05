From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 05 Dec 2013 18:03:02 +0100
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized using
 pinfunc.
In-Reply-To: <52A0AEB4.7090909@bracey.fi>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
 <1502243.eRBlCfUhTO@amdc1227> <52A0AEB4.7090909@bracey.fi>
Message-ID: <1475204.PCyxT0KMui@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 of December 2013 18:49:56 Kevin Bracey wrote:
> On 05/12/2013 17:11, Tomasz Figa wrote:
> > On Thursday 05 of December 2013 15:07:47 Mark Brown wrote:
> >> On Tue, Dec 03, 2013 at 10:29:42AM +0100, Linus Walleij wrote:
> >>
> >>> So a suggested patch to support weak hogs would be interesting
> >>> to look at. Can you provide details on how you think this would
> >>> work?
> >> Or should we be going and applying the default state to all devices on
> >> init without worrying about a driver appearing?
> > If a device isn't used, then it's often better to configure the pins for
> > a different function, such as GPIO, to minimize leakage current.
> >
> 
> And there can also be mutually-exclusive drivers choosing different 
> default states for the same pin. I think you do need a separate "safe" 
> indicator.

That's not quite true, as on a single board you should rather have
a single device node with "okay" status referencing given set of pins.
Still, I think that a separate safe state is the way to go.

> 
> My current thought is that  a late-init "make safe all unclaimed pins" 
> pass would make sense - you can't really mess with pins in an automated 
> fashion on init, as it can mess up bootloader->driver handover.   There 
> already exist late-init "turn off all unclaimed clocks" (at least on 
> shmobile)

That's a feature of Common Clock Framework.

> and "turn off all unclaimed regulators", and it would fit that 
> model.

Maybe that's the way to do it. I need to think a bit more on this,
especially considering our (Samsung's) use cases.

Best regards,
Tomasz
