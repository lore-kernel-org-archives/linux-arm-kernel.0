From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Thu, 17 Mar 2016 20:17:59 -0400
Subject: [PATCH v2 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <20160317225557.GA4287@linux.vnet.ibm.com>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-2-git-send-email-cmetcalf@mellanox.com>
 <20160317193600.GY6344@twins.programming.kicks-ass.net>
 <20160317225557.GA4287@linux.vnet.ibm.com>
Message-ID: <56EB4937.1010404@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/17/2016 6:55 PM, Paul E. McKenney wrote:
> The RCU stall-warn stack traces can be ugly, agreed.
>
> That said, RCU used to use NMI-based stack traces, but switched to the
> current scheme due to the NMIs having the unfortunate habit of locking
> things up, which IIRC often meant no stack traces at all.  If I recall
> correctly, one of the problems was self-deadlock in printk().

Steven Rostedt enabled the per_cpu printk func support in June 2014, and
the nmi_backtrace code uses it to just capture printk output to percpu
buffers, so I think it's going to be a lot more robust than earlier attempts.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
