From: torbenh@gmx.de (torbenh)
Date: Thu, 20 Jan 2011 17:55:02 +0100
Subject: [PATCH] change acquire/release_console_sem() to
	console_lock/unlock()
In-Reply-To: <20110120163448.GA30588@suse.de>
References: <1295539104-13210-1-git-send-email-torbenh@gmx.de>
	<20110120163448.GA30588@suse.de>
Message-ID: <20110120165502.GA10832@siel.b>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 08:34:48AM -0800, Greg KH wrote:
> On Thu, Jan 20, 2011 at 04:58:13PM +0100, Torben Hohn wrote:
> > the -rt patches change the console_semaphore to console_mutex.
> > so a quite large chunk of the patches changes all
> > acquire/release_console_sem() to acquire/release_console_mutex()
> 
> Why not just change the functionality of the existing function to be a
> mutex in the rt patches, instead of having to rename it everywhere?

i hope that Thomas already did this in his upcoming -rt series.

> 
> > this commit makes things use more neutral function names
> > which dont make implications about the underlying lock.
> > 
> > the only real change is the return value of console_trylock
> > which is inverted from try_acquire_console_sem()
> > 
> > Signed-off-by: Torben Hohn <torbenh@gmx.de>
> > CC: Thomas Gleixner <tglx@tglx.de>
> 
> I don't mind this rename, but is it really going to help anything out?
> What's the odds of the -rt portion of this patch ever making it to
> mainline?

the -rt portion only changes the semaphore to a mutex.
since the console_sem is used with mutex semantics, i dont see any
reason, not to merge that portion too. 

i am just trying to shrink the -rt patch to make it more maintanable :)

> 
> thanks,
> 
> greg k-h

-- 
torben Hohn
