From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Mar 2015 22:44:29 +0100
Subject: [PATCH 2/5] ARM: orion: always use MULTI_IRQ_HANDLER
In-Reply-To: <20150302213749.GD2375@lunn.ch>
References: <1425328618-894030-1-git-send-email-arnd@arndb.de>
 <1425328618-894030-3-git-send-email-arnd@arndb.de>
 <20150302213749.GD2375@lunn.ch>
Message-ID: <3837321.hdTlmGSKIx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 March 2015 22:37:49 Andrew Lunn wrote:
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

Ok.

My guess is that my patch doesn't change that problem for better or
worse, but it might make rebasing slightly harder.

	Arnd
