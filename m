From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 17:34:30 +0100
Subject: [PATCH 2/2] ARM: mm: hide __start_rodata_section_aligned for
 non-debug builds
In-Reply-To: <CAKv+Gu8JcWg4BkxZFPqTotkfHFtP744XYdSx6XROJSM_8pmt2w@mail.gmail.com>
References: <1455638631-3326518-1-git-send-email-arnd@arndb.de>
 <1455638631-3326518-2-git-send-email-arnd@arndb.de>
 <CAKv+Gu8JcWg4BkxZFPqTotkfHFtP744XYdSx6XROJSM_8pmt2w@mail.gmail.com>
Message-ID: <4716656.D1MJCNd1N6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 17:12:52 Ard Biesheuvel wrote:
> > +#ifdef CONFIG_DEBUG_RODATA
> >  /*
> >   * Without CONFIG_DEBUG_ALIGN_RODATA, __start_rodata_section_aligned will
> >   * be the first section-aligned location after __start_rodata. Otherwise,
> >   * it will be equal to __start_rodata.
> >   */
> >  __start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);
> > +#endif
> >
> 
> Does
> 
> PROVIDE(__start_rodata_section_aligned = xxx);
> 
> do the trick as well? If it does, it's a bit cleaner.
> 

I would assume not, as the problem is that SECTION_SHIFT is a macro that
is not defined when the MMU is disabled.

	Arnd
