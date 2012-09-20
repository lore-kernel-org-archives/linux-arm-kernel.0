From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Sep 2012 16:02:48 +0200
Subject: [PATCH 01/10] ARM: KVM: Keep track of currently running vcpus
In-Reply-To: <001401cd972e$f18cd1c0$d4a67540$@samsung.com>
References: <20120915153657.21545.3972.stgit@ubuntu>
 <001401cd972e$f18cd1c0$d4a67540$@samsung.com>
Message-ID: <13e04ac2694ba74a724c2c7a59344d2f@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Sep 2012 21:53:33 +0900, Min-gyu Kim <mingyu84.kim@samsung.com>
wrote:
>> -----Original Message-----
>> From: kvm-owner at vger.kernel.org [mailto:kvm-owner at vger.kernel.org] On
>> Behalf Of Christoffer Dall
>> Sent: Sunday, September 16, 2012 12:37 AM
>> To: kvm at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> kvmarm at lists.cs.columbia.edu
>> Subject: [PATCH 01/10] ARM: KVM: Keep track of currently running vcpus
>> 
>> From: Marc Zyngier <marc.zyngier@arm.com>
>> 
>> When an interrupt occurs for the guest, it is sometimes necessary to
find
>> out which vcpu was running at that point.
>> 
>> Keep track of which vcpu is being tun in kvm_arch_vcpu_ioctl_run(), and
>> allow the data to be retrived using either:
>> - kvm_arm_get_running_vcpu(): returns the vcpu running at this point
>>   on the current CPU. Can only be used in a non-preemptable context.
> 
> What's the purpose of kvm_arm_get_running_vcpu?
> It seems to be enough to pass vcpu struct through function argument, 
> and there is no caller by now.

This is also designed to be used in an interrupt handler, and is used by
the (currently out of tree) perf code:
https://lists.cs.columbia.edu/pipermail/kvmarm/2012-September/003192.html

Basically, you need this infrastructure when handling interrupts.

        M.
-- 
Fast, cheap, reliable. Pick two.
