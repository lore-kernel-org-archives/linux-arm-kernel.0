From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 21:05:02 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151125183728.GO8644@n2100.arm.linux.org.uk>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <20151125160937.GJ14338@lunn.ch>
 <20151125183728.GO8644@n2100.arm.linux.org.uk>
Message-ID: <2762753.604XuTRa75@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 18:37:28 Russell King - ARM Linux wrote:
> On Wed, Nov 25, 2015 at 05:09:37PM +0100, Andrew Lunn wrote:
> > Russell, you are the last known user of mach-dove. What are your
> > plans? You keep saying you have given up trying to mainline your Cubox
> > patches. Have you really given up? Can we remove mach-dove?
> 
> Right now, I'm developing etnaviv in spare time on the Cubox[*], which
> is still primarily running a non-DT kernel.
> 
> It's actually a kernel that I've hacked which is capable of booting
> both DT and non-DT, but even when booted in DT mode, I still require
> much of the arch/arm/mach-dove infrastructure to get things like
> armada-drm, etnaviv and other drivers running.  Especially because
> we're missing things like the high-speed clocks (the stuff above the
> tclk domain.)  I've not even started to work out how to get that
> into mainline, or how to integrate that with CCF.  Quite what can be
> done with the audio patches, I've no idea, that remains a bone of
> contention and stalemate, and currently isn't DT-able.  See the list
> of patches at the end of this message...

I think it's ok to keep mach-dove around for a longer time to keep the
board file, I'm way more interested in completing the multiplatform
work at last.

If I understand you right, being able to build mach-dove and mach-mvebu
together will actually help you remove one or more of your patches,
but of course will require a small bit of rebasing.

	Arnd
