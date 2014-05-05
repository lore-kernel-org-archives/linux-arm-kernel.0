From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 May 2014 17:01:53 +0200
Subject: [PATCH 0/4] Introducing Exynos ChipId driver
In-Reply-To: <4239261.HFHm7SU1iH@wuerfel>
References: <1399097500-4052-1-git-send-email-pankaj.dubey@samsung.com>
 <536758AB.2060503@samsung.com> <4239261.HFHm7SU1iH@wuerfel>
Message-ID: <5374218.SlGnAKNqhD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 May 2014 16:58:14 Arnd Bergmann wrote:
> > Also for platsmp.c and pm.c I can think of following approaches
> > 1: Keep these macros till we get generic solution?
> > 2: Allow chipid driver to expose APIs to check SoC id and SoC revisions 
> > till we get
> > generic solution. So that at least we can remove #ifdef  based macros
> > as soc_is_exynosXYZ.
> > 3: Use of "of_flat_dt_is_compatible" or similar APIs in these machine files 
> > till we get
> > generic solution. For some cases where we want to know SoC revision let us
> > map chipid register and get revision there itself.
> > 
> > Please let me know what approach you think will be good?
> 
> I think 1 or 2 would be better than 3. Between those two, I'm undecided,
> but I think either way the SoC specific values would be better kept in the
> mach-samsung directory than in plat/cpu.h or linux/exynos-chipid.h.

Actually, a good compromise for now would be to add the chipid driver
to mach-exynos instead of drivers/bus. This way you can keep the uses
of the ID local to the exynos platform code until it's no longer needed.
Then it can get moved out to drivers/soc to be shared with arm64.

	Arnd
