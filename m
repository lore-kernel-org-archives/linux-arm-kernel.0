From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 16 Oct 2009 11:39:51 +0200
Subject: spitz: add gpio button support (fixes regression)
In-Reply-To: <1255685315.5470.3.camel@hammer.suse.cz>
References: <20091007085806.GB28807@elf.ucw.cz>
	<1254914991.4213.80.camel@hammer.suse.cz>
	<20091007120643.GA17069@rakim.wolfsonmicro.main>
	<f17812d70910070727x47b2a22h8e9f9304740d5abf@mail.gmail.com>
	<20091006200933.GA1606@ucw.cz>
	<1255641385.3985.55.camel@utx.utx.cz>
	<20091015212024.GC15898@elf.ucw.cz>
	<1255643252.3985.63.camel@utx.utx.cz>
	<20091015215215.GG15898@elf.ucw.cz>
	<1255685315.5470.3.camel@hammer.suse.cz>
Message-ID: <20091016093950.GI15898@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > (Actually, I wonder how it could have ever worked: userspace should
> > certainly be in a loop there; kernel should not suspend machine on its
> > own. In -rp kernels, kernel _does_ suspend on its own, but... I'm not
> > sure if that's suitable for mainline).
> 
> At least userspace apmd should be able to enter into suspend process
> (tested in 2.6.26-RP, not yet verified in 2.6.32-rc*).
> 
> I don't know, what is the preferred way in recent days, but Tosa does
> the same.

Ok, lets do it that way, then. I guess you need to post patch with
your signed-off-by, and you can add my acked-by.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
