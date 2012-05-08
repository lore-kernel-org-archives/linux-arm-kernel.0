From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 May 2012 22:03:09 +0800
Subject: [PATCH 2/6] dma: mxs-dma: let dma_is_apbh and apbh_is_old take
 parameter
In-Reply-To: <201205080137.00184.marex@denx.de>
References: <1336400595-12964-1-git-send-email-shawn.guo@linaro.org>
 <1336400595-12964-3-git-send-email-shawn.guo@linaro.org>
 <201205080137.00184.marex@denx.de>
Message-ID: <20120508140307.GC2199@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 01:37:00AM +0200, Marek Vasut wrote:
> >  #define HW_APBH_VERSION				(cpu_is_mx23() ? 0x3f0 : 
> 0x800)
> >  #define HW_APBX_VERSION				0x800
> >  #define BP_APBHX_VERSION_MAJOR			24
> > -#define HW_APBHX_CHn_NXTCMDAR(n) \
> > -	(((dma_is_apbh() && apbh_is_old()) ? 0x050 : 0x110) + (n) * 0x70)
> > -#define HW_APBHX_CHn_SEMA(n) \
> > -	(((dma_is_apbh() && apbh_is_old()) ? 0x080 : 0x140) + (n) * 0x70)
> > +#define HW_APBHX_CHn_NXTCMDAR(d, n) \
> > +	(((dma_is_apbh(d) && apbh_is_old(d)) ? 0x050 : 0x110) + (n) * 0x70)
> > +#define HW_APBHX_CHn_SEMA(d, n) \
> > +	(((dma_is_apbh(d) && apbh_is_old(d)) ? 0x080 : 0x140) + (n) * 0x70)
> 
> Well ... if you got rid of the above magic values, it'd be cool ;-)
> 
I just do not think it's really worth another set of marcos.

-- 
Regards,
Shawn
