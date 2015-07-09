From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 9 Jul 2015 18:59:44 +0200
Subject: Build failure on ARM64 for Linux 4.2-rc1 was: Linux 4.2-rc1
In-Reply-To: <559EA54C.4060807@redhat.com>
References: <CA+55aFxmm7THBsCK62esr=JCcHpn6nmReGKqPp0inUrhbkveuA@mail.gmail.com>
 <559BCC8A.1030708@redhat.com> <559EA54C.4060807@redhat.com>
Message-ID: <20150709165944.GA19282@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 11:46:04AM -0500, Mark Langsdorf wrote:
> I did a git bisect and it looks like the faulty patch is
> d72da4a4d973d8a0a0d3c97e7cdebf287fbe3a99, "rbtree: Make lockless
> searches non-fatal". I can't see why it causes my builds to fail,
> but if I revert that patch and the related series, then I can
> build the kernel and build tools/perf successfully.
> 
> Any insight into a less intensive way of fixing my build would
> be appreciated.

This is tools/perf failing to build right? Add tip/perf/urgent, it
appears to contain the required bits to make it go again.

The /urgent branches will get to Linus 'soon' I imagine.
