From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 14 Jan 2016 21:15:13 +0100
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <5697FA0A.6040601@imgtec.com>
References: <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com> <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
 <20160114161604.GT3818@linux.vnet.ibm.com>
 <5697FA0A.6040601@imgtec.com>
Message-ID: <20160114201513.GI6357@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 11:42:02AM -0800, Leonid Yegoshin wrote:
> An the only point - please use an appropriate SYNC_* barriers instead of
> heavy bold hammer. That stuff was design explicitly to support the
> requirements of Documentation/memory-barriers.txt

That's madness. That document changes from version to version as to what
we _think_ the actual hardware does. It is _NOT_ a specification.

You cannot design hardware from that. Its incomplete and fails to
specify a bunch of things. It not a mathematically sound definition of a
memory model.

Please stop referring to that document for what a particular barrier
_should_ do.  Explain what MIPS does, so we can attempt to integrate
this knowledge with our knowledge of PPC/ARM/Alpha/x86/etc. and improve
upon our understanding of hardware and improve the Linux memory model.
