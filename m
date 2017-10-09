From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 9 Oct 2017 08:52:43 +0200
Subject: [PATCH v2 0/5] Switch arm64 over to qrwlock
In-Reply-To: <20171008213052.ojyxpr56d2ypscjy@yury-thinkpad>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
 <20171008213052.ojyxpr56d2ypscjy@yury-thinkpad>
Message-ID: <20171009065243.g4q7l3kf2esa4fkk@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 12:30:52AM +0300, Yury Norov wrote:
> The bottomline of discussion [1] was that queued locks are more
> effective when SoC has many CPUs. And 4 is not many.

qspinlock, yes. qrwlock not, as it fully depends on arch_spinlock_t for
the queueing. qrwlock is just a generic rwlock_t implementation.
