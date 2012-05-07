From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 May 2012 10:33:51 -0700
Subject: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <CAJ7qFSfkHGF7ehanZP=hyZ27HqSp1ONsT0tUV-wpLne9B4DEaQ@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
 <CAJ7qFSfkHGF7ehanZP=hyZ27HqSp1ONsT0tUV-wpLne9B4DEaQ@mail.gmail.com>
Message-ID: <20120507173351.GB5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* R, Sricharan <r.sricharan@ti.com> [120506 00:40]:
>
> > Also, please change the whole series to use CONFIG_SOC_OMAP5 instead
> > of CONFIG_ARCH_OMAP5. CONFIG_ARCH_OMAPXXXX stuff will go away except
> > for CONFIG_ARCH_OMAP2PLUS. Sorry forgot to mention that earlier.
> >
>  ok. sure. will change this.

Thanks.
 
> >> -#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) || ? ?\
> >> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? defined(CONFIG_ARCH_OMAP3))
> >> +#if (defined(CONFIG_ARCH_OMAP5) || defined(CONFIG_ARCH_OMAP4)) && \
> >> + ? ? ? ? ? ? !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
> >> +
> >> ?static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
> >> ?{
> >> ? ? ? WARN(1, "prm: omap2xxx/omap3xxx specific function and "
> >
> > Maybe these functions could be just set up as __weak to avoid the
> > ifdeffery?
> >
>  sorry to understand,
>  you mean make this weak and have a strong override for OMAP2 ?

Yeah that should do the trick, right?
 
Regards,

Tony
