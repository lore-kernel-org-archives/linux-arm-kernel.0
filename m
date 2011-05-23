From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 23 May 2011 19:47:23 +0530
Subject: [PATCH 3/4] davinci: dm646x: remove the macros from the header
	to move to c file
In-Reply-To: <4DD684BE.7010600@mvista.com>
References: <1305900721-3890-1-git-send-email-manjunath.hadli@ti.com>
	<4DD684BE.7010600@mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D09B3CC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 20:41:58, Sergei Shtylyov wrote:

> > diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c

> > @@ -866,6 +865,13 @@ void __init dm646x_init_mcasp1(struct snd_platform_data *pdata)
> >  	platform_device_register(&dm646x_dit_device);
> >  }
> >  
> > +#define VDD3P3V_PWDN_OFFSET	0x48
> > +#define VSCLKDIS_OFFSET		0x6C
> > +#define VDD3P3V_VID_MASK	(BIT_MASK(3) | BIT_MASK(2) | BIT_MASK(1) |\
> > +					BIT_MASK(0))
> > +#define VSCLKDIS_MASK		(BIT_MASK(11) | BIT_MASK(10) | BIT_MASK(9) |\
> > +					BIT_MASK(8))
> 
>     I'd prefer that these remain on their places too. Let's wait for Sekhar's 
> word though...

I think there is some personal coding style involved here and
some folks prefer to keep the definitions near the actual usage
so that you don't have to scroll two or three pages up just
to see what the macro is defined to.

However, consistency is important too and almost all across
mach-davinci I see the defines (including base address
definitions) grouped at the top of the file. So, I will go
with what Sergei is saying here.

Thanks,
Sekhar
