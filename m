From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Jun 2011 09:55:27 +0100
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <BANLkTimwAHdpJbLqqBwEXjqWwg75SciUVw@mail.gmail.com>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
	<20110607081527.GB20929@n2100.arm.linux.org.uk>
	<BANLkTin66PhYGmVSOJcuZr8wDH_iNgjhZQ@mail.gmail.com>
	<20110607182923.GA28451@n2100.arm.linux.org.uk>
	<20110607184329.GA20849@sirena.org.uk>
	<BANLkTikXGpxpyF8kQORqswD5tqNEjtj3dA@mail.gmail.com>
	<20110607214151.GA7712@opensource.wolfsonmicro.com>
	<BANLkTimwAHdpJbLqqBwEXjqWwg75SciUVw@mail.gmail.com>
Message-ID: <20110608085526.GA2828@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 08:21:08AM +0530, Jassi Brar wrote:
> On Wed, Jun 8, 2011 at 3:11 AM, Mark Brown

> > That's fairly unusual, though - usually DMA controllers seem to support
> > chaining requests before they support circular operation, at which point
> > unless the hardware is badly misdone you can just chain another buffer,
> > giving that buffer's worth of time for the CPU to respond.

> While writing PL330 driver, I wasn't able to figure out a way to implement LLI.
> Please have a look at the PL330 trm and suggest if we can implement it in a
> generic way without considering them special requests.
> I know pl080 supports LLI and it's fine.

I'm perfectly prepared to believe that there's poorly designed hardware
out there (either due to just poor design or deploying a controller in
an inappropriate application) that requires us to do things in software;
it's just relatively unusual as users tend to run into issues which
either can't be resolved or are excessively painful to resolve.
