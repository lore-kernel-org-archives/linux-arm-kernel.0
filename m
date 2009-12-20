From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sun, 20 Dec 2009 20:32:27 +0100
Subject: [CFT:PATCH] Remove a seemingly unnecessary cache flush
In-Reply-To: <19238.11361.430323.182240@pilspetsen.it.uu.se>
References: <20091207221210.GI26821@n2100.arm.linux.org.uk>
	<20091210104037.GC6207@n2100.arm.linux.org.uk>
	<19238.9843.212077.875686@pilspetsen.it.uu.se>
	<20091214115318.GA12207@n2100.arm.linux.org.uk>
	<19238.11361.430323.182240@pilspetsen.it.uu.se>
Message-ID: <19246.31691.590625.218114@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson writes:
 > Russell King - ARM Linux writes:
 >  > On Mon, Dec 14, 2009 at 12:50:11PM +0100, Mikael Pettersson wrote:
 >  > > Russell King - ARM Linux writes:
 >  > >  > On Mon, Dec 07, 2009 at 10:12:10PM +0000, Russell King - ARM Linux wrote:
 >  > >  > > While looking into the possible msync() issue (which turned out to be a
 >  > >  > > non-issue - it's covered by clever code), I found that we're flushing
 >  > >  > > the same page multiple times.
 >  > >  > 
 >  > >  > I'm going to queue this patch up today since I believe it is correct,
 >  > >  > though it would be nice to have a few more people test it on pre-ARMv6
 >  > >  > hardware.
 >  > > 
 >  > > Tested here with gcc and glibc builds and testsuite runs on IXP420,
 >  > > IOP80219, and Kirkwood (Feroceon?), all ARMv5TE. No signs of problems.
 >  > 
 >  > Do the builds appear to be any faster?
 > 
 > I didn't record how long it took because I was mainly interested in
 > the correctness aspect. I can do a pair of properly measured gcc
 > builds on the fastest machine next weekend.

On my Kirkwood (1.2GHz QNAP TS-119) the time to do a gcc-4.4 bootstrap
(all default languages) and testsuite run is 87561 seconds with a
vanilla 2.6.32 kernel and 86719 seconds when this patch is applied.
That's a 1% improvement.

Tested-by: Mikael Pettersson <mikpe@it.uu.se>
