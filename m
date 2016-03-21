From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 21 Mar 2016 22:49:35 +0100
Subject: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
In-Reply-To: <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20160321214935.GF6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 01:02:13PM -0400, Chris Metcalf wrote:
> When doing an nmi backtrace of many cores, most of which are idle,
> the output is a little overwhelming and very uninformative.  Suppress
> messages for cpus that are idling when they are interrupted and just
> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".

This is still 100+ lines on a modern system, but better than the many
many thousands it would otherwise generate.

> We do this by grouping all the cpuidle code together into a new
> .cpuidle.text section, and then checking the address of the
> interrupted PC to see if it lies within that section.
> 
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Please Cc Rafael on the next posting.
