From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 15 Oct 2009 23:52:15 +0200
Subject: spitz: add gpio button support (fixes regression)
In-Reply-To: <1255643252.3985.63.camel@utx.utx.cz>
References: <20091006074635.GA2775@ucw.cz>
	<1254829732.3546.35.camel@utx.utx.cz>
	<20091007085806.GB28807@elf.ucw.cz>
	<1254914991.4213.80.camel@hammer.suse.cz>
	<20091007120643.GA17069@rakim.wolfsonmicro.main>
	<f17812d70910070727x47b2a22h8e9f9304740d5abf@mail.gmail.com>
	<20091006200933.GA1606@ucw.cz>
	<1255641385.3985.55.camel@utx.utx.cz>
	<20091015212024.GC15898@elf.ucw.cz>
	<1255643252.3985.63.camel@utx.utx.cz>
Message-ID: <20091015215215.GG15898@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2009-10-15 23:47:32, Stanislav Brabec wrote:
> Pavel Machek wrote:
> >Well, resume is hit by second regression.
> >
> >Suspend key.... I restored it to the level of functionality in
> >2.6.31 :-).
> 
> > > +		.type	= EV_KEY,
> > > +		.code	= KEY_SUSPEND,
> 
> I guess it should be EV_PWR. Then it will at least go to suspend.

Does it actually go to suspend with that change?

(Actually, I wonder how it could have ever worked: userspace should
certainly be in a loop there; kernel should not suspend machine on its
own. In -rp kernels, kernel _does_ suspend on its own, but... I'm not
sure if that's suitable for mainline).
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
