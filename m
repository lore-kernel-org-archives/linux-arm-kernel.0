From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 4 Dec 2015 10:36:26 +0100
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151203172207.GR28602@linux.vnet.ibm.com>
References: <1448624646-15863-1-git-send-email-will.deacon@arm.com>
 <20151130155839.GK17308@twins.programming.kicks-ass.net>
 <20151201164035.GE27751@arm.com>
 <20151203001141.GO28602@linux.vnet.ibm.com>
 <20151203132839.GA3816@twins.programming.kicks-ass.net>
 <20151203163243.GI11337@arm.com>
 <20151203172207.GR28602@linux.vnet.ibm.com>
Message-ID: <20151204093626.GF17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 09:22:07AM -0800, Paul E. McKenney wrote:
> On the added MBs,
> the only alternative I have been able to come up with has even more MBs,
> as in on every lock acquisition.  If I am missing something, please do
> not keep it a secret!

You're right. And I suppose mpe is still on the fence wrt switching PPC
over to RCsc lock order.. which would be all those extra MBs you talk
about.
