From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 3 Jan 2012 20:26:25 +0000
Subject: [PATCH v4 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20120103134709.GS2914@n2100.arm.linux.org.uk>
References: <20111224085539.GA1892@richard-laptop>
 <20111224122411.GA13778@sirena.org.uk>
 <20111224132831.GB1803@richard-laptop>
 <20111224134227.GA20908@opensource.wolfsonmicro.com>
 <20111224155227.GC1803@richard-laptop>
 <20111226111030.GC8722@opensource.wolfsonmicro.com>
 <20111226134449.GA4259@richard-laptop>
 <20120103090625.GA2914@n2100.arm.linux.org.uk>
 <CAH8gqwVHc9ROQYZNe6b-cUN0ycWhYj8=vJ0geBXUCYN1+XENQA@mail.gmail.com>
 <20120103134709.GS2914@n2100.arm.linux.org.uk>
Message-ID: <20120103202624.GG2843@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 01:47:09PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 03, 2012 at 09:25:30PM +0800, Richard Zhao wrote:

> > In latest v6 version, I get clk transition latency from dt property, and get
> > regulator transition latency from regulator API.
> > Could you please help review other arm common changes in v6 version?

> You didn't get my point: how do you specify a clock transition latency
> for a clock with a PLL when the data sheets don't tell you what that is,
> and they instead give you a bit to poll?

I'd rather suspect you'll find there are actually specs for these things
but they're hidden in the electrical characteristics which don't tend to
go into the published datasheets (though ).  Not useful if we don't
actually see them though.

> Do you:

> (a) make up some number and hope that it's representative
> (b) not specify any transition latency

These are the traditional approaches, pioneered by essentially every
existing cpufreq driver (well, "make up" is a bit harsh - usually the
numbers are measured, though possibly only on a limited set of systems).

> (c) think about the problem _now_ and define what it means for a clock
>     without a transition latency.

This would be nice, in both the clock and cpufreq code (the cpufreq code
is pretty limited here in that it assumes an equal transition latency
for all transitions which isn't the case usually).  You can generally do
something useful with measurement, probably we can arrange to measure
the times we're seeing on the actua system or something.
