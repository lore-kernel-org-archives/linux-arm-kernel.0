From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 17 Mar 2016 17:28:15 -0700
Subject: [PATCH v2 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <20160317231128.GB6344@twins.programming.kicks-ass.net>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-2-git-send-email-cmetcalf@mellanox.com>
 <20160317193600.GY6344@twins.programming.kicks-ass.net>
 <20160317225557.GA4287@linux.vnet.ibm.com>
 <20160317231128.GB6344@twins.programming.kicks-ass.net>
Message-ID: <20160318002815.GB4287@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 12:11:28AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 17, 2016 at 03:55:57PM -0700, Paul E. McKenney wrote:
> > The RCU stall-warn stack traces can be ugly, agreed.
> 
> Ugly isn't the problem, completely random bollocks that puts you on the
> wrong path was more the problem.
> 
> It uses a stack pointer saved at some random time in the past to start
> unwinding an active stack from. Completely and utter misery.

Yep, its accuracy does depend on what is going on, which was also my
experience with the NMI-based approach's reliablity.

Perhaps a boot-time parameter enabling the sysadm to pick the desired
flavor of poison?

							Thanx, Paul
