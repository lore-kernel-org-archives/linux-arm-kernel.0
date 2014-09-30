From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 22:07:03 +0200
Subject: [PATCH v2] sched,
 time: fix build error with 64 bit cputime_t on 32 bit systems
In-Reply-To: <20140930155947.070cdb1f@annuminas.surriel.com>
References: <2547036.UshV4pXvhf@wuerfel>
 <20140930133749.GD4241@worktop.programming.kicks-ass.net>
 <20140930155947.070cdb1f@annuminas.surriel.com>
Message-ID: <56858913.p3zUxZnKZn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 15:59:47 Rik van Riel wrote:
> Subject: sched,time: fix build error with 64 bit cputime_t on 32 bit systems
> 
> On 32 bit systems cmpxchg cannot handle 64 bit values, so
> some additional magic is required to allow a 32 bit system
> with CONFIG_VIRT_CPU_ACCOUNTING_GEN enabled to build.
> 
> Make sure the correct cmpxchg function is used when doing
> an atomic swap of a cputime_t.
> 
> Signed-off-by: Rik van Riel <riel@redhat.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> 

Now builds without warnings on both 32-bit and 64-bit cputime_t configurations
on arm32.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

	Arnd
