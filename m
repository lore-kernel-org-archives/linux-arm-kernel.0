From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 10 Jun 2010 15:56:10 +0200
Subject: [PATCH] sa1111: Prevent deadlock in resume path
In-Reply-To: <20100526201824.GA16418@n2100.arm.linux.org.uk>
References: <1274901104-22133-1-git-send-email-marek.vasut@gmail.com>
	<20100526191425.GD6232@n2100.arm.linux.org.uk>
	<201005262115.57282.marek.vasut@gmail.com>
	<20100526201824.GA16418@n2100.arm.linux.org.uk>
Message-ID: <20100610135609.GC4514@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2010-05-26 21:18:24, Russell King - ARM Linux wrote:
> On Wed, May 26, 2010 at 09:15:57PM +0200, Marek Vasut wrote:
> > Dne St 26. kv?tna 2010 21:14:25 Russell King - ARM Linux napsal(a):
> > > On Wed, May 26, 2010 at 09:11:44PM +0200, Marek Vasut wrote:
> > > > This patch reorganises the sa1111_resume() function in a manner the
> > > > spinlock happens after calling the sa1111_wake(). This fixes two bugs:
> > > > 
> > > > 1) This function called sa1111_wake() which tried to claim the same
> > > > spinlock
> > > > 
> > > >    the sa1111_resume() already claimed. This would result in certain
> > > >    deadlock.
> > > >    
> > > >    Original idea for this part: Russell King <linux@arm.linux.org.uk>
> > > > 
> > > > 2) The function didn't unlock the spinlock in case the chip didn't report
> > > > 
> > > >    correct ID.
> > > >    
> > > >    Original idea for this part: Julia Lawall <julia@diku.dk>
> > > > 
> > > > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > > 
> > > Yea, good enough.
> > 
> > You want me to fight your patch tracking system or will you just merge it into 
> > your tree ?
> 
> What do you mean "fight" ?  Just send a standard git formatted patch
> to the email address with an additional KernelVersion: tag.  It's
> not at all hard.

You are linux kernel maintainer. Start acting as one. It is not at all
hard.

Alternatively, just remove KernelVersion: checking in  your
scripts.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
