From: richard.zhao@linaro.org (Richard Zhao)
Date: Sat, 24 Dec 2011 23:52:29 +0800
Subject: [PATCH v4 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111224134227.GA20908@opensource.wolfsonmicro.com>
References: <1324537753-30590-1-git-send-email-richard.zhao@linaro.org>
 <1324537753-30590-5-git-send-email-richard.zhao@linaro.org>
 <20111223131851.GB13175@sirena.org.uk>
 <20111224085539.GA1892@richard-laptop>
 <20111224122411.GA13778@sirena.org.uk>
 <20111224132831.GB1803@richard-laptop>
 <20111224134227.GA20908@opensource.wolfsonmicro.com>
Message-ID: <20111224155227.GC1803@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 24, 2011 at 01:42:29PM +0000, Mark Brown wrote:
> On Sat, Dec 24, 2011 at 09:28:33PM +0800, Richard Zhao wrote:
> > On Sat, Dec 24, 2011 at 12:24:11PM +0000, Mark Brown wrote:
> 
> >  - trans-latency :  transition latency of cpu freq and related regulator,
> >    in unit of ns.
> 
> > Does it look better?
> 
> I think it shouldn't include the regulator part of things.
> 
> > If you think regulator thansition latency is board specific, then the board
> > dts can overrite it.
> 
> We should just query this information from the regulator subsystem
> (there's hooks but currently nothing implements them).  The regulators
> can define their own bindings if they need to read it from device tree,
> most of them should be able to do this as a function of knowing about
> the device.  None of this is specific to cpufreq so cpufreq shouldn't
> have to define its own support for this.
I'd like to query the latency by call clk and regulator APIs. but as you said
both of them have not implemented it yet. I think, for now, we can use the
property to get the total latency. Once I can get it at runtime, I'll remove
it. So the definition of trans-latency is just the same as cpufreq transition_latency,
people get less confused. What do you think?

Thanks
Richard
