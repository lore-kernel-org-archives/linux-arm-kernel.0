From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 1 Mar 2011 22:38:10 +0100 (CET)
Subject: [PATCH v6 1/1] PRUSS UIO driver support
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BF36683@dbde02.ent.ti.com>
References: <1298926895-5294-1-git-send-email-pratheesh@ti.com>
	<1298926895-5294-2-git-send-email-pratheesh@ti.com>
	<20110228212638.GB16806@local>
	<B85A65D85D7EB246BE421B3FB0FBB593024BF3601C@dbde02.ent.ti.com>
	<20110301183334.GC20497@local>
	<B85A65D85D7EB246BE421B3FB0FBB593024BF36683@dbde02.ent.ti.com>
Message-ID: <alpine.LFD.2.00.1103012232220.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Mar 2011, TK, Pratheesh Gangadhar wrote:

> Hi,
> > -----Original Message-----
> > From: Hans J. Koch [mailto:hjk at hansjkoch.de]
> > Sent: Wednesday, March 02, 2011 12:04 AM
> > To: TK, Pratheesh Gangadhar
> > Cc: Hans J. Koch; linux-kernel at vger.kernel.org; gregkh at suse.de;
> > tglx at linutronix.de; sshtylyov at mvista.com; arnd at arndb.de; Chatterjee, Amit;
> > davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH v6 1/1] PRUSS UIO driver support

Sigh, can you please use a mailer which does not repeat the headers
for no value and just has a single line like this:

> > On Tue, Mar 01, 2011 at 10:15:27AM +0530, TK, Pratheesh Gangadhar wrote:
> > Anyway, please don't use that kind of argumentation. The next newbie
> > developer might copy your work as a basis for his new driver, and there
> > it probably won't work.
> > 
> > Simply put the spin_lock_init before the loop.
> > 
> Agree, will fix this in next version.

As I said before, we want stuff initialized when it is possibly
used. But first of all we ant people to use the proper mechanisms to
achive that.

If that's a module global lock then it needs to be instantiated by

static DEFINE_SPINLOCK(lock);

which implies the initialization of the lock.

If it's a lock which is in allocated memory then the

   spin_lock_init(&lock);

wants to be before it can be possibly used.

So in your case DEFINE_SPINLOCK is the correct solution.

Thanks,

	tglx
