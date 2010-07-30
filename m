From: siarhei.siamashka@nokia.com (Siarhei Siamashka)
Date: Fri, 30 Jul 2010 13:04:54 +0300
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v6)
In-Reply-To: <20100729192855.GA4298@elf.ucw.cz>
References: <20100719180136.20305.7333.stgit@e200687-lin>
	<201007291313.29923.siarhei.siamashka@nokia.com>
	<20100729192855.GA4298@elf.ucw.cz>
Message-ID: <201007301304.54559.siarhei.siamashka@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 July 2010 22:28:56 ext Pavel Machek wrote:
> On Thu 2010-07-29 13:13:29, Siarhei Siamashka wrote:
> > On Wednesday 28 July 2010 09:06:49 ext Pavel Machek wrote:
> > > On Mon 2010-07-19 22:02:12, Linus Walleij wrote:
> > > > 2010/7/19 Kirill A. Shutemov <kirill@shutemov.name>:
> > > > > Why do we need this? Why do not just fix broken programs?
> > > >
> > > > People tend to use some third-party precompiled binaries, some of
> > > > them compiled with a compiler using SWP.
> > >
> > > Why not just let the cpu emulate it? It surely will be faster...?
> >
> > IMHO, being able to identify the usage of SWP instructions and fix bad
> > programs eventually (by spamming the said third-party programs
> > bugtrackers) is a good enough reason.
>
> Why do we need _emulation_ for that?

In order to have it trapped and recorded in log, while still not causing 
disasterous effects for the users (their applications still work).

> Either you care about compatibility, then you let the CPU emulate SWP,
> or you want to fix your userspace, so you turn off SWP emulation and
> see what breaks.

In practice, nobody would turn off SWP emulation ever in such setup, and the
problems will remain unresolved for ages.

> I believe emulation just to annoy users into submitting bugreports is
> serious overengineering.

It's not to annoy them, but to provide the users with the information about 
valid problems in their applications. It's up to the users to either do 
anything with it, or ignore.

-- 
Best regards,
Siarhei Siamashka
