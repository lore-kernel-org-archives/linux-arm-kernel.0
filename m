From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Dec 2014 13:44:58 +0100
Subject: How much flash space should I reserve for device tree blobs?
In-Reply-To: <20141216122224.GG967@titan.lakedaemon.net>
References: <CAFZh4h_74LY=w7gV=zNAC0ssRFgrh1DduPmZ2c+HenbztRRc-A@mail.gmail.com>
 <20141216122224.GG967@titan.lakedaemon.net>
Message-ID: <94604137.TN9zLIKKd4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 December 2014 07:22:24 Jason Cooper wrote:
> 
> On Mon, Dec 15, 2014 at 03:33:50PM -0500, Brian Hutchinson wrote:
> > Reflecting back on the famous quote of "Nobody needs more than 640K",
> > how much space should I reserve in flash to 'future proof' my MTD map
> > in regards to dtb's?
> > 
> > Looking at the current flavors of dtb's built in a recent mainline
> > kernel, the biggest one I see is 66K.
> > 
> > How big do you all see these getting?  I know, it's probably a loaded
> > question.  Would just like to bounce this off the list as a sanity
> > check ... measure twice cut once kind of thing.
> 
> There's probably better folks to answer this than me (former powerpc
> folks, eg Arnd, Olof), but since I've had to consider it as well, I'll
> tell you my thoughts.

I thought that these days a lot of boot loaders can just access file
systems. If you use a FAT or ext4 file system (on block based storage)
or something like UBI (on raw flash) to store both the kernel and DT,
you should be able to avoid hardcoding sizes.

It also depends on how much space you have total. On an eMMC, I would
just round up to whole megabytes, but if you have only 4MB of NOR flash
available, you have to be more conservative.

	Arnd
