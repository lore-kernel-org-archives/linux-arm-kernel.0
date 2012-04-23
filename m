From: pavel@denx.de (Pavel Machek)
Date: Mon, 23 Apr 2012 21:40:42 +0200
Subject: Sharing header files -- arch/arm/mach-generic  ?
Message-ID: <20120423194042.GA5734@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I have new architecture I'd like to merge into the mainline. It has
some code very similar to existing plaforms (for example
real differences to mach-realview/platsmp.c are two lines.)

Is that a problem?

Should mach-generic/platsmp.c be created, so code can be better
shared? Or are the code pieces small enough that this duplication can
be ignored?

headsmp.S is another candidate for sharing. AFAICT we have 4 times
identical code in the tree already:

./mach-exynos/headsmp.S:   ldmia	r4, {r5, r6}
./plat-versatile/headsmp.S:		ldmia	 r4, {r5, r6}
./mach-ux500/headsmp.S:			ldmia	 r4, {r5, r6}
./mach-msm/headsmp.S:			ldmia	 r4, {r5, r6}

Thoughts?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
