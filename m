From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 15 Feb 2013 01:12:42 +0000 (UTC)
Subject: [PATCH] ARM: OMAP: hwmod_reset: Include errno.h to fix compilation
 error
In-Reply-To: <1359377743-30663-1-git-send-email-peter.ujfalusi@ti.com>
References: <1359377743-30663-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.00.1302150111360.11016@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi P?ter,

On Mon, 28 Jan 2013, Peter Ujfalusi wrote:

> Without the errno.h:
>   CC      arch/arm/mach-omap2/omap_hwmod_reset.o
> arch/arm/mach-omap2/omap_hwmod_reset.c: In function ?omap_hwmod_aess_preprogram?:
> arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: error: ?EINVAL? undeclared (first use in this function)
> arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: note: each undeclared identifier is reported only once for each function it appears in
> make[1]: *** [arch/arm/mach-omap2/omap_hwmod_reset.o] Error 1
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Paul,
> 
> I could not find the patches from Sebastien's series:
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg82971.html
> 
> But AFAIK you have taken them for 3.9.
> 
> This patch is on top of it to fix compilation error.
> 
> Regards,
> Peter

Thanks for sending this.  I didn't know what to do with it at the time 
since the patches seemed to build with omap2plus_defconfig, but now after 
Arnd's E-mail it's clear that this was needed for multiplatform builds.  
Sorry about the misunderstanding...


- Paul
