From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 May 2014 19:01:21 +0100
Subject: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
In-Reply-To: <20140509174738.GP7950@arm.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-2-git-send-email-broonie@kernel.org>
 <20140509174738.GP7950@arm.com>
Message-ID: <20140509180121.GU12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 06:47:38PM +0100, Catalin Marinas wrote:
> On Fri, May 09, 2014 at 05:40:30PM +0100, Mark Brown wrote:

> > The big.LITTLE cpufreq driver is useful on arm64 big.LITTLE systems even
> > without IKS support since it implements support for clusters with shared
> > clocks (a common big.LITTLE configuration). In order to allow it to be
> > built provide the non-IKS stubs for arm64, enabling cpufreq with all the
> > cores available.

> Have you thought of patching the actual cpufreq driver? Are you adding
> this code just to avoid compiler errors on arm64 with this driver?

Yes, that was actually my first thought but I wasn't loving the
ifdeferry - it's fairly easy to do IIRC but the general taste seems to
be towards having stubs rather than ifdefs and the code seemed to be
lending itself to that.  There was also the fact that ifdefs could have
been done for the non-IKS case on 32 bit but instead stubs were
provided.  If people prefer I can do an ifdeffed version though, it
doesn't make much odds.

This was purely to get the driver compiling and hopefully running on
ARMv8, there is some user demand for deploying the driver on big.LITTLE
systems.

> > It may make sense to make an asm-generic version of these stubs instead

> asm-generic/bL_switcher.h? I take it as a good joke ;)

Hey, perhaps other hardware architectures are implementing similar
concepts even now in order to keep up!  :P
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/bf2274cf/attachment.sig>
