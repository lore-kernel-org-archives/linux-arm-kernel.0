From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 26 May 2010 23:52:33 +0200
Subject: [PATCH] sa1111: Prevent deadlock in resume path
In-Reply-To: <20100526214236.GC16418@n2100.arm.linux.org.uk>
References: <1274901104-22133-1-git-send-email-marek.vasut@gmail.com>
	<201005262333.47046.marek.vasut@gmail.com>
	<20100526214236.GC16418@n2100.arm.linux.org.uk>
Message-ID: <201005262352.34052.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 26. kv?tna 2010 23:42:36 Russell King - ARM Linux napsal(a):
> On Wed, May 26, 2010 at 11:33:46PM +0200, Marek Vasut wrote:
> > Dne St 26. kv?tna 2010 22:18:24 Russell King - ARM Linux napsal(a):
> > > On Wed, May 26, 2010 at 09:15:57PM +0200, Marek Vasut wrote:
> > > > Dne St 26. kv?tna 2010 21:14:25 Russell King - ARM Linux napsal(a):
> > > > > On Wed, May 26, 2010 at 09:11:44PM +0200, Marek Vasut wrote:
> > > > > > This patch reorganises the sa1111_resume() function in a manner
> > > > > > the spinlock happens after calling the sa1111_wake(). This fixes
> > > > > > two bugs:
> > > > > > 
> > > > > > 1) This function called sa1111_wake() which tried to claim the
> > > > > > same spinlock
> > > > > > 
> > > > > >    the sa1111_resume() already claimed. This would result in
> > > > > >    certain deadlock.
> > > > > >    
> > > > > >    Original idea for this part: Russell King
> > > > > >    <linux@arm.linux.org.uk>
> > > > > > 
> > > > > > 2) The function didn't unlock the spinlock in case the chip
> > > > > > didn't report
> > > > > > 
> > > > > >    correct ID.
> > > > > >    
> > > > > >    Original idea for this part: Julia Lawall <julia@diku.dk>
> > > > > > 
> > > > > > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > > > > 
> > > > > Yea, good enough.
> > > > 
> > > > You want me to fight your patch tracking system or will you just
> > > > merge it into your tree ?
> > > 
> > > What do you mean "fight" ?  Just send a standard git formatted patch
> > > to the email address with an additional KernelVersion: tag.  It's
> > > not at all hard.
> > 
> > What address, how, any howto?
> > 
> > btw. why ?! Look at Eric, he doesn't need such crap, why do you
> > complicate it so much ?
> 
> You expect a helpful reply with such an attitude.  Sorry, I'm not going
> to bother with attacks like this.  You earn the prize of figuring it out
> yourself.

Try reading past the three dots please.

You don't want the patch? Fine by me ... Anyway, please, open your eyes, look 
around, noone in the whole community does such complications. Why do you do 
that? What does it help? Why can't you just pick patches as everyone else does 
-- from email. That's why git supports it.
