From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Sep 2015 17:49:29 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56056939.5090409@free.fr>
References: <56001B78.2090001@free.fr> <56056836.4060307@free.fr>
 <56056939.5090409@free.fr>
Message-ID: <6909066.JodC72LHrN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 September 2015 17:33:13 Mason wrote:
> On 25/09/2015 17:28, Mason wrote:
> 
> > About NEON. I had 'select VFP' but I see that CPU_V7 enables VFPv3 and VFP.
> > Isn't NEON required to support user-space programs using NEON instructions?
> > arch/arm/kernel/entry-armv.S
> 
> I'm taking cues from exynos and omap2, are these good references?
> 
> config ARCH_OMAP2PLUS_TYPICAL (default y) selects NEON if CPU_V7.
> Can I do something similar? (My platform is only CPU_V7.)

No, you should leave it turned off and just enable that option in the
defconfig. There is no need to prevent anyone from running a kernel
with NEON disabled if they have matching user space.

	Arnd
