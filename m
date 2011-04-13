From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 13 Apr 2011 21:11:14 +0100
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <alpine.LFD.2.00.1104131125380.24613@xanadu.home>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
	<20110412203303.GA16019@shareable.org>
	<alpine.LFD.2.00.1104131125380.24613@xanadu.home>
Message-ID: <20110413201114.GB16019@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> On Tue, 12 Apr 2011, Jamie Lokier wrote:
> 
> > Andrei Warkentin wrote:
> > > Hi Peter,
> > > 
> > > 2011/4/12 Peter W?chtler <pwaechtler@mac.com>:
> > > > Hello Linux ARM developers,
> > > >
> > > > did the ARM Linux 2.6 kernel map the kernel memory in pages in the past?
> > > > Or was the memory always mapped in sections?
> > > >
> > > > I still have to chase a potential memory corruption. The rootfs is located on
> > > > a SDcard and gets corrupted even when the filesystem test programs write to
> > > > different partitions.
> > > > The test scenario includes several dozen or even hundreds of warm and cold
> > > > boot sequences, file system write tests with sudden soft resets. It's a large
> > > > embedded project with a lot of drivers and the fact that always the rootfs and
> > > > often the superblock gets damaged let me think of a memory corruption.
> > > >
> > > 
> > > Sorry, I don't want to be obvious, but you mentioned sudden resets
> > > while writing, which is almost always going to wind
> > > up as fs corruptions, with the severity depending on the level of
> > > caching the system is doing to the writes.
> > > How are you mounting your rootfs and what file system are you using?
> > > What sort of corruptions to the super block are you seeing?
> > 
> > If everything is implemented correctly, that depends on the type of
> > filesystem, block layer and storage.  Some are explicitly designed to
> > be safe against sudden reboots and power failure - which is an
> > important feature of systems where removing the power is how they are
> > turned off at night.
> 
> SD was mentioned as being the storage medium in this thread. I really 
> doubt SD cards are designed to be safe against sudden power outages.

Ah, fair enough, you are sadly almost certainly right.

(Some flash even corrupts itself on power removal during reads too,
due to internal reorganisation.  I have no idea if SD is in that
category.  It is quite a problem when searching for something to
replace an old-fashioned hard disk in an application where removing
the power is normal daily usage, and traditional journalling
filesystems used to be effective.)

-- Jamie
