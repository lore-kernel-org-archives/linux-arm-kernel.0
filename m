From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 10 May 2012 14:36:59 +0300
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <20120509164915.GA19219@gmail.com>
References: <20120503161311.GG20304@tbergstrom-lnx.Nvidia.com>
 <20120507000329.GB14559@gmail.com>
 <20120509111335.GC20304@tbergstrom-lnx.Nvidia.com>
 <20120509164915.GA19219@gmail.com>
Message-ID: <20120510113659.GM20304@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 06:49:15PM +0200, Mike Turquette wrote:
> On 20120509-14:13, Peter De Schrijver wrote:
> > Ok. Thanks. One more question. We have some clocks with special features
> > such as request lines for clock outputs, delays for clocks recovered from
> > an external source or several divisors which are used based on the state
> > of the module which is served by the clock (eg. an idle divisor and an active
> > divisor). How should these be modelled?
> 
> My platform also has some "special" clocks.  The worst case is that you
> must create some platform clock types and eschew the common basic types.
> A common example of this is that everyone has their own PLL
> implementation.
> 

Ok. I was more wondering on how to expose those features which don't fit into
the normal clock API. Currently we have tegra_clk_cfg_ex() which is some kind
of ioctl for clocks.

> However it is possible to subclass some existing basic types if your
> needs aren't too complicated.  Check out the patch from Andrew that
> builds on top of the basic gate:
> http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=commitdiff;h=98d9986cb8bf65f8316b45244fdafc1d12c303be;hp=e919c71665d2386eec6dc2ecd58d01bae69fc0fd
> 
> In fact the basic clock types were originally discussed as targeting
> only "simple platforms".  I don't think anyone thought that we would get
> as much use out of them as we have had for complex SoCs.

Ok. Might be useful at some point.

Cheers,

Peter.
