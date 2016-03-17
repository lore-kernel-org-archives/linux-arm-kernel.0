From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 18 Mar 2016 00:11:28 +0100
Subject: [PATCH v2 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <20160317225557.GA4287@linux.vnet.ibm.com>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-2-git-send-email-cmetcalf@mellanox.com>
 <20160317193600.GY6344@twins.programming.kicks-ass.net>
 <20160317225557.GA4287@linux.vnet.ibm.com>
Message-ID: <20160317231128.GB6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 03:55:57PM -0700, Paul E. McKenney wrote:
> The RCU stall-warn stack traces can be ugly, agreed.

Ugly isn't the problem, completely random bollocks that puts you on the
wrong path was more the problem.

It uses a stack pointer saved at some random time in the past to start
unwinding an active stack from. Completely and utter misery.
