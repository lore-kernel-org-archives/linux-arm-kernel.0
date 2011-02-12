From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 16:37:02 +0000
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102121728.32585.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102121145.42053.arnd@arndb.de>
	<20110212105918.GG15616@n2100.arm.linux.org.uk>
	<201102121728.32585.arnd@arndb.de>
Message-ID: <20110212163702.GB22402@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 05:28:32PM +0100, Arnd Bergmann wrote:
> On Saturday 12 February 2011 11:59:18 Russell King - ARM Linux wrote:
> > Unrelated, I have a USB based device which provides an emulated FAT
> > filesystem - all files except one on this filesystem are read-only.
> > The writable file is a textual configuration file.  It can be reliably
> > updated by Windows based systems, but updates from Linux based systems
> > are ignored - presumably because updates to the FAT/directory/data
> > clusters are occuring in a different order.
> 
> Fun. I think qemu also comes with one of these FAT emulation layers,
> as do some mp3 players, but from what I have heard, they are not as
> broken.

Given that it is a secure GPS/barographic flight logger which has
approval for ratifing world record flight claims, you may understand why
it has to be extremely picky about how it interfaces with the external
world.  Especially restricting updates to modification of the
configuration file, while not allowing any of the logged data files to
be changed in any way.
