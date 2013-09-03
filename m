From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Sep 2013 12:38:32 +0100
Subject: [PATCH 13/14] ASoC: kirkwood: add SPDIF output support
In-Reply-To: <20130903111720.GF3084@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkaX-0003JN-DQ@rmk-PC.arm.linux.org.uk>
 <20130903111720.GF3084@sirena.org.uk>
Message-ID: <20130903113832.GF6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 12:17:20PM +0100, Mark Brown wrote:
> On Sat, Aug 31, 2013 at 01:47:37PM +0100, Russell King wrote:
> > Add support for SPDIF output.  This is enabled via a widget being
> > connected to an output.  When this widget is not connected, SPDIF
> > output will remain disabled.
> 
> This is still not a good approach to adding a new digital audio
> interface since it does not create a DAI but instead adds it like an
> analogue link (but hooked inside the CPU using the DPCM DAPM hooks).

This is the way Liam's Haswell DPCM driver works.

> While this may work right now but will not be robust as the framework is
> developed and can cause problems in system integration.
> 
> A new DAI should be being added for the S/PDIF interface, this should
> fully utilise DPCM but an either/or approach would be OK as a stepping
> stone.

A new CPU DAI will be a front end DAI.  So what you're saying here is
that your earlier statement where you clearly said "one front end and
two back ends" was wrong.

Sorry, I'm not playing your game anymore.  I'm not interested in trying
to work with you anymore, because its totally impossible.  You're being
as obstructive as you have been from the very start, and as demonstrated
last night when you said "there is no mixer" in Liam's DPCM driver, you
don't know what you're talking about half the time.  Or, you're
intentionally making false statements.

There is no point persuing this any further; I'm not wasting any more
time on playing your stupid games.
