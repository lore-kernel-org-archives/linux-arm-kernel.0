From: robin.randhawa@gmail.com (Robin Randhawa)
Date: Mon, 18 Jan 2010 21:35:20 +0000
Subject: Elusive crash in SMC91X/PXA network code?
In-Reply-To: <alpine.DEB.1.10.1001181825560.22774@venus.araneidae.co.uk>
References: <alpine.DEB.1.10.1001181825560.22774@venus.araneidae.co.uk>
Message-ID: <20100118213519.GA58659@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 06:27:19PM +0000, Michael Abbott wrote:
> The bug in question is most reliably forced by transferring a very large 
> file over NFS while the embedded driver is performing DMA transfers (from 
> FPGA to XCEP RAM); it is also possible to force the crash by sending 
> enough UDP packets to the device; I've had no success in forcing the crash 
> with any other form of network load.  It can take anything from a few 
> seconds to many minutes of such stress for the crash to occur.

This sounds almost exactly like a problem I've experienced before,
although that was on a development board built around a different
processor architecture. Kept experiencing mysterious memory junking
which seemed to precipitate quicker when performing large file transfers
over NFS.

The ethernet controller (an Intel eepro 100 IIRC) had diagnostics which
seemed to indicate checksumming errors. After trying virtually every
trick in the book, it turned out to be a subtle misconfiguration of the
SDRAM RAS-to-CAS delay timing which the bootloader had messed up. With
that fixed, everything worked without a hitch.

Worth a shot, IMHO.

Cheers,
Robin
