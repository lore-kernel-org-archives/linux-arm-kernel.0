From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 29 Jul 2010 21:28:56 +0200
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v6)
In-Reply-To: <201007291313.29923.siarhei.siamashka@nokia.com>
References: <20100719180136.20305.7333.stgit@e200687-lin>
	<AANLkTik3CSSQLqajFimJxbq8TFBQ6iVx3RtdC9ObVj2-@mail.gmail.com>
	<20100728060649.GB1656@ucw.cz>
	<201007291313.29923.siarhei.siamashka@nokia.com>
Message-ID: <20100729192855.GA4298@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2010-07-29 13:13:29, Siarhei Siamashka wrote:
> On Wednesday 28 July 2010 09:06:49 ext Pavel Machek wrote:
> > On Mon 2010-07-19 22:02:12, Linus Walleij wrote:
> > > 2010/7/19 Kirill A. Shutemov <kirill@shutemov.name>:
> > > > Why do we need this? Why do not just fix broken programs?
> > >
> > > People tend to use some third-party precompiled binaries, some of
> > > them compiled with a compiler using SWP.
> >
> > Why not just let the cpu emulate it? It surely will be faster...?
> 
> IMHO, being able to identify the usage of SWP instructions and fix bad
> programs eventually (by spamming the said third-party programs bugtrackers) is
> a good enough reason.

Why do we need _emulation_ for that? 

Either you care about compatibility, then you let the CPU emulate SWP,
or you want to fix your userspace, so you turn off SWP emulation and
see what breaks.

I believe emulation just to annoy users into submitting bugreports is
serious overengineering.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
