From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 3 Jul 2018 13:20:29 +0530
Subject: [PATCH v5 09/10] Uprobes/sdt: Document about reference counter
In-Reply-To: <20180702145444.GB65296@linux.vnet.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-10-ravi.bangoria@linux.ibm.com>
 <20180702145444.GB65296@linux.vnet.ibm.com>
Message-ID: <0110cd8a-9785-c761-e2a5-ba8ab92745e9@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srikar,

On 07/02/2018 08:24 PM, Srikar Dronamraju wrote:
> * Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-06-28 10:52:08]:
> 
>> Reference counter gate the invocation of probe. If present,
>> by default reference count is 0. Kernel needs to increment
>> it before tracing the probe and decrement it when done. This
>> is identical to semaphore in Userspace Statically Defined
>> Tracepoints (USDT).
>>
>> Document usage of reference counter.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Unlike perf, this mechanism cannot detect ref count and depends on the
> users data. What happens if the user mistakenly provides a wrong location?
> I guess he can corrupt some other data structures?

Yes, if user is giving wrong ref_ctr_offset, uprobe infrastructure will
corrupt some user data.

> 
> Hence I would think twice of advertising this mechanism. i.e keep this
> as an undocumented feature.
> 

I don't mind.

Thanks,
Ravi
