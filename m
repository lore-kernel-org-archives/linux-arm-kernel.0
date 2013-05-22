From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 22 May 2013 12:19:16 +0200
Subject: [PATCH v2 00/10] uaccess: better might_sleep/might_fault behavior
In-Reply-To: <201305221125.36284.arnd@arndb.de>
References: <cover.1368702323.git.mst@redhat.com>
 <201305221125.36284.arnd@arndb.de>
Message-ID: <20130522101916.GM18810@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 11:25:36AM +0200, Arnd Bergmann wrote:
> Calling might_fault() for every __get_user/__put_user is rather expensive
> because it turns what should be a single instruction (plus fixup) into an
> external function call.

We could hide it all behind CONFIG_DEBUG_ATOMIC_SLEEP just like
might_sleep() is. I'm not sure there's a point to might_fault() when
might_sleep() is a NOP.
