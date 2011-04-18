From: pwaechtler@mac.com (Peter Waechtler)
Date: Mon, 18 Apr 2011 19:21:04 +0000 (GMT)
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <20110418135243.GB1479@ucw.cz>
Message-ID: <07919bf9-f05f-ca1c-c084-c4ee18a9dc58@me.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hmh,

I'm not 100% sure, but a lot of people made good experience with JFFS2.

Is it that hard to get a log structured file system power fail safe?
Either the end or "commit" block was written or not?

??Peter
?

On 18 Apr, 2011,at 03:52 PM, Pavel Machek <pavel@ucw.cz> wrote:


Hi!

> > > did the ARM Linux 2.6 kernel map the kernel memory in pages in the past?
> > > Or was the memory always mapped in sections?
> > >
> > > I still have to chase a potential memory corruption. The rootfs is located on
> > > a SDcard and gets corrupted even when the filesystem test programs write to
> > > different partitions.
> > > The test scenario includes several dozen or even hundreds of warm and cold
> > > boot sequences, file system write tests with sudden soft resets It's a large
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
> filesystem, block layer and storage. Some are explicitly designed to
> be safe against sudden reboots and power failure - which is an
> important feature of systems where removing the power is how they are
> turned off at night.

...but note that no existing filesystem is safe on media such
as usb sticks, SD and CF cards...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mffcuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110418/bff5d2f9/attachment.html>
