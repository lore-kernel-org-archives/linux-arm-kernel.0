From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 18 Mar 2016 00:09:28 +0100
Subject: [PATCH v2 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <20160317225557.GA4287@linux.vnet.ibm.com>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-2-git-send-email-cmetcalf@mellanox.com>
 <20160317193600.GY6344@twins.programming.kicks-ass.net>
 <20160317225557.GA4287@linux.vnet.ibm.com>
Message-ID: <20160317230928.GA6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 03:55:57PM -0700, Paul E. McKenney wrote:
> That said, RCU used to use NMI-based stack traces, but switched to the
> current scheme due to the NMIs having the unfortunate habit of locking
> things up, which IIRC often meant no stack traces at all.  If I recall
> correctly, one of the problems was self-deadlock in printk().
> 
> Have these problems been fixed?

Improved is I think the word.

Although I've butchered my printk() into absolute submission :-)
