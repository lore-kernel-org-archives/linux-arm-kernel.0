From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 3 Sep 2012 22:47:42 -0400 (EDT)
Subject: [PATCH 2/2] ARM: allow for ATAGS to be configured out when DT
 support is selected
In-Reply-To: <20120902155449.GF18950@mudshark.cambridge.arm.com>
References: <1346361008-7320-1-git-send-email-nicolas.pitre@linaro.org>
 <1346361008-7320-2-git-send-email-nicolas.pitre@linaro.org>
 <20120902155449.GF18950@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1209032217360.1784@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2 Sep 2012, Will Deacon wrote:

> On Thu, Aug 30, 2012 at 10:10:08PM +0100, Nicolas Pitre wrote:
> > Now that ATAGS support is well contained, we can easily remove it from
> > the kernel build if so desired.  It has to explicitly be disabled, and
> > only when DT support is selected.
> > 
> > Note: disabling kernel ATAGS support does not prevent the usage of
> > CONFIG_ARM_ATAG_DTB_COMPAT.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >  arch/arm/Kconfig         | 26 +++++++++++++++++++-------
> >  arch/arm/kernel/Makefile |  5 +++--
> >  arch/arm/kernel/atags.h  | 11 +++++++++++
> >  3 files changed, 33 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index c5f9ae5dbd..5c7302e208 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1891,12 +1891,6 @@ config CC_STACKPROTECTOR
> >  	  neutralized via a kernel panic.
> >  	  This feature requires gcc version 4.2 or above.
> >  
> > -config DEPRECATED_PARAM_STRUCT
> > -	bool "Provide old way to pass kernel parameters"
> > -	help
> > -	  This was deprecated in 2001 and announced to live on for 5 years.
> > -	  Some old boot loaders still use this way.
> > -
> >  endmenu
> 
> Since you're in this area, do we need to carry this forward? If somebody is
> using it then obviously we have to keep it but it might be worth asking
> around.

That should be a separate patch if that has to be dropped.  Right now 
that code is already in a file of its own and not getting in the way of 
anything else, and I didn't want to change any behavior on legacy 
platforms.

> Back on topic, this looks good to me:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks.


Nicolas
