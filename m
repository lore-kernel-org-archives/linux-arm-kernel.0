From: jason.wessel@windriver.com (Jason Wessel)
Date: Tue, 13 Dec 2011 13:41:00 -0600
Subject: [Kgdb-bugreport] Anyone used KDB single-stepping on ARM
In-Reply-To: <4E95D13C.2090109@am.sony.com>
References: <4E95D13C.2090109@am.sony.com>
Message-ID: <4EE7AA4C.2050605@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2011 12:41 PM, Tim Bird wrote:
> I've tried to use single-stepping ('ss' command) on ARM
> from KDB, without success.
>
> Has anyone done this - is it currently supported on ARM?

It is only supported via patches that are not in the mainline kernel the same is also true of the MIPS architecture.

The last consideration I had taken a look at was to consider using the kprobes for single stepping, assuming kprobes work ok on ARM, vs using emulation of single stepping with breakpoints.

The other possibility for newer arm hardward (v7 and up) is to use the hw_breakpoint API and plumb it into kdb/kgdb via the arch/arm/kernel/kgdb.c.  It is probably time to take another look at this now since it was merged to the mainline in the last year.

Jason.
