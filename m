From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jun 2011 18:10:27 +0200
Subject: [RFC PATCH 01/16] ARM: local timers: early device probing hooks
In-Reply-To: <4DFB6F09.6060407@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<201106171656.10745.arnd@arndb.de> <4DFB6F09.6060407@arm.com>
Message-ID: <201106171810.27268.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 June 2011, Marc Zyngier wrote:
> > 
> > Instead of having two separate global pointers, should we make the ARM specific
> > callback a machine_desc callback?
> 
> Probably not. I only see this arm_late_time_init pointer as a temporary
> measure. The only user (shmobile) uses this hook to install its own
> early timers, and there is a patch floating around to move that code to
> time.c. Unless we have other uses for such a callback, of course.

Ok, fair enough.

	Arnd
