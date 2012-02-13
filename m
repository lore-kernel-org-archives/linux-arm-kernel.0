From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Feb 2012 16:23:59 +0000
Subject: [PATCH] Optimize multi-CPU tlb flushing a little more
In-Reply-To: <CAH+eYFC_mkdObV0NfN5Jtv0L6fM9e0YGOBghTEVSqf=TAFxdXw@mail.gmail.com>
References: <20110823110602.GG19622@n2100.arm.linux.org.uk>
 <CAH+eYFC_mkdObV0NfN5Jtv0L6fM9e0YGOBghTEVSqf=TAFxdXw@mail.gmail.com>
Message-ID: <20120213162359.GC25655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 09:36:35PM +0530, Rabin Vincent wrote:
> This part conditionally calls get_cpu() but unconditionally calls
> put_cpu():

Can you try getting rid of put_cpu(), and replacing get_cpu()
with smp_processor_id().

In theory, this function should be called with preempt disabled so
smp_processor_id() should be safe here.

Thanks.
