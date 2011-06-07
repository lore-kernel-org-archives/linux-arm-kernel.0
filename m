From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Jun 2011 22:41:51 +0100
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <BANLkTikXGpxpyF8kQORqswD5tqNEjtj3dA@mail.gmail.com>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
	<20110607081527.GB20929@n2100.arm.linux.org.uk>
	<BANLkTin66PhYGmVSOJcuZr8wDH_iNgjhZQ@mail.gmail.com>
	<20110607182923.GA28451@n2100.arm.linux.org.uk>
	<20110607184329.GA20849@sirena.org.uk>
	<BANLkTikXGpxpyF8kQORqswD5tqNEjtj3dA@mail.gmail.com>
Message-ID: <20110607214151.GA7712@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 12:31:42AM +0530, Jassi Brar wrote:
> On Wed, Jun 8, 2011 at 12:13 AM, Mark Brown

> > Circular buffers are nice from the point of view of allowing you to
> > (providing the hardware supports it) totally disable the periodic audio
> > interrupts and leave the system to run for very long times off the

> This is what I called free-running circular buffer.
> Besides power saving scenario, it is necessary for a fast peripheral
> with shallow fifo.
> The peripheral throws underrun errors, if the dma h/w doesn't support
> LLI and cpu takes
> a bit long loading-triggering the next transfer on DMA due to
> irq-latency for some reason.

That's fairly unusual, though - usually DMA controllers seem to support
chaining requests before they support circular operation, at which point
unless the hardware is badly misdone you can just chain another buffer,
giving that buffer's worth of time for the CPU to respond.

> > You can also do this with an circular chain of sequential buffers of
> > course.

> This is what is called Circular buffer in Samsung's DMA API.

Which is a little bit unusual as it's basically a pure software
construct rather than a hardware feature.
