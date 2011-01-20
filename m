From: gregkh@suse.de (Greg KH)
Date: Thu, 20 Jan 2011 08:34:48 -0800
Subject: [PATCH] change acquire/release_console_sem() to
	console_lock/unlock()
In-Reply-To: <1295539104-13210-1-git-send-email-torbenh@gmx.de>
References: <1295539104-13210-1-git-send-email-torbenh@gmx.de>
Message-ID: <20110120163448.GA30588@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 04:58:13PM +0100, Torben Hohn wrote:
> the -rt patches change the console_semaphore to console_mutex.
> so a quite large chunk of the patches changes all
> acquire/release_console_sem() to acquire/release_console_mutex()

Why not just change the functionality of the existing function to be a
mutex in the rt patches, instead of having to rename it everywhere?

> this commit makes things use more neutral function names
> which dont make implications about the underlying lock.
> 
> the only real change is the return value of console_trylock
> which is inverted from try_acquire_console_sem()
> 
> Signed-off-by: Torben Hohn <torbenh@gmx.de>
> CC: Thomas Gleixner <tglx@tglx.de>

I don't mind this rename, but is it really going to help anything out?
What's the odds of the -rt portion of this patch ever making it to
mainline?

thanks,

greg k-h
