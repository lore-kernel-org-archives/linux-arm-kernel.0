From: holt@sgi.com (Robin Holt)
Date: Thu, 9 May 2013 19:05:53 -0500
Subject: [PATCH -v9 04/11] Move shutdown/reboot related functions to
 kernel/reboot.c
In-Reply-To: <20130509135100.13947d1805a583703ee8488b@linux-foundation.org>
References: <1368127405-112717-1-git-send-email-holt@sgi.com>
 <1368127405-112717-5-git-send-email-holt@sgi.com>
 <20130509135100.13947d1805a583703ee8488b@linux-foundation.org>
Message-ID: <20130510000552.GX3658@sgi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 01:51:00PM -0700, Andrew Morton wrote:
> On Thu,  9 May 2013 14:23:18 -0500 Robin Holt <holt@sgi.com> wrote:
> 
> > This patch is preparatory.  It moves reboot related syscall, etc
> > functions from kernel/sys.c to kernel/reboot.c.
> 
> This doesn't apply.

Weird, I just grabbed a recent Linus kernel tree and all 11 applied.
I then did an update to linus' tree to commit 70eba4226 and now I get
rejects on arm.  I will resubmit a -v10 fixed up shortly.

Robin

> 
> > -static void migrate_to_reboot_cpu(void)
> > -{
> > -	/* The boot cpu is always logical cpu 0 */
> > -	int cpu = 0;
> > -
> > -	cpu_hotplug_disable();
> > -
> > -	/* Make certain the cpu I'm about to reboot on is online */
> > -	if (!cpu_online(cpu))
> > -		cpu = cpumask_first(cpu_online_mask);
> 
> Here it's deleting code which was already modified by "[PATCH -v9
> 02/11] Migrate shutdown/reboot to boot cpu.".  So patch [4/11]
> generates rejects when applied on top of [patch 2/11].
> 
> There are several similar glitches.
