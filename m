From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 15 Jan 2016 09:55:54 +0100
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160114212913.GF3818@linux.vnet.ibm.com>
References: <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
Message-ID: <20160115085554.GF3421@worktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 01:29:13PM -0800, Paul E. McKenney wrote:
> So smp_mb() provides transitivity, as do pairs of smp_store_release()
> and smp_read_acquire(), 

But they provide different grades of transitivity, which is where all
the confusion lays.

smp_mb() is strongly/globally transitive, all CPUs will agree on the order.

Whereas the RCpc release+acquire is weakly so, only the two cpus
involved in the handover will agree on the order.
