From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Oct 2017 11:02:47 +0100
Subject: [PATCH v2 0/5] Switch arm64 over to qrwlock
In-Reply-To: <20171009065243.g4q7l3kf2esa4fkk@hirez.programming.kicks-ass.net>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
 <20171008213052.ojyxpr56d2ypscjy@yury-thinkpad>
 <20171009065243.g4q7l3kf2esa4fkk@hirez.programming.kicks-ass.net>
Message-ID: <20171009100246.GD5127@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 08:52:43AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 09, 2017 at 12:30:52AM +0300, Yury Norov wrote:
> > The bottomline of discussion [1] was that queued locks are more
> > effective when SoC has many CPUs. And 4 is not many.
> 
> qspinlock, yes. qrwlock not, as it fully depends on arch_spinlock_t for
> the queueing. qrwlock is just a generic rwlock_t implementation.

Yup, and once I've knocked qrwlocks on the head I'll go take a look at
qspinlock. Either way, I'll keep our ticket implementation around because
(a) it's a tonne simpler (b) I don't have data to suggest that it sucks and
(c) there's been formal work to show that various parts of it are correct.

rwlock on the other hand has been shown to be broken, I know that it sucks
and there's not been any formal work, so I'll be glad to see the back of it!

Will
