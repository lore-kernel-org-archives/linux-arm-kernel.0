From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Tue, 26 Feb 2013 03:15:05 +0530
Subject: [PATCH v6 00/46] CPU hotplug: stop_machine()-free CPU hotplug
In-Reply-To: <87mwuxfatp.fsf@rustcorp.com.au>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <87mwuxfatp.fsf@rustcorp.com.au>
Message-ID: <512BDB61.1010204@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2013 06:01 AM, Rusty Russell wrote:
> "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:
>> Hi,
>>
>> This patchset removes CPU hotplug's dependence on stop_machine() from the CPU
>> offline path and provides an alternative (set of APIs) to preempt_disable() to
>> prevent CPUs from going offline, which can be invoked from atomic context.
>> The motivation behind the removal of stop_machine() is to avoid its ill-effects
>> and thus improve the design of CPU hotplug. (More description regarding this
>> is available in the patches).
> 
> If you're doing a v7, please put your benchmark results somewhere!
> 

Oh, I forgot to put them in v6! Thanks for reminding :-)
And yes, I'll have to do a v7 to incorporate changes (if any) to the new code
that went in during this merge window.

> The obvious place is in the 44/46.
>

Ok, will add it there. Thank you!
 
Regards,
Srivatsa S. Bhat
