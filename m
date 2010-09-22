From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Sep 2010 11:26:51 +0100
Subject: [PATCH] mfd: regulator: max8998: BUCK1/2 control augmented by
	GPIO pins
In-Reply-To: <20100922084641.6be55f02@lmajewski.digital.local>
References: <1285078695-24753-1-git-send-email-l.majewski@samsung.com>
	<20100921150107.GA32476@sirena.org.uk>
	<20100922084641.6be55f02@lmajewski.digital.local>
Message-ID: <20100922102651.GA22361@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 22, 2010 at 08:46:41AM +0200, Lukasz Majewski wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > For the voltage selection values I'm somewhat surprised to see them
> > specified in the platform data - I would instead expect to see them
> > figured out at runtime based on the voltages that are being set.

> I'd like to ask you for clarification on this statement. Correct me if
> I'm wrong, but I think that some default voltage values should be
> declared in platform data (according to the chip manual) to facilitate
> dynamic voltage scaling feature. I suspect that this information is
> platform specific and should be adjusted for each chip separately.

Assume that I've never seen the chip datasheet.  What exactly is this
platform data configuring?  

I would expect to see platform data configuring the default state of the
GPIOs at power up but that doesn't seem to be what's being configured
here.  For anything configured via registers I would expect the driver
to read the state of the chip at startup.
