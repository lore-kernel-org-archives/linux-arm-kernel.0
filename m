From: Steve.Capper@arm.com (Steve Capper)
Date: Mon, 26 Nov 2018 12:11:52 +0000
Subject: [PATCH V3 5/5] arm64: mm: Allow forcing all userspace addresses
 to 52-bit
In-Reply-To: <20181123182233.GL3360@arrakis.emea.arm.com>
References: <20181114133920.7134-1-steve.capper@arm.com>
 <20181114133920.7134-6-steve.capper@arm.com>
 <20181123182233.GL3360@arrakis.emea.arm.com>
Message-ID: <20181126121141.GB2012@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 06:22:34PM +0000, Catalin Marinas wrote:
> On Wed, Nov 14, 2018 at 01:39:20PM +0000, Steve Capper wrote:
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index eab02d24f5d1..17d363e40c4d 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1165,6 +1165,20 @@ config ARM64_CNP
> >  	  at runtime, and does not affect PEs that do not implement
> >  	  this feature.
> >  
> > +config ARM64_FORCE_52BIT
> > +	bool "Force 52-bit virtual addresses for userspace"
> > +	default n
> 
> No need for "default n"
> 
> > +	depends on ARM64_52BIT_VA && EXPERT
> 
> As long as it's for debug only and depends on EXPERT, it's fine by me.

Okay, I'll remove this default n.

Cheers,
-- 
Steve
