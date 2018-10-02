From: hoan.tran@amperecomputing.com (Hoan Tran)
Date: Tue, 2 Oct 2018 23:46:45 +0000
Subject: [PATCH v2] perf: xgene: Add CPU hotplug support
In-Reply-To: <20181002114627.omsungd77lfmbqfj@lakrids.cambridge.arm.com>
References: <1537382649-17266-1-git-send-email-hoan.tran@amperecomputing.com>
 <20181002114627.omsungd77lfmbqfj@lakrids.cambridge.arm.com>
Message-ID: <5B51DDE7-B248-474D-8787-8127E73D82B1@amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> On Oct 2, 2018, at 4:46 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> [NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.] ________________________________________________________________________________________________________________________
> 
> Hi Hoan,
> 
> On Wed, Sep 19, 2018 at 06:44:30PM +0000, Hoan Tran wrote:
>> This patch adds CPU hotplug support where the PMU migrates the context to
>> another online CPU when its CPU is offline.
>> 
>> It fixes the below issue where the user does offline the CPU which is assigned
>> to this PMU.
>> 
>> Assuming, CPU0 is assigned for this PMU. When the user does offline CPU0
>> [root@(none) ~]# echo 0 > /sys/devices/system/cpu/cpu0/online
>> This PMU does not work anymore and shows the below error.
>> [root@(none) ~]# perf stat -a -e l3c0/cycle-count/,l3c0/write/ sleep 1
>> Error:
>> The sys_perf_event_open() syscall returned with 19 (No such device) for event (l3c0/cycle-count/).
>> /bin/dmesg may provide additional information.
>> No CONFIG_PERF_EVENTS=y kernel support configured?
>> 
>> With this patch, when CPU0 is offline, PMU migrates to another online CPU and
>> works on that CPU.
>> 
>> Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>
>> ---
>> v2:
>> * Remove the cpuhp instance when unregistering the PMU
> 
> Unfortunately, this has come through whitespae-damaged, with a
> disclaimer in the footer.
> 
> Could you please resend with those two details fixed?

I?ll fix it and send you another version later.

Thanks and Regards
Hoan

> 
> Thanks,
> Mark.
