From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 Jul 2013 10:45:16 +0100
Subject: ARM Cortex A9: LL counters
In-Reply-To: <BFCB49997E59134AAAF17FFE77F8FF06673738BC@REXMD.intranet.epfl.ch>
References: <BFCB49997E59134AAAF17FFE77F8FF06673738BC@REXMD.intranet.epfl.ch>
Message-ID: <20130704094516.GC8782@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 07:59:14PM +0100, Javier Picorel wrote:
> Dear all,

Hello Javier,

> It seems that there is no mapping between any ARM Cortex A9 counter to the L2 (Last Level) access or misses event.

The L2 cache on Cortex-A9 is external to the CPU core and has its own set of
memory-mapped performance counters. Mark Rutland [CC'd] had something
working for this, but I haven't seen a refresh of the patches for a while.

> Looking at ARM's reference manual and OProfile's event list on A9, I see the following two counters:
> 
> CO_LF_MISS: (counter: 1, 2, 3, 4, 5, 6)
>         Number of coherent linefill requests which miss in all other CPUs, meaning that the request
>         is sent to external memory (min count: 500)
> CO_LF_HIT: (counter: 1, 2, 3, 4, 5, 6)
>         Number of coherent linefill requests which hit in another CPU, meaning that the linefill
>         data is fetched directly from the relevant cache (min count: 500)
> 
> It seems that the first counter refers to the L2 Misses and the second one to the L2 Hits (Last Level Cache in this architecture). I'm not sure
> whether we should do something about this or nor. Thanks!

No, these are all for L1. `sent to external memory' means sent to L2.

Will
