From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 5 Jan 2010 18:24:51 +0900
Subject: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC, kexec,
	atags
In-Reply-To: <20091229220705.GM3512@atomide.com>
References: <20091219034151.26198.26570.stgit@localhost>
	<aec7e5c30912272155s41ce8914hd03a5e4c740a5b9d@mail.gmail.com>
	<20091229220705.GM3512@atomide.com>
Message-ID: <aec7e5c31001050124q5a0a7b7co872bd58ddfabe5f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2009 at 7:07 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Magnus Damm <magnus.damm@gmail.com> [091227 21:54]:
>> > ? ? ?arm: Fix cpu_proc_fin() for proc-v7.S and make kexec work
>
> Are you seeing the occasional crc errors when uncompressing the
> new kernel on your v7?

Nope, it's very stable. I boot over USB with kexec for all my ARM
kernel development and I have not seen any issues so far.

> I'm seeing those maybe 1 out of 10 times on omap3430 boards unless if
> I do an extra (and wrong) flush_cache_all after local_flush_tlb_all
> at the end of setup_mm_for_reboot.

My second kernel does not need any workaround, however...

> If you're not seeing the crc errors, do you have L2 cache on?

I'm not sure at this point, but I think L2 is disabled. Will try to turn it on.

> Also, what's the Cortex version on your v7? It's rev r2p3 on
> omap3430.

The data sheet of sh7377 says r2p3 as well.

Cheers,

/ magnus
