From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Aug 2013 20:45:01 +0200
Subject: [RFC] cleanup mach-s5p*
In-Reply-To: <14202744.Ci7A03X8EJ@flatron>
References: <1f7b01cea1f6$9560aa10$c021fe30$%kim@samsung.com>
 <14202744.Ci7A03X8EJ@flatron>
Message-ID: <1800157.XgqPQtAyXL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 August 2013 02:08:16 Tomasz Figa wrote:
> 
> Well, if we could drop legacy board file support for them and keep them as 
> DT only, support for them could be reasonably simple. Basically the code 
> in arch/arm would be limited to a single .c file per SoC (e.g. mach-
> s5pv210-dt.c), a bunch of SoC-level .dtsi files and a bunch of board dts 
> files.

Sounds good.

> IMHO the best thing we could do would be creating a single mach-samsung, 
> where all the DT-only platforms could be located, including Exynos after 
> some remaining consolidation.

Yes, that seems like a reasonable goal for the long run. I guess the best
way to get there might be to move the s5pxxxx platforms into mach-exynos
one by one and make sure they can coexist in a multiplatform kernel.
Consolidating s3c24xx and exynos into a single platform is less interesting
because they won't run the same kernel anyway, but I also don't see any
reason against doing it. Not sure how s3c64xx would fit in then, since
it's ARMv6 but somewhat closer to the s3c24xx code base than to exynos.

	Arnd
