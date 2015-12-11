From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 11 Dec 2015 13:10:29 -0500
Subject: [PATCH] scripts: recordmcount: break hardlinks
In-Reply-To: <20151211144541.GT8644@n2100.arm.linux.org.uk>
References: <20151202090517.432556a4@gandalf.local.home>
 <E1a7MVT-0000et-62@rmk-PC.arm.linux.org.uk>
 <20151211093125.50b72639@gandalf.local.home>
 <20151211144541.GT8644@n2100.arm.linux.org.uk>
Message-ID: <20151211131029.5bb23411@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Dec 2015 14:45:41 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Dec 11, 2015 at 09:31:25AM -0500, Steven Rostedt wrote:
> > On Fri, 11 Dec 2015 12:09:03 +0000
> > Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> >   
> > > recordmcount edits the file in-place, which can cause problems when
> > > using ccache in hardlink mode.  Arrange for recordmcount to break a
> > > hardlinked object.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > ---
> > > Steven, sorry it took a while to get this out...  
> > 
> > Should this be for stable, or is it fine to just add this to my 4.5
> > queue?  
> 
> I thought you wanted to test it first - although I've been running with
> this for a while now, my nightly builds have masked out the mcount
> warning, and I suspect it'll take a while for ccache to purge itself
> of the modified objects.
> 
> If you're happy to add a stable tag to it, then please do so.
> 

I ran it through most my tests (it's still running and is at 20 of 33
tests). If there was anything wrong with this patch, I'm sure one of my
tests would have crashed by now.

Do you want to take it, or shall I?

If you want to take it, you can add my:

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
