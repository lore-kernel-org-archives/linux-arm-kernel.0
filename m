From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 09:06:25 +0000
Subject: [PATCH v4 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111226134449.GA4259@richard-laptop>
References: <1324537753-30590-1-git-send-email-richard.zhao@linaro.org>
 <1324537753-30590-5-git-send-email-richard.zhao@linaro.org>
 <20111223131851.GB13175@sirena.org.uk> <20111224085539.GA1892@richard-laptop>
 <20111224122411.GA13778@sirena.org.uk> <20111224132831.GB1803@richard-laptop>
 <20111224134227.GA20908@opensource.wolfsonmicro.com>
 <20111224155227.GC1803@richard-laptop>
 <20111226111030.GC8722@opensource.wolfsonmicro.com>
 <20111226134449.GA4259@richard-laptop>
Message-ID: <20120103090625.GA2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2011 at 09:44:52PM +0800, Richard Zhao wrote:
> On Mon, Dec 26, 2011 at 11:10:30AM +0000, Mark Brown wrote:
> > The *call* is there in the regulator subsystem, it's just that none of
> > the drivers back it up with an actual implementation yet.  Which turns
> > out to be a good thing as cpufreq can't currently understand variable
> > latencies and the governors don't deal well with non-trivial latencies
> > anyway.
> but clk API don't have such calls. and many SoCs only adjust clk frequencies, using
> one single voltage.

That's because it's often not known - especially in the case of PLLs,
data sheets don't tend to specify how long it takes for the PLL to relock
after a requested change.  If it's important that the PLL be locked,
there will be a bit to poll (or they'll cause the CPU itself to stall
while the PLL is not locked.)

So, for these kinds of situations, how do you suggest that the clk API
provides this information?
