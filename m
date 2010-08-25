From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Aug 2010 20:07:13 +0100
Subject: [PATCH] wire up fanotify and prlimit64 syscalls on ARM
In-Reply-To: <19573.12044.918202.642643@pilspetsen.it.uu.se>
References: <19573.12044.918202.642643@pilspetsen.it.uu.se>
Message-ID: <20100825190713.GA31202@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 25, 2010 at 04:56:12PM +0200, Mikael Pettersson wrote:
> The 2.6.36-rc kernel added three new system calls:
> fanotify_init, fanotify_mark, and prlimit64.  This patch
> wires them up on ARM.
> 
> The only non-trivial issue here is the u64 argument to
> sys_fanotify_mark(), but it is the 3rd argument and thus
> passed in r2/r3 in both kernel and user space, so it causes
> no problems.
> 
> Tested with a 2.6.36-rc2 EABI kernel on an ixp4xx machine.

Looks fine, please submit to the patch system with Anand's tested-by.
Thanks.
