From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 25 Jan 2018 19:03:17 +0100
Subject: [PATCH 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <2e5f5ec08b3165cb84115c12f9ddbd9e@codeaurora.org>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-3-l.stach@pengutronix.de>
 <20180123103931.GE27764@dragon>
 <278bb44610b8a27826550732095aba03@codeaurora.org>
 <1516876300.6411.25.camel@pengutronix.de>
 <2cac219f031a08ae2ac02a0624fe302f@codeaurora.org>
 <1516878582.6411.27.camel@pengutronix.de>
 <2e5f5ec08b3165cb84115c12f9ddbd9e@codeaurora.org>
Message-ID: <1516903397.6411.42.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 25.01.2018, 21:03 +0800 schrieb Dong Aisheng:
> On 2018-01-25 19:09, Lucas Stach wrote:
> > Am Donnerstag, den 25.01.2018, 18:49 +0800 schrieb Dong Aisheng:
> > > On 2018-01-25 18:31, Lucas Stach wrote:
> > > > Am Donnerstag, den 25.01.2018, 18:10 +0800 schrieb?
> > > > aisheng.dong at codeaurora.org:
> > 
> > [...]
> > > AFAIK we switched to generic pinconfig since MX7ULP as
> > > maintainer?
> > > > > won't
> > > > > access old binding pinctrl drivers.
> > > > 
> > > > I'm not convinced that the generic pinconf is good fit. For
> > > > pingroups
> > > > with different configs for some of the pins, like the example
> > > > above, we
> > > > would need to split things into multiple DT nodes. This really
> > > > hurts
> > > > readability, so I'm not going to switch to the generic stuff
> > > > without
> > > > some really convincing arguments.
> > > > 
> > > 
> > > Per my understanding, based on the last discussion with Linus W,
> > > we?
> > > actually did this in order to increase the readability that 1)
> > > user?
> > > does
> > > not need?to see the 'ugly' unreadable raw data and refer to
> > > reference
> > > manual 2)?unified generic binding format which already exist in
> > > kernel
> > > and used by many platforms.
> > > 
> > > Actually MXS platform already used it for many years in a similar
> > > way.
> > > So IMHO a little hurt to add another node for different pad
> > > setting?
> > > in?
> > > the same group won't be enough reason to stop switching to
> > > generic?
> > > config.
> > > 
> > > Does it make sense?
> > 
> > I know that Linus W is pushing for this common pinconf thing in the
> > name of readability. It's just that I don't think it's such a clear
> > win.
> > 
> > After all you still need to look into the reference manual or
> > binding
> > to see which values in the common binding correspond to a specific
> > drive/pull strength, etc.
> > 
> 
> User don't need to look into reference manual and they don't need to
> compose the 'ulgy' raw data which is the most tough thing.
> 
> With generic binding, it probably can saving ~80% pad setting effort
> by refer to the defined generic config properties.
> And things can be even better when the reference code is already
> there
> as user becomes know which property supported.
> 
> > On the other hand it really bloats the DT description of the pin
> > configuration. If you want to look at an (IMHO) bad example, go
> > look at
> > the Tegra DTs. The Tegra pincontrol implements the "separate
> > properties
> > for each pinconf option" that is pushed by Linus W. This bloated
> > the DT
> > description to the point that no-one is able/willing to write those
> > descriptions anymore and the only viable way to get them is to
> > auto-
> > generate them from some spreadsheets. Not really what I would call
> > an
> > readable...
> > 
> 
> I wonder the worst case you're worrying whether exist in reality.
> Take imx6qdl-sabresd as an example, about half of pingroups having
> the?
> same
> pad setting while others have two different settings at most.
> That means it may not bloat the device tree too much.
> 
> > Maybe I'm a little stubborn when it comes to this topic, but at
> > Pengutronix we see a lot of customer designs where we need to come
> > up
> > with the board DT. Bloating each one of those and making the work
> > of
> > the developers harder in the name of a readability win that I just
> > don't see doesn't sound like something I want to support. :)
> > 
> 
> Hmm.. In contrast, what i feel currently is that it may ease the
> using?of pad setting, not make it harder. Not sure if i overlooked
> something.
> 
> Let's listen to Shawn and Linus W if they have some comments.

While I'm still unconvinced that the generic binding actually adds any
value, I'll go and see how converting the MX8M pinctrl will look on a
real board.

This will delay rev 2 of this series a bit, but I hope to have
something to send out tomorrow.

Regards,
Lucas
