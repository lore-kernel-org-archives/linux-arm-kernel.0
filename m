From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Fri, 30 Jul 2010 13:40:02 +0200
Subject: Some benchmarks on ARM
In-Reply-To: <20100730101938.GA2487@riccoc20.at.omicron.at>
References: <20100702180257.GA8767@pengutronix.de>
	<20100729165413.GU20855@pengutronix.de>
	<20100730101938.GA2487@riccoc20.at.omicron.at>
Message-ID: <4C52BA12.40801@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Cochran wrote:
> On Thu, Jul 29, 2010 at 06:54:13PM +0200, Robert Schwebel wrote:
>> Thanks to everyone who posted feedback!
>>
>> An updated version of the article is now here:
>> http://www.pengutronix.de/development/kernel/arm-benchmarks-20100729_en.html
> 
> Nice report.
> 
> I would be interesting for me if you could give the FCSE patch a try
> on the v5 machines. Any chance of that happening?

As I already said, I am very suspicious about the results of this
benchmark on PXA. We get user-space scheduling latencies under 300us on
PXA with Xenomai, and as you know, the worst case user-space scheduling
latency includes a context switch, so, this means that the context
switch is less than 300us. However, these benchmarks show some context
switches around 600us, so I suspect the measurement measures more than
just a context switch, maybe the execution of a long standing interrupt
or more probably a soft irq.
The gain induced by the FCSE patch is between 50 and 100us on the
machines where we measured it, so, it will not make a big difference on
a context switch time of 600us.

Anyway, I have not worked on the FCSE patch for 2.6.34, I was waiting
for 2.6.35 to be released to work on the two at a time, but if anyone is
interested, I can get it working before that.

-- 
					    Gilles.
