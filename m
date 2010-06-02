From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jun 2010 16:59:47 +0100
Subject: [PATCH] Augment __naked__ function attribute with __noinline__
	and __noclone__
In-Reply-To: <19462.19024.560502.149871@pilspetsen.it.uu.se>
References: <1275379552-23449-1-git-send-email-mikpe@it.uu.se>
	<19462.19024.560502.149871@pilspetsen.it.uu.se>
Message-ID: <20100602155947.GA872@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 02, 2010 at 02:10:56PM +0200, Mikael Pettersson wrote:
> Mikael Pettersson writes:
>  > The asm() bodies of naked functions often depend on standard calling
>  > conventions, therefore they must be noinline and noclone.  GCC 4.[56]
>  > currently fail to enforce this, see GCC PR44290.  The effect is that
>  > most arch/arm/mm/copypage-*.c modules get miscompiled, resulting in
>  > kernel crashes during bootup.
>  > 
>  > Part of the fix is to augment the __naked attribute to imply noinline
>  > and noclone.  This patch implements that, and has been verified to fix
>  > the failure to boot a gcc-4.5 compiled 2.6.34 kernel on a Thecus n2100
>  > (XScale-based mach-iop32x).
> 
> Now also tested with a gcc-4.5 compiled 2.6.35-rc1 kernel on a ds101
> (XScale-based mach-ixp4xx).

I think this needs to go somewhere near linux-kernel.
