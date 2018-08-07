From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 7 Aug 2018 18:03:20 +0530
Subject: [PATCH v7 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180807113622.GC19831@redhat.com>
References: <20180731035143.11942-1-ravi.bangoria@linux.ibm.com>
 <20180731035143.11942-4-ravi.bangoria@linux.ibm.com>
 <20180803112455.GA13794@redhat.com>
 <bfb47985-8f58-e5e4-f8b4-695dfea7937f@linux.ibm.com>
 <20180807113622.GC19831@redhat.com>
Message-ID: <4d1e2a17-14ba-f277-8e57-4a4573630ab2@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

>> I'm sorry. I didn't get this. How can uprobe go away without calling
>>     uprobe_unregister()
>>     -> rergister_for_each_vma()
>>        -> remove_breakpoint()
>> And remove_breakpoint() will get called
> 
> assuming that _unregister() will find the same vma with the probed insn. But
> as I said, the application can munmap the probed page/vma.

Got it now :)

Thanks.
