From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 10 Jun 2010 23:49:12 +0200
Subject: [PATCH] sa1111: Prevent deadlock in resume path
In-Reply-To: <20100610135609.GC4514@ucw.cz>
References: <1274901104-22133-1-git-send-email-marek.vasut@gmail.com>
	<20100526201824.GA16418@n2100.arm.linux.org.uk>
	<20100610135609.GC4514@ucw.cz>
Message-ID: <201006102349.12849.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 10. ?ervna 2010 15:56:10 Pavel Machek napsal(a):
> On Wed 2010-05-26 21:18:24, Russell King - ARM Linux wrote:
> > On Wed, May 26, 2010 at 09:15:57PM +0200, Marek Vasut wrote:
> > > Dne St 26. kv?tna 2010 21:14:25 Russell King - ARM Linux napsal(a):
> > > > On Wed, May 26, 2010 at 09:11:44PM +0200, Marek Vasut wrote:
> > > > > This patch reorganises the sa1111_resume() function in a manner the
> > > > > spinlock happens after calling the sa1111_wake(). This fixes two
> > > > > bugs:
> > > > > 
> > > > > 1) This function called sa1111_wake() which tried to claim the same
> > > > > spinlock
> > > > > 
> > > > >    the sa1111_resume() already claimed. This would result in
> > > > >    certain deadlock.
> > > > >    
> > > > >    Original idea for this part: Russell King
> > > > >    <linux@arm.linux.org.uk>
> > > > > 
> > > > > 2) The function didn't unlock the spinlock in case the chip didn't
> > > > > report
> > > > > 
> > > > >    correct ID.
> > > > >    
> > > > >    Original idea for this part: Julia Lawall <julia@diku.dk>
> > > > > 
> > > > > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > > > 
> > > > Yea, good enough.
> > > 
> > > You want me to fight your patch tracking system or will you just merge
> > > it into your tree ?
> > 
> > What do you mean "fight" ?  Just send a standard git formatted patch
> > to the email address with an additional KernelVersion: tag.  It's
> > not at all hard.
> 
> You are linux kernel maintainer. Start acting as one. It is not at all
> hard.
> 
> Alternatively, just remove KernelVersion: checking in  your
> scripts.
> 
> 									Pavel

Even though my problem was fixed (yeah, sorry Russell, I didn't know the patch 
tracker was updated to support git-send-email), I have a question though.

I believe that Kernel-version is unnecessary. Isn't this information already 
encoded in the git-send-emailed patch?

btw. guys, before another burning discussion emerges, if you two plan to make 
your fights into a new sports discipline, I won't mind taking the role of a 
spectator ;-) Some possible criteria would be a length of the replying email or 
number of rough words ;-)
