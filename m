From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Mon, 18 Feb 2013 14:07:12 +0100
Subject: [PATCH v6 33/46] cris/smp: Use get/put_online_cpus_atomic() to
 prevent CPU offline
In-Reply-To: <20130218124254.26245.4577.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218124254.26245.4577.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218130712.GO23529@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 06:12:54PM +0530, Srivatsa S. Bhat wrote:
> Once stop_machine() is gone from the CPU offline path, we won't be able to
> depend on preempt_disable() or local_irq_disable() to prevent CPUs from
> going offline from under us.
> 
> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
> while invoking from atomic context.
> 
> Cc: Mikael Starvik <starvik@axis.com>

> Cc: linux-cris-kernel at axis.com
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
