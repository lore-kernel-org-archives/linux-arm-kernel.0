From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Tue, 13 May 2014 11:56:01 -0700
Subject: maxcpus behavior in arm64
Message-ID: <53726AC1.9030207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

I notice that the maxcpus behavior is different in arm64 than from how 
arm uses it.
in arm64/kernel/smp.c - in smp_prepare_cpus, maxcpus is used to limit 
the cpu_present_mask.
However in arm/kernel/smp.c - maxcpus is not used as a decision maker to 
set the cpu_preset_mask.

Is this behavior expected and intentionally different in arm and arm64 ?
This also means that in arm64 (unlike arm)- maxcpus cannot be used to 
boot a subset of total cpus with the
option of getting the secondary cores online at a later point from 
userspace using hotplug.
It seems like maxcpus is being treated like nr_cpus in arm64 ?
Please could you help clarify this behavior and help us understand this 
better.

Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
