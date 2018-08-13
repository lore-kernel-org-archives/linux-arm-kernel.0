From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Mon, 13 Aug 2018 01:48:28 -0700
Subject: [PATCH v8 5/6] trace_uprobe/sdt: Prevent multiple reference
 counter for same uprobe
In-Reply-To: <20180809041856.1547-6-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-6-ravi.bangoria@linux.ibm.com>
Message-ID: <20180813084828.GA44470@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-09 09:48:55]:

> We assume to have only one reference counter for one uprobe.
> Don't allow user to add multiple trace_uprobe entries having
> same inode+offset but different reference counter.
> 
> Ex,
>   # echo "p:sdt_tick/loop2 /home/ravi/tick:0x6e4(0x10036)" > uprobe_events
>   # echo "p:sdt_tick/loop2_1 /home/ravi/tick:0x6e4(0xfffff)" >> uprobe_events
>   bash: echo: write error: Invalid argument
> 
>   # dmesg
>   trace_kprobe: Reference counter offset mismatch.
> 
> There is one exception though:
> When user is trying to replace the old entry with the new
> one, we allow this if the new entry does not conflict with
> any other existing entries.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---

Looks good to me.

Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
