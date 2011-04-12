From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Apr 2011 18:45:01 +0100
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <4DA33DEE.9080709@codeaurora.org>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
	<1302349235.9086.1270.camel@twins>
	<1302521393.24286.66.camel@e102144-lin.cambridge.arm.com>
	<4DA33DEE.9080709@codeaurora.org>
Message-ID: <1302630301.24286.89.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ashwin,

On Mon, 2011-04-11 at 18:44 +0100, Ashwin Chaugule wrote:
> > Sure, fundamentally we're just writing bits rather than interpreting
> > them. The reason I mention the difference is that filtering PMUs will
> > always need their own struct pmu because of the lack of an event
> > namespace. The other problem is only an issue for some userspace tools
> > (like Oprofile) which require lists of events and their hex codes.
> >
> 
> If you mean namespace = perf_event_attr::config, its 64 bits + another 64
> bits of config_base + event_base on ARM ? Not too sure, but it would seem
> like that should be enough to setup such event chaining.

If you have a filtering PMU on a bus with large physical addresses, by
the time you've specified an address range you've already used up a
decent proportion of those bits so I don't think we should restrict
ourselves if we don't have to.

Will
