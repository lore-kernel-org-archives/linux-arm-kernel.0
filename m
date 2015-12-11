From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Dec 2015 14:45:41 +0000
Subject: [PATCH] scripts: recordmcount: break hardlinks
In-Reply-To: <20151211093125.50b72639@gandalf.local.home>
References: <20151202090517.432556a4@gandalf.local.home>
 <E1a7MVT-0000et-62@rmk-PC.arm.linux.org.uk>
 <20151211093125.50b72639@gandalf.local.home>
Message-ID: <20151211144541.GT8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 09:31:25AM -0500, Steven Rostedt wrote:
> On Fri, 11 Dec 2015 12:09:03 +0000
> Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > recordmcount edits the file in-place, which can cause problems when
> > using ccache in hardlink mode.  Arrange for recordmcount to break a
> > hardlinked object.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > Steven, sorry it took a while to get this out...
> 
> Should this be for stable, or is it fine to just add this to my 4.5
> queue?

I thought you wanted to test it first - although I've been running with
this for a while now, my nightly builds have masked out the mcount
warning, and I suspect it'll take a while for ccache to purge itself
of the modified objects.

If you're happy to add a stable tag to it, then please do so.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
