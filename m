From: mikpe@it.uu.se (Mikael Pettersson)
Date: Mon, 14 Dec 2009 12:50:11 +0100
Subject: [CFT:PATCH] Remove a seemingly unnecessary cache flush
In-Reply-To: <20091210104037.GC6207@n2100.arm.linux.org.uk>
References: <20091207221210.GI26821@n2100.arm.linux.org.uk>
	<20091210104037.GC6207@n2100.arm.linux.org.uk>
Message-ID: <19238.9843.212077.875686@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > On Mon, Dec 07, 2009 at 10:12:10PM +0000, Russell King - ARM Linux wrote:
 > > While looking into the possible msync() issue (which turned out to be a
 > > non-issue - it's covered by clever code), I found that we're flushing
 > > the same page multiple times.
 > 
 > I'm going to queue this patch up today since I believe it is correct,
 > though it would be nice to have a few more people test it on pre-ARMv6
 > hardware.

Tested here with gcc and glibc builds and testsuite runs on IXP420,
IOP80219, and Kirkwood (Feroceon?), all ARMv5TE. No signs of problems.

/Mikael
