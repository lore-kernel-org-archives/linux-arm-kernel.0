From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 8 Jun 2011 08:21:08 +0530
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <20110607214151.GA7712@opensource.wolfsonmicro.com>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
	<20110607081527.GB20929@n2100.arm.linux.org.uk>
	<BANLkTin66PhYGmVSOJcuZr8wDH_iNgjhZQ@mail.gmail.com>
	<20110607182923.GA28451@n2100.arm.linux.org.uk>
	<20110607184329.GA20849@sirena.org.uk>
	<BANLkTikXGpxpyF8kQORqswD5tqNEjtj3dA@mail.gmail.com>
	<20110607214151.GA7712@opensource.wolfsonmicro.com>
Message-ID: <BANLkTimwAHdpJbLqqBwEXjqWwg75SciUVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2011 at 3:11 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jun 08, 2011 at 12:31:42AM +0530, Jassi Brar wrote:
>> On Wed, Jun 8, 2011 at 12:13 AM, Mark Brown
>
>> > Circular buffers are nice from the point of view of allowing you to
>> > (providing the hardware supports it) totally disable the periodic audio
>> > interrupts and leave the system to run for very long times off the
>
>> This is what I called free-running circular buffer.
>> Besides power saving scenario, it is necessary for a fast peripheral
>> with shallow fifo.
>> The peripheral throws underrun errors, if the dma h/w doesn't support
>> LLI and cpu takes
>> a bit long loading-triggering the next transfer on DMA due to
>> irq-latency for some reason.
>
> That's fairly unusual, though - usually DMA controllers seem to support
> chaining requests before they support circular operation, at which point
> unless the hardware is badly misdone you can just chain another buffer,
> giving that buffer's worth of time for the CPU to respond.

While writing PL330 driver, I wasn't able to figure out a way to implement LLI.
Please have a look at the PL330 trm and suggest if we can implement it in a
generic way without considering them special requests.
I know pl080 supports LLI and it's fine.


>> > You can also do this with an circular chain of sequential buffers of
>> > course.
>
>> This is what is called Circular buffer in Samsung's DMA API.
>
> Which is a little bit unusual as it's basically a pure software
> construct rather than a hardware feature.
Yes it is. And I didn't say it suffice.
