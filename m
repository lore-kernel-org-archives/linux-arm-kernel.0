From: tim.bird@am.sony.com (Tim Bird)
Date: Tue, 13 Dec 2011 13:56:23 -0800
Subject: [Kgdb-bugreport] Anyone used KDB single-stepping on ARM
In-Reply-To: <4EE7AA4C.2050605@windriver.com>
References: <4E95D13C.2090109@am.sony.com> <4EE7AA4C.2050605@windriver.com>
Message-ID: <4EE7CA07.2050003@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2011 11:41 AM, Jason Wessel wrote:
> On 10/12/2011 12:41 PM, Tim Bird wrote:
>> I've tried to use single-stepping ('ss' command) on ARM
>> from KDB, without success.
>>
>> Has anyone done this - is it currently supported on ARM?
> 
> It is only supported via patches that are not in the mainline kernel the same is also true of the MIPS architecture.
> 
> The last consideration I had taken a look at was to consider using the kprobes for single stepping, assuming kprobes work ok on ARM, vs using emulation of single stepping with breakpoints.
> 
> The other possibility for newer arm hardward (v7 and up) is to use the hw_breakpoint API and plumb it into kdb/kgdb via the arch/arm/kernel/kgdb.c.  It is probably time to take another look at this now since it was merged to the mainline in the last year.

OK.  Thanks very much for the response.  I started looking at it myself,
and it looked too complicated for me to tackle without a lot
more research.  My understanding is that older ARM hardware
(pre-V7) doesn't have single-step support, which appears
to match what you're saying above.

If you or someone else works on this, let me know.  I'd be a willing
tester.  But I probably don't have enough cycles (or experience with kdb/kgdb)
to actually implement this myself.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
