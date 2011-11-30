From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Nov 2011 12:15:08 +0000
Subject: [PATCH v3 0/5] Versatile Express DT support
In-Reply-To: <20111130120818.GB2045@localhost.localdomain>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <20111129170013.GD2829@localhost.localdomain>
 <1322587019.3164.111.camel@hornet.cambridge.arm.com>
 <20111130104842.GA2045@localhost.localdomain>
 <1322651640.3164.135.camel@hornet.cambridge.arm.com>
 <20111130120818.GB2045@localhost.localdomain>
Message-ID: <1322655308.3164.177.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-30 at 12:08 +0000, Dave Martin wrote:
> Your suggestion fixes it -- I suggest we keep the config this way round;
> this means that OF gets turned on when enabling a coretile which requires
> it, and those coretiles are offered as choices even before OF is turned
> on.  That feels like a sensible behaviour for the config.

Ok.

> While we're about this, building of the applicable dtbs is not currently
> enabled.
> 
> Can we add this, so that "make dtbs" works?
> 
> diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
> index 05b77a5..b89ffde 100644
> --- a/arch/arm/mach-vexpress/Makefile.boot
> +++ b/arch/arm/mach-vexpress/Makefile.boot
> @@ -7,3 +7,7 @@ else
>  params_phys-y	:= 0x60000100
>  initrd_phys-y	:= 0x60800000
>  endif
> +
> +dtb-$(CONFIG_ARCH_VEXPRESS_V2P_CA5S_CA9) += \
> +					vexpress-v2p-ca5s.dtb \
> +					vexpress-v2p-ca9.dtb

Yes, I already have more-or-less the same thing.

Cheers!

Pawe?
