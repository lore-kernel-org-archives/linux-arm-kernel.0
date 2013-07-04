From: javier.picorel@epfl.ch (Javier Picorel)
Date: Thu, 4 Jul 2013 23:44:58 +0000
Subject: ARM Cortex A9: LL counters
In-Reply-To: <20130704094516.GC8782@mudshark.cambridge.arm.com>
References: <BFCB49997E59134AAAF17FFE77F8FF06673738BC@REXMD.intranet.epfl.ch>,
 <20130704094516.GC8782@mudshark.cambridge.arm.com>
Message-ID: <BFCB49997E59134AAAF17FFE77F8FF06673759E9@REXMD.intranet.epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

Thanks for the clarification! However, correct me if I'm wrong but, doesn't this mean that the "CO_LF_MISS" counter refers to L2 accesses? Thanks!

Regards,
Javier
________________________________________
From: Will Deacon [will.deacon at arm.com]
Sent: 04 July 2013 11:45
To: Javier Picorel
Cc: linux-arm-kernel at lists.infradead.org; mark.rutland at arm.com
Subject: Re: ARM Cortex A9: LL counters

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
