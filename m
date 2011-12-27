From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 27 Dec 2011 09:51:10 +0800
Subject: [PATCH v4 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111226142234.GH8722@opensource.wolfsonmicro.com>
References: <1324537753-30590-5-git-send-email-richard.zhao@linaro.org>
 <20111223131851.GB13175@sirena.org.uk>
 <20111224085539.GA1892@richard-laptop>
 <20111224122411.GA13778@sirena.org.uk>
 <20111224132831.GB1803@richard-laptop>
 <20111224134227.GA20908@opensource.wolfsonmicro.com>
 <20111224155227.GC1803@richard-laptop>
 <20111226111030.GC8722@opensource.wolfsonmicro.com>
 <20111226134449.GA4259@richard-laptop>
 <20111226142234.GH8722@opensource.wolfsonmicro.com>
Message-ID: <20111227015109.GJ15863@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2011 at 02:22:34PM +0000, Mark Brown wrote:
> On Mon, Dec 26, 2011 at 09:44:52PM +0800, Richard Zhao wrote:
> > On Mon, Dec 26, 2011 at 11:10:30AM +0000, Mark Brown wrote:
> 
> Fix your mailer to word wrap properly please.
If you mean last mail I sent, I didn't see anything wrong. I use
mutt.
> 
> > > The *call* is there in the regulator subsystem, it's just that none of
> > > the drivers back it up with an actual implementation yet.  Which turns
> > > out to be a good thing as cpufreq can't currently understand variable
> > > latencies and the governors don't deal well with non-trivial latencies
> > > anyway.
> 
> > but clk API don't have such calls. and many SoCs only adjust clk
> > frequencies, using one single voltage.
> 
> I've not suggested doing this in the clock API, only for the regulator.
> For the clocks it's less clear that it's useful as you don't have the
> bulk operations and it's much rarer to need them.
> 
> > > The problem with device tree is that once you've defined a binding
> > > you're stuck with it, it's very hard to change - witness all the magic
> > > number based stuff with the interrupt bindings for example
> 
> > So what's your suggestion? We can not set transition_latency to set
> > random number.
> 
> As I've repeatedly said I think you should define it to be the latency
> for the SoC only, not for the regulators.
Sometimes, regulators are in SoC too. To avoid confusion, I'll use below:
clk-trans-latency = <61036>;

Thanks
Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
