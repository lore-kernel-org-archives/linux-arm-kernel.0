From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 26 Dec 2011 21:44:52 +0800
Subject: [PATCH v4 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111226111030.GC8722@opensource.wolfsonmicro.com>
References: <1324537753-30590-1-git-send-email-richard.zhao@linaro.org>
 <1324537753-30590-5-git-send-email-richard.zhao@linaro.org>
 <20111223131851.GB13175@sirena.org.uk>
 <20111224085539.GA1892@richard-laptop>
 <20111224122411.GA13778@sirena.org.uk>
 <20111224132831.GB1803@richard-laptop>
 <20111224134227.GA20908@opensource.wolfsonmicro.com>
 <20111224155227.GC1803@richard-laptop>
 <20111226111030.GC8722@opensource.wolfsonmicro.com>
Message-ID: <20111226134449.GA4259@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2011 at 11:10:30AM +0000, Mark Brown wrote:
> On Sat, Dec 24, 2011 at 11:52:29PM +0800, Richard Zhao wrote:
> > On Sat, Dec 24, 2011 at 01:42:29PM +0000, Mark Brown wrote:
> > > On Sat, Dec 24, 2011 at 09:28:33PM +0800, Richard Zhao wrote:
> 
> > > > If you think regulator thansition latency is board specific, then the board
> > > > dts can overrite it.
> 
> > > We should just query this information from the regulator subsystem
> > > (there's hooks but currently nothing implements them).  The regulators
> > > can define their own bindings if they need to read it from device tree,
> > > most of them should be able to do this as a function of knowing about
> > > the device.  None of this is specific to cpufreq so cpufreq shouldn't
> > > have to define its own support for this.
> 
> > I'd like to query the latency by call clk and regulator APIs. but as you said
> > both of them have not implemented it yet. I think, for now, we can use the
> 
> The *call* is there in the regulator subsystem, it's just that none of
> the drivers back it up with an actual implementation yet.  Which turns
> out to be a good thing as cpufreq can't currently understand variable
> latencies and the governors don't deal well with non-trivial latencies
> anyway.
but clk API don't have such calls. and many SoCs only adjust clk frequencies, using
one single voltage.
> 
> > property to get the total latency. Once I can get it at runtime, I'll remove
> > it. So the definition of trans-latency is just the same as cpufreq transition_latency,
> > people get less confused. What do you think?
> 
> The problem with device tree is that once you've defined a binding
> you're stuck with it, it's very hard to change - witness all the magic
> number based stuff with the interrupt bindings for example
So what's your suggestion? We can not set transition_latency to set random number.

Thanks
Richard
