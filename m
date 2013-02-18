From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 18 Feb 2013 11:31:27 -0500
Subject: [PATCH v6 04/46] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
In-Reply-To: <5122551E.1080703@linux.vnet.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123856.26245.46705.stgit@srivatsabhat.in.ibm.com>
 <CANN689F9S7c1M8+cEpz3tsxGF34+NTRBLvxgPUOtbvav5u+RRA@mail.gmail.com>
 <5122551E.1080703@linux.vnet.ibm.com>
Message-ID: <1361205087.23152.159.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-02-18 at 21:51 +0530, Srivatsa S. Bhat wrote:
> Hi Michel,

> Yes.. I don't think we can avoid that. Moreover, since we _want_ unfair
> reader/writer semantics to allow flexible locking rules and guarantee
> deadlock-safety, having a recursive reader side is not even an issue, IMHO.

Recursive unfair reader lock may guarantee deadlock-safety, but
remember, it adds a higher probability of live-locking the write_lock.
Which is another argument to keep this separate to cpu hotplug only.

-- Steve
