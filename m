From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 16 Apr 2014 22:23:12 +0200
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <20140416195342.GH24070@n2100.arm.linux.org.uk>
References: <20140416145107.GA11039@redhat.com>
 <20140416.110031.1269128188581361698.davem@davemloft.net>
 <20140416164310.GA15739@redhat.com>
 <20140416.133831.364304583096073299.davem@davemloft.net>
 <20140416191825.GA22246@redhat.com>
 <20140416195342.GH24070@n2100.arm.linux.org.uk>
Message-ID: <20140416202312.GA26292@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is too late for me to even try to read emails ;) perhaps I am totally
confused.

On 04/16, Russell King - ARM Linux wrote:
>
> On Wed, Apr 16, 2014 at 09:18:25PM +0200, Oleg Nesterov wrote:
> > Looks like, __kunmap_atomic()->__cpuc_flush_dcache_area() should take
> > care, but could you please ack/nack my understanding?
>
> flush_dcache_area() doesn't touch the I-cache... the hint is in the
> name. :)  This is also the function which is used for flush_dcache_page()
> which we've already established isn't sufficient (for the same reason.)

Yes, we still need "i-cache flush where necessary" as David pointed.

> Plus... we still would need to know the user address(es) to flush for
> the I-cache side...

We know it, it is xol_vaddr in xol_get_insn_slot().

Oleg.
