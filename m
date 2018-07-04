From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Wed, 4 Jul 2018 02:16:52 -0700
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <c21db380-7dc0-2165-8616-8dcb519aa787@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703061612.GG65296@linux.vnet.ibm.com>
 <c21db380-7dc0-2165-8616-8dcb519aa787@linux.ibm.com>
Message-ID: <20180704091652.GA21902@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> I'm not sure if I get your concerns but let me try to explain what happens
> in such cases. please let me know if I misunderstood your point.
> 
> 1. Install a probe using perf.
>   # ./perf probe sdt_tick:loop2
> 
> 
> 
> Does this explain your concerns?
> 


No, this was not my concern.
My concern is with two users on the same USDT.
1. First user enables the probe point but doesn't increment the ref_cnt.
via uprobe_register

2. Second user tries to enable the probe point and also increments the
ref_cnt via uprobe_register_refctr.

3. If the second user now removes the probe point via uprobe_unregister.

4. What is the state of the ref_cnt?

--
Thanks and Regards
Srikar
