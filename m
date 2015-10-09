From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Oct 2015 00:20:15 +0100
Subject: [PATCH] sched_clock: add data pointer argument to read callback
In-Reply-To: <1444427858-576-1-git-send-email-mans@mansr.com>
References: <1444427858-576-1-git-send-email-mans@mansr.com>
Message-ID: <20151009232015.GC32536@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 10:57:35PM +0100, Mans Rullgard wrote:
> This passes a data pointer specified in the sched_clock_register()
> call to the read callback allowing simpler implementations thereof.
> 
> In this patch, existing uses of this interface are simply updated
> with a null pointer.

This is a bad description.  It tells us what the patch is doing,
(which we can see by reading the patch) but not _why_.  Please include
information on why the change is necessary - describe what you are
trying to achieve.

I generally don't accept patches what add new stuff to the kernel with
no users of that new stuff - that's called experience, experience of
people who submit stuff like that, and then vanish leaving their junk
in the kernel without any users.  Please ensure that this gets a user
very quickly, or better still, submit this patch as part of a series
which makes use of it.

Also, copying soo many people is guaranteed to be silently dropped by
mailing lists.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
