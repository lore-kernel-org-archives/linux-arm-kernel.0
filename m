From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Tue, 19 Feb 2013 23:59:22 +0530
Subject: [PATCH v5 29/45] x86/xen: Use get/put_online_cpus_atomic() to
 prevent CPU offline
In-Reply-To: <20130219181038.GB18244@phenom.dumpdata.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122074046.13822.61950.stgit@srivatsabhat.in.ibm.com>
 <20130219181038.GB18244@phenom.dumpdata.com>
Message-ID: <5123C482.5070704@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 11:40 PM, Konrad Rzeszutek Wilk wrote:
> On Tue, Jan 22, 2013 at 01:10:51PM +0530, Srivatsa S. Bhat wrote:
>> Once stop_machine() is gone from the CPU offline path, we won't be able to
>> depend on preempt_disable() or local_irq_disable() to prevent CPUs from
>> going offline from under us.
>>
>> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
>> while invoking from atomic context.
>>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> Weird. I see this in the patch but I don't see it in the header?

Meaning, you didn't get this email at all?

> Did you
> explicitly suppress the CC part?
> 

No.. I sent the entire patchset to a set of email ids and in addition to
that I CC'ed individual patches to the respective maintainers/lists (the
CC: list in the changelog). I used the --auto knob from stgit to do that.

> 
> Anyhow, the patch looks sane enough, thought I need to to run it through
> a test framework just to be on a sure side.
>

Sure, thank you. But you might want to test the v6 that I sent out
yesterday instead of v5. Oh, wait a min, you didn't get the v6 mail also?

Here it is, for your reference:
http://marc.info/?l=linux-kernel&m=136119260122255&w=2

Regards,
Srivatsa S. Bhat

>> Cc: Jeremy Fitzhardinge <jeremy@goop.org>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86 at kernel.org
>> Cc: xen-devel at lists.xensource.com
>> Cc: virtualization at lists.linux-foundation.org
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> ---
