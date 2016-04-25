From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 17:46:53 +0200
Subject: [PATCH 10/10] cpufreq: mvebu: Use generic platdev driver
In-Reply-To: <20160425152914.GI6104@vireshk-i7>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <17150729.NF4MViUffk@wuerfel> <20160425152914.GI6104@vireshk-i7>
Message-ID: <5536968.ADFL5hRmGD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 April 2016 20:59:14 Viresh Kumar wrote:
> On 25-04-16, 17:26, Arnd Bergmann wrote:
> > On Monday 25 April 2016 18:26:05 Viresh Kumar wrote:
> > > On 25-04-16, 14:53, Arnd Bergmann wrote:
> > > > What are the downsides of moving armada_xp_pmsu_cpufreq_init()
> > > > into drivers/cpufreq?
> > > 
> > > More special code :)
> > 
> > Of course the special code still exists, it seems more like neither of
> > us wants to have it in the portion of the kernel that he maintains ;-)
> 
> Hehe.. But after $subject patch, we don't have any special code for
> creating the device, isn't it?
> 
> > Maybe the mvebu maintainers have a preference where they'd like the
> > code to be, they are the ones that are most impacted if anything
> > goes wrong.
> 
> What code are you talking about? Initializing the OPPs or adding the
> cpufreq-dt device? The first one (or whatever is left now in that
> function) can stay anywhere, even as a cpufreq driver. I was talking
> about the fact that we don't have a sequence problem to solve here.

My line of thinking was that the armada_xp_pmsu_cpufreq_init()
function makes sense by itself and feels like it should be
one file in drivers/cpufreq, including the creation of the device.

Even without the argument of the sequencing, they two parts sort
of belong together because the cpufreq-dt driver depends on both
of them being run before it can function. It's also the same amount
of code, as you are replacing one line in armada_xp_pmsu_cpufreq_init
with one line in "struct of_device_id machines".

It's not really that important, just a feeling I had that it could
be done better. Unless the mvebu maintainers feel strongly about
it, just do as you prefer.

	Arnd
