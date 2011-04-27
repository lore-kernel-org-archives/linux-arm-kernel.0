From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2011 21:33:40 +0200
Subject: MMC and reliable write - was: since when does ARM map the kernel
	memory in sections?
In-Reply-To: <BANLkTimMvGfkmcXKrM=vtFNGqdoUJpqwcw@mail.gmail.com>
References: <201104122052.17453.pwaechtler@mac.com>
	<20110427130719.GE5832@shareable.org>
	<BANLkTimMvGfkmcXKrM=vtFNGqdoUJpqwcw@mail.gmail.com>
Message-ID: <201104272133.40990.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2011 21:18:16 Andrei Warkentin wrote:
> On Wed, Apr 27, 2011 at 8:07 AM, Jamie Lokier <jamie@shareable.org> wrote:
> > Andrei Warkentin wrote:

> > No, that's a scheduling hint; you can't assume filesystems
> > consistently label "metadata needed for filesystem integrity" with
> > that flag.  (And databases and VMs have similar needs, but don't get
> > to choose REQ_ flags).
> >
> > But even if they did, wouldn't a single normal write, from the above
> > description, potentially corrupt all previously written metadata
> > anyway, making it pointless?
> 
> Gah... yes.

I've also seen devices that produce silent bit errors or just swap
blocks around without any power fail scenario, no matter what or
how you write to them. I believe we don't need to support those.

We should find out what the guarantees are that the eMMC standard
is giving. It should be possible to build media that can not
corrupt data written with reliable writes by writing to other
data in the same erase block. If the standard requires that to
happen, I'd say we should rely on it and consider the other
media as broken.

	Arnd
