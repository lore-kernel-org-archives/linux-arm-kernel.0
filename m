From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 4 Apr 2013 08:47:22 +0200 (CEST)
Subject: [PATCH/RFC 2/3] ARM: shmobile: initialise clock early on
 kzm9g-reference
In-Reply-To: <87zjxfdtt8.wl%kuninori.morimoto.gx@renesas.com>
References: <1365005636-17526-1-git-send-email-g.liakhovetski@gmx.de>
 <1365005636-17526-3-git-send-email-g.liakhovetski@gmx.de>
 <87zjxfdtt8.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <Pine.LNX.4.64.1304040830380.21548@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san

On Wed, 3 Apr 2013, Kuninori Morimoto wrote:

> Hi Guennadi
> 
> > To prepare to enable TWD on kzm9g-reference, clock initialisation has to be
> > done early. Move it from .init_machine to .init_time stage.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> (snip)
> > +static void __init timer_init(void)
> > +{
> > +	sh73a0_clock_init();
> > +	shmobile_timer_init();
> > +}
> 
> I'm not sure detail,
> but, shmobile_timer_init() will be removed.
> 
> Can you check these patch/email on SH-ML or ARM ML ?
> 
> Subject: [PATCH v2 02/13] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
> Date:	Mon,  1 Apr 2013 17:21:12 -0500
> 
> Subject: [PATCH v2 02/13] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
> Date:	Mon,  1 Apr 2013 17:21:12 -0500

Did you mean two different patches or was the duplication an accident? 
Anyway, thanks for a heads-up! I checked that patch, interesting. At least 
it's conflicting with this patch from Magnus:

"ARM: shmobile: Register DT TWD from timer.c"
https://patchwork.kernel.org/patch/2222551/

I know those patches are on a hold, but I was using the one above locally. 
If shmobile_timer_init() is removed, this won't be a huge problem for this 
work, I'll just have to call twd_local_timer_of_register() directly from 
.init_time, but whether these patches are good for upstream at all is 
another question, I'll expand on it a bit in a reply to Simon's mail.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
