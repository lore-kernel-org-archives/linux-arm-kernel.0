From: jhnikula@gmail.com (Jarkko Nikula)
Date: Fri, 1 Jul 2011 16:47:09 +0300
Subject: [RFC 11/12] omap: mcbsp: Remove conditional compilation for OMAP3
In-Reply-To: <CA+HSevqQhPP9YD=m_1Z7E=44hY0i4FFSoq7C1uP-aTsNXcMsiw@mail.gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
	<1309510356-27147-12-git-send-email-jhnikula@gmail.com>
	<CA+HSevqQhPP9YD=m_1Z7E=44hY0i4FFSoq7C1uP-aTsNXcMsiw@mail.gmail.com>
Message-ID: <20110701164709.3bc6dcbf.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Jul 2011 16:30:09 +0530
"Varadarajan, Charulatha" <charu@ti.com> wrote:

> > --- a/arch/arm/plat-omap/mcbsp.c
> > +++ b/arch/arm/plat-omap/mcbsp.c
> > @@ -63,7 +63,6 @@ static int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
> > ? ? ? ?}
> > ?}
> >
> > -#ifdef CONFIG_ARCH_OMAP3
> 
> Are there any plans to move the functions  omap_mcbsp_st_*
> to mach-omap2/* as they are specific to OMAP3 only?
> 
I was thinking that for saving code space for non !OMAP3 builds but
thats again is not generic code if sidetone IP gets ever reused in
another silicon. Another platform device for sidetone could be one
solution but I would like to preserve sidetone sysfs nodes to get
registered to McBSP port for keeping the userspace API the same during
the transition (or over a few kernel releases).

-- 
Jarkko
