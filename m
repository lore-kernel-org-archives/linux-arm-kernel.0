From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Mar 2015 23:09:13 +0000
Subject: [PATCH 2/5] ARM: orion: always use MULTI_IRQ_HANDLER
In-Reply-To: <20150302213749.GD2375@lunn.ch>
References: <1425328618-894030-1-git-send-email-arnd@arndb.de>
 <1425328618-894030-3-git-send-email-arnd@arndb.de>
 <20150302213749.GD2375@lunn.ch>
Message-ID: <20150302230912.GX8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 10:37:49PM +0100, Andrew Lunn wrote:
> On Mon, Mar 02, 2015 at 09:36:55PM +0100, Arnd Bergmann wrote:
> > As a preparation for multiplatform support, this enables
> > the MULTI_IRQ_HANDLER code unconditionally on dove and
> > orion5x, and introduces the respective code on mv78xx0,
> > which did not have it so far. The classic entry-macro.S
> > files are removed as they are now obsolete.
> 
> Hi Arnd
> 
> I don't know if it is relevant or not, but mach-dove IRQ handling is
> slightly broken. It uses IRQ 0. Russell King did provide a patch to
> move all the interrupts up by one, but it did not apply. I asked for a
> new version, rebased on the -rc1 of the time, but it never appeared.

That's because I only run non-rc kernels on my hardware, as I probably
explained at the time.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
