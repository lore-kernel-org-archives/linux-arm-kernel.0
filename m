From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 20 Feb 2015 12:37:53 +0100
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <20150220093659.GA23469@gmail.com>
References: <6291e308ab77a480c6b1732e16108c5fe6f66afa.1424412815.git.viresh.kumar@linaro.org>
 <20150220083842.GA20387@gmail.com>
 <20150220084807.GJ21418@twins.programming.kicks-ass.net>
 <20150220093659.GA23469@gmail.com>
Message-ID: <20150220113753.GP5029@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 10:36:59AM +0100, Ingo Molnar wrote:
> > But it does mean we need to be able to add values to the 
> > enum.
> 
> So I'm confused: if we are using proper callbacks (like my 
> example outlined) , why is a 'mode enum' needed at all?

Ah, its because the enum is shared between two different use-cases. The
one is the clockevent driver for the clock_event_device::set_mode()
call, and one is the clockevent core call: clockevent_set_mode().

The previous patch changed the driver interface, but retained the
sharing of the enum across both interfaces.

Maybe we should break that enum into two; one for devices and one for
the core interface and avoid the problem that way.
