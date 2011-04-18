From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 18 Apr 2011 15:52:44 +0200
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <20110412203303.GA16019@shareable.org>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
	<20110412203303.GA16019@shareable.org>
Message-ID: <20110418135243.GB1479@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi!

> > > did the ARM Linux 2.6 kernel map the kernel memory in pages in the past?
> > > Or was the memory always mapped in sections?
> > >
> > > I still have to chase a potential memory corruption. The rootfs is located on
> > > a SDcard and gets corrupted even when the filesystem test programs write to
> > > different partitions.
> > > The test scenario includes several dozen or even hundreds of warm and cold
> > > boot sequences, file system write tests with sudden soft resets. It's a large
> > > embedded project with a lot of drivers and the fact that always the rootfs and
> > > often the superblock gets damaged let me think of a memory corruption.
> > >
> > 
> > Sorry, I don't want to be obvious, but you mentioned sudden resets
> > while writing, which is almost always going to wind
> > up as fs corruptions, with the severity depending on the level of
> > caching the system is doing to the writes.
> > How are you mounting your rootfs and what file system are you using?
> > What sort of corruptions to the super block are you seeing?
> 
> If everything is implemented correctly, that depends on the type of
> filesystem, block layer and storage.  Some are explicitly designed to
> be safe against sudden reboots and power failure - which is an
> important feature of systems where removing the power is how they are
> turned off at night.

...but note that no existing  filesystem is safe on media such
as usb sticks, SD and CF cards...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
