From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 20 Nov 2009 11:57:26 +0100
Subject: [PATCH 2/3] staging/dream: add missing include files
In-Reply-To: <20091119225602.GC18710@kroah.com>
References: <20091101222717.GB20740@elf.ucw.cz>
	<20091119225602.GC18710@kroah.com>
Message-ID: <20091120105726.GH11212@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2009-11-19 14:56:02, Greg KH wrote:
> On Sun, Nov 01, 2009 at 11:27:17PM +0100, Pavel Machek wrote:
> > Add missing files/includes neccessary for Dream compilation.
> >     
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> This patch includes a file that is not in the drivers/staging/
> directory, and it does this Kconfig mess:

Oops, sorry. That one escaped me. I'll submit fixed version.

> > +config GENERIC_GPIO
> > +	bool
> > +	default y
> 
> Which breaks the i386 build.  Don't force on a general config option
> like this, that's not nice at all :(

Ok, I should figure out how to limit it to arch-msm.

> So I'll not apply this one, and the 3/3 patch.

Where can I get the tree to diff against?
gregkh-08-staging-2.6.32-rc7-git4.patch just reverts everything.

I guess I can extract it from
://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/series ...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
