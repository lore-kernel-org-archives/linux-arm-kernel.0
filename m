From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 11 Jun 2010 16:36:00 +0200
Subject: [PATCH 2/2] pxa/spitz: Rework spitz
In-Reply-To: <201006110852.45838.marek.vasut@gmail.com>
References: <1276238740-10640-1-git-send-email-marek.vasut@gmail.com>
	<1276238740-10640-2-git-send-email-marek.vasut@gmail.com>
	<201006110852.45838.marek.vasut@gmail.com>
Message-ID: <20100611143600.GA1307@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2010-06-11 08:52:45, Marek Vasut wrote:
> Dne P? 11. ?ervna 2010 08:45:40 Marek Vasut napsal(a):
> > This huge patch mostly shuffles code. The spitz.c file contained terrible
> > mess and needed a cleanup, here it is:
> > 
> > 1) Made every part modular, components are not built in if not selected.
> > 2) Removed loads of preprocessor goo, mostly "#ifdef MACH_AKITA ....
> > #endif" and similar code. The kernel size will grow by a few kb now, but
> > the file is much more readable.
> > 3) Reworked SD/CF power setting function and made it reentrant.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
> >  arch/arm/mach-pxa/include/mach/spitz.h |    2 -
> >  arch/arm/mach-pxa/spitz.c              |  748
> > ++++++++++++++++++-------------- 2 files changed, 420 insertions(+), 330
> > deletions(-)
> > 
> 
> Pavel, Eric, I tested this on metan's Z, could you give it a go ?

quick test on 2.6.35-rc2 (of the 2nd version), and all seems
well. What should I look for?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
