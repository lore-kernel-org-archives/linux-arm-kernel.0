From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 10 May 2014 23:29:25 -0400 (EDT)
Subject: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
In-Reply-To: <20140509180121.GU12304@sirena.org.uk>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-2-git-send-email-broonie@kernel.org>
 <20140509174738.GP7950@arm.com> <20140509180121.GU12304@sirena.org.uk>
Message-ID: <alpine.LFD.2.11.1405102321290.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 May 2014, Mark Brown wrote:

> On Fri, May 09, 2014 at 06:47:38PM +0100, Catalin Marinas wrote:
> > On Fri, May 09, 2014 at 05:40:30PM +0100, Mark Brown wrote:
> 
> > > The big.LITTLE cpufreq driver is useful on arm64 big.LITTLE systems even
> > > without IKS support since it implements support for clusters with shared
> > > clocks (a common big.LITTLE configuration). In order to allow it to be
> > > built provide the non-IKS stubs for arm64, enabling cpufreq with all the
> > > cores available.
> 
> > Have you thought of patching the actual cpufreq driver? Are you adding
> > this code just to avoid compiler errors on arm64 with this driver?
> 
> Yes, that was actually my first thought but I wasn't loving the
> ifdeferry - it's fairly easy to do IIRC but the general taste seems to
> be towards having stubs rather than ifdefs and the code seemed to be
> lending itself to that.  There was also the fact that ifdefs could have
> been done for the non-IKS case on 32 bit but instead stubs were
> provided.  If people prefer I can do an ifdeffed version though, it
> doesn't make much odds.

I personally don't understand the b.L cpufreq driver fully, especially 
with the IKS functionality bolted on top.  Obviously I didn't write that 
part otherwise I would hopefully understand it better.  Still, I'd have 
preferred for the IKS extension to the b.L cpufreq driver to be more 
isolated in a separate file or the like.

> This was purely to get the driver compiling and hopefully running on
> ARMv8, there is some user demand for deploying the driver on big.LITTLE
> systems.
> 
> > > It may make sense to make an asm-generic version of these stubs instead
> 
> > asm-generic/bL_switcher.h? I take it as a good joke ;)
> 
> Hey, perhaps other hardware architectures are implementing similar
> concepts even now in order to keep up!  

Let's hope we won't need to rely on IKS any longer by the time support 
for them land into mainline.


Nicolas
